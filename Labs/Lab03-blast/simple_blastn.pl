#!/usr/bin/perl
use strict;
use warnings;
use Storable;  # For loading the BLAST database

# Check if input arguments are correct
if (@ARGV != 3) {
    die "Usage: ./simple_blast.pl query.fa blastdb.dat word_size\n";
}

my ($query_file, $db_file, $word_size) = @ARGV;

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

# Extend alignment around seed hit
sub extend_alignment {
    my ($query, $subject, $q_pos, $s_pos) = @_;
    my $score = 0;
    my $alignment_len = 0;
    
    # Scoring matrix: match = +5, mismatch = -2
    my $match_score = 5;
    my $mismatch_score = -2;

    # Extend to the right
    while ($q_pos < length($query) && $s_pos < length($subject)) {
        my $nuc1 = substr($query, $q_pos, 1);
        my $nuc2 = substr($subject, $s_pos, 1);

        if ($nuc1 eq $nuc2) {
            $score += $match_score;
        } else {
            $score += $mismatch_score;
        }

        last if $score < 0;  # Stop extending if the score goes negative

        $q_pos++;
        $s_pos++;
        $alignment_len++;
    }

    return $score;
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
            my $score = extend_alignment($query_sequence, $query_sequence, $i, $s_pos);
            push @alignments, [$score, $i, $s_pos];
        }
    }
}

# Sort alignments by score and print the top 10
@alignments = sort { $b->[0] <=> $a->[0] } @alignments;
my $max_output = 10;

print "Top $max_output local alignments:\n";
for (my $i = 0; $i < $max_output && $i < @alignments; $i++) {
    my ($score, $q_pos, $s_pos) = @{$alignments[$i]};
    print "Alignment $i: score = $score, query_pos = $q_pos, subject_pos = $s_pos\n";
}
