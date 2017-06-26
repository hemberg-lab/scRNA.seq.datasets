use strict;
use warnings;

if (@ARGV < 1) {die "Please provide a GEO series matrix file for a single-cell RNASeq experiment.\n"}

open(my $ifh, $ARGV[0]) or die $!;

my @FILES = ();
while (<$ifh>) {
        if ($_ =~ /^!Series_geo_accession\s+"(GSE\d+)"/) {
                print STDERR "Acc: $1\n";
        }
        if ($_ =~ /^!Series_last_update_date\s+"([\w\s]+)"/) {
                print STDERR "Date: $1\n";
        }
        if ($_ =~ /^!Sample_title/ ) {
                $_ =~ s/^!\w+\t//g;
                print $_;
        }
        if ($_ =~ /^!Sample_source/ ) {
                $_ =~ s/^!\w+\t//g;
                print "Source\t".$_;
        }
        if ($_ =~ /^!Sample_organism/ ) {
                $_ =~ s/^!\w+\t//g;
                print "Species\t".$_;
        }
        if ($_ =~ /^!Sample.+\.csv.gz/ || $_ =~ /^!Sample.+\.txt.gz/ ) {
                $_ =~ s/^!\w+\t//g;
                $_ =~ s/"//g;
                my @files = split("\t",$_);
                my @tmp = ();
                foreach my $file (@files) {
                        system("wget $file");
                        $file =~ /([^\/]+)$/;
                        my $File = $1;
                        if ($File =~ /\.gz$/) {
                                system("gunzip $File");
                                $File =~ s/\.gz$//g;
                        }

                        push(@tmp,$File);
                }
                push(@FILES, @tmp);
                print "File\t".join("\t",@tmp);
        }
        if ($_ =~ /^!Sample_characteristics/ ) {
                $_ =~ s/^!\w+\t//g;
                my $name = "characteristic";
                if ($_ =~ /"([\w\s]+):\s*/) {
                        $name = $1;
                        $_ =~ s/"([\w\s]+):\s*/"/g;
                }
                print "\"$name\"\t".$_;
        }
} close($ifh);

my %ExprMat = ();
my $gene_col = 0;
my $exp_col = 1;
for(my $i = 0; $i < scalar(@FILES); $i++) {
        my $File = $FILES[$i];
        open(my $fh, $File) or die $!;
        while (<$fh>) {
                my @record = split(/\t/,$_);
                if ($record[$exp_col] =~ /^[\d\s]+$/) {
                        my $val = $record[$exp_col];
                        $val =~ s/\s+//g;
                        $ExprMat{$record[$gene_col]}->{$File} = $val;
                }
        }
        close($fh);
#       $FILES[$i] = $File;
        system("rm $File");
}

open(my $ofh, ">","ExprMat.txt") or die $!;
print $ofh ( join("\t",@FILES) );
foreach my $gene (sort(keys(%ExprMat))) {
        print $ofh ("$gene");
        foreach my $f (@FILES) {
                my $expr = 0;
                if (exists($ExprMat{$gene}->{$f})) {
                        $expr = $ExprMat{$gene}->{$f};
                }
                print $ofh ("\t$expr");
        }
        print $ofh "\n";
}
close($ofh);
