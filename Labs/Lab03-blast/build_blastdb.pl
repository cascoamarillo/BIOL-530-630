#!/usr/bin/perl
use strict;
use warnings;
use Storable;  # For saving and loading database

# Check if input arguments are correct
if (@ARGV != 1) {
    die "Usage: ./build_blastdb.pl database.fa\n";
}

my $db_file = $ARGV[0];

# Read sequence from FASTA file
sub read_fasta {
    my ($filename) = @_;
    open(my $fh, '<', $filename) or die "Could not open file '$filename': $!";
    my $header = <$fh>;  # skip the header line
    my $sequence = '';
    while (my $line = <$fh>) {
        chomp $line;
        $sequence .= $line unless $line =~ /^>/;  # skip headers
    }
    close $fh;
    return $sequence;
}

# Build database of k-mers
sub build_db {
    my ($sequence, $w) = @_;
    my %db;
    for (my $i = 0; $i <= length($sequence) - $w; $i++) {
        my $word = substr($sequence, $i, $w);
        push @{$db{$word}}, $i;  # Store the start positions of each k-mer
    }
    return \%db;
}

# Main logic
my $sequence = read_fasta($db_file);
my $word_size = 3;  # Default word size (can be adjusted)
my $db = build_db($sequence, $word_size);

# Save the database to a file
store($db, 'blastdb.dat');
print "BLAST database built and saved to 'blastdb.dat'.\n";
