#!/usr/bin/perl
use strict;
use warnings;
use Storable;  # For loading the BLAST database

# Check if input arguments are correct
if (@ARGV != 4) {
    die "Usage: ./simple_blast.pl query.fa blastdb.dat word_size score\n";
}

my ($query_file, $db_file, $word_size, $score_threshold) = @ARGV;

# Read sequence from FASTA file
sub read_fasta {
    my ($filename) = @_;
    open(my $fh, '<', $filename) or die "Could not open file '$filename': $!";
    my $header = <$fh>;
    my $sequence = '';
    while (my $line = <$fh>) {
        chomp $line;
        $sequence .= $line unless $line =~ /^>/;
    }
    close $fh;
    return $sequence;
}

# Load BLAST database
sub load_db {
    my $db_file = shift;
    return retrieve($db_file);
}

# Extend alignment around seed hit and capture the actual alignment sequences
sub extend_alignment {
    my ($query, $subject, $q_pos, $s_pos) = @_;
    my $score = 0;
    my $alignment_len = 0;
    
    # Scoring matrix: match = +5, mismatch = -2
    my $match_score = 5;
    my $mismatch_score = -2;
    
    # For storing the actual alignment sequences
    my $query_aligned = '';
    my $subject_aligned = '';
    my $alignment_line = '';  # For indicating matches/mismatches

    # Extend to the right as long as there's a match or no negative score
    while ($q_pos < length($query) && $s_pos < length($subject)) {
        my $nuc1 = substr($query, $q_pos, 1);
        my $nuc2 = substr($subject, $s_pos, 1);

        if ($nuc1 eq $nuc2) {
            $score += $match_score;
            $alignment_line .= '|';  # Match indicator
        } else {
            $score += $mismatch_score;
            $alignment_line .= ' ';  # Mismatch indicator
        }

        $query_aligned .= $nuc1;
        $subject_aligned .= $nuc2;

        last if $score < 0;  # Stop extending if the score goes negative

        $q_pos++;
        $s_pos++;
        $alignment_len++;
    }

    return ($score, $query_aligned, $subject_aligned, $alignment_line);
}

# Main logic
my $query_sequence = read_fasta($query_file);

# Load the BLAST database
my $db = load_db($db_file);

my @alignments;

# Search for k-mer hits in the database
for (my $i = 0; $i <= length($query_sequence) - $word_size; $i++) {
    my $query_word = substr($query_sequence, $i, $word_size);
    
    if (exists $db->{$query_word}) {
        foreach my $s_pos (@{$db->{$query_word}}) {
            # Extend the alignment
            my ($score, $query_aligned, $subject_aligned, $alignment_line) = extend_alignment($query_sequence, $query_sequence, $i, $s_pos);
            push @alignments, [$score, $i, $s_pos, $query_aligned, $subject_aligned, $alignment_line] if $score >= $score_threshold;
        }
    }
}

# Sort alignments by score and print the top 10
@alignments = sort { $b->[0] <=> $a->[0] } @alignments;
my $max_output = 10;

print "Top $max_output local alignments (with score >= $score_threshold):\n";
for (my $i = 0; $i < $max_output && $i < @alignments; $i++) {
    my ($score, $q_pos, $s_pos, $query_aligned, $subject_aligned, $alignment_line) = @{$alignments[$i]};
    
    print "\nAlignment $i:\n";
    print "Score = $score, Query position = $q_pos, Subject position = $s_pos\n";
    print "Query:    $query_aligned\n";
    print "          $alignment_line\n";
    print "Subject:  $subject_aligned\n";
}
