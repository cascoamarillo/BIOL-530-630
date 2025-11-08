# Blastn

Simple perl implementation of BLAST-like algorithm using DNA sequences (query and database) with simple soring systems
Match
Mismatch


# blastn.pl 
#no need to create a blast like database (word size)
Usage: ./blastn.pl seq1.fa seq2.fa

eg.
```
perl blastn.pl Chlp_gene_nt.fa NC_014267.fasta 
Best local alignment score: 67
Seq1: ATGACAGGTCCAAATCCAAATAAACAAGCAGTCGAATTAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAAGTTACTTTTTCAATTAA
Seq2: ACTAAGATTCTCAATTCTTTGACATTTCCCCGTTTTGTAATTCCTATGGTTTGAAACTGGAAAGAAGTTTTCTTCTCAGAGTTAGAGAGAGTTCAGTTTTTTGAAGTTGACTTAGAA
```



For building a blast database:

# build_blastdb.pl

Usage: ./build_blastdb.pl database.fa

BLAST database built and saved to 'blastdb.dat

# simple_blast.pl

```
perl simple_blastn.pl Chlp_gene_nt.fa blastdb.dat 3    
Top 10 local alignments:
Alignment 0: score = 400, query_pos = 37, subject_pos = 37
Alignment 1: score = 85, query_pos = 20, subject_pos = 37
Alignment 2: score = 62, query_pos = 36, subject_pos = 8
Alignment 3: score = 61, query_pos = 88, subject_pos = 75
Alignment 4: score = 31, query_pos = 14, subject_pos = 108
Alignment 5: score = 28, query_pos = 89, subject_pos = 50
Alignment 6: score = 28, query_pos = 89, subject_pos = 83
Alignment 7: score = 27, query_pos = 38, subject_pos = 99
Alignment 8: score = 24, query_pos = 20, subject_pos = 80
Alignment 9: score = 23, query_pos = 68, subject_pos = 83
```

AND
# simple_blastn_hits.pl 

Usage: ./simple_blast.pl query.fa blastdb.dat word_size

perl simple_blastn.pl Chlp_gene_nt.fa blastdb.dat 3 

Sort alignments by score and print the top 10

```
perl simple_blastn_hits.pl Chlp_gene_nt.fa blastdb.dat 3 
Top 10 local alignments:

Alignment 0:
Score = 400, Query position = 37, Subject position = 37
Query:    TAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAAGTTACTTTTTCAATTAA
          ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
Subject:  TAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAAGTTACTTTTTCAATTAA

Alignment 1:
Score = 85, Query position = 20, Subject position = 37
Query:    TAAACAAGCAGTCGAATTAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAA
          |||| |    |||   |||    | || |   || | |   |  ||      ||| || |      | | ||    | ||
Subject:  TAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAAGTTACTTTTTCAATTAA

Alignment 2:
Score = 62, Query position = 36, Subject position = 8
Query:    TTAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGTATTATTTTCAAGTTACTTTTTCAATTAA
          |  ||    |  | |     | |  || ||  ||  |   |   ||||   |     |||   | ||  | ||| |     
Subject:  TCCAAATCCAAATAAACAAGCAGTCGAATTAAATAGAACGTCACTTTACTGGGGACTTTTATTAATTTTTGTTTTAGCAGT

Alignment 3:
Score = 61, Query position = 88, Subject position = 75
Query:    TATTATTTTCAAGTTACTTTTTCAATTAA
          | |  |||   |||    ||||||| | |
Subject:  TTTGTTTTAGCAGTATTATTTTCAAGTTA
```

