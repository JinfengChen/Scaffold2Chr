#!/usr/bin/perl
use Getopt::Long;
use warnings;
#use strict;
GetOptions (\%opt,"gff:s", "anno:s", "project:s", "help");


my $help=<<USAGE;
Assign gene code to gene and transcripts according to chromosome postion.
We start from ObXXg10010 for each chromosome and increace by 10 every gene.
The transcript id is ObXXg10010.1 for each gene since we have only one transcript for each gene.
perl $0 --gff --anno
--gff
USAGE


if ($opt{help} or keys %opt < 1){
    print "$help\n";
    exit();
}

my $anno = readanno($opt{anno});
my ($gene,$pos,$gene2trans)=MakerGFF($opt{gff});
my $filtergff=$1 if ($opt{gff}=~/(.*)\.gff/);
##sort by position on chromosome
##
my %count;
my $chrcode;
open CODE, ">$filtergff.v1.code" or die "$!";
open OUT, ">$filtergff.v1.gff" or die "$!";
foreach my $chr (sort {$a cmp $b} keys %$pos){
  #print "$chr\n";
  my $chrcode=$chr;
  $chrcode=~s/\D+//g;
  $chrcode="HEG4_Os$chrcode";
  my @chrgene=@{$pos->{$chr}};
  my @sortchrgene=sort {$a->[1] <=> $b->[1]} @chrgene;
  my $genecode="10000";
  foreach my $g (@sortchrgene){
    $g=$g->[0];
    $genecode+=10;
    my $tempgcode=$chrcode."g".$genecode;
    print CODE "$g\t$tempgcode\n";
    my @tempgene=split("\t",$gene->{'gene'}->{$g});
    $tempgene[8]="ID=$tempgcode;Name=$anno->{$g};";
    $tempgene[1]=$opt{project} ? $opt{project} : $tempgene[1];
    my $tempgeneline=join("\t",@tempgene);
    print OUT "$tempgeneline\n";
    #print "$g\n";
    my $tcount=0;
    foreach my $t (@{$gene2trans->{$g}}){
       my $len;
       my @mrna;
       my $ref;
       my $strand;
       my $project;
       $tcount++;
       $temptcode=$tempgcode.".".$tcount;
       print CODE "$t\t$temptcode\n";
       my $tempmRNA = $gene->{'mRNA'}->{$t};
       my @tempmRNAunit = split("\t",$tempmRNA);
       $tempmRNAunit[8]="ID=$temptcode;Parent=$tempgcode;";
       my $newmRNA  = join("\t",@tempmRNAunit);
       print OUT "$newmRNA\n";
      
       #print "$g\t$t\t$tempgcode\t$temptcode\n";
       foreach my $e (@{$gene->{'CDS'}->{$t}}){
          my @unit=split("\t",$e);
          $ref=$unit[0];
          $project=$opt{project} ? $opt{project} : $unit[1];
          $unit[1]=$project;
          $strand=$unit[6];
          $len+=$unit[4]-$unit[3]+1;
          $unit[8]="ID=$temptcode:$unit[2];Parent=$temptcode;";
          push (@mrna,[@unit]);
       }
       #######write transcript to file
       foreach my $templine (@mrna){
          my $line=join("\t",@$templine);
          print OUT "$line\n";
       }
    }
 }
}
close OUT;
close CODE;

sub readanno
{
my ($file)=@_;
my %hash;
open IN, "$file" or die "$!";
while(<IN>){
    chomp $_;
    next if ($_=~/^$/);
    my @unit=split("\t",$_);
    #print "$unit[0]\n";
    my $gene = $1 if $unit[0]=~/(.*)-mRNA-\d+/;
    $hash{$gene}=$unit[1];
}
close IN;
return \%hash;
}

sub MakerGFF
{
my ($gff)=@_;
####read gff formated from Maker gff and store inf as gene->mrna->CDS/exon/utr
my %gene; ### store all gff line
my %pos;
my %gene2trans;
open IN, "$gff" or die "$!";
while (<IN>){
    chomp $_;
    next if ($_=~/^#/);
    my $record=$_;
    my @unit=split("\t",$_);
    if ($unit[2]=~/gene/){
        if ($unit[8]=~/ID=(.*?);/){
           $gene{'gene'}{$1}=$record;
           push (@{$pos{$unit[0]}},[$1,$unit[3],$unit[4],$unit[6]]);
        }
    }elsif($unit[2]=~/mRNA/){
        if ($unit[8]=~/ID=(.*?);Parent=(.*?);/){
            $gene{'mRNA'}{$1}=$record;
            push @{$gene2trans{$2}}, $1;
        }
    }elsif($unit[2] eq "CDS" or $unit[2] eq "exon" or $unit[2] =~ /UTR/){
        if($unit[8]=~/Parent=(.*?);*$/){
            push @{$gene{'CDS'}{$1}}, $record;
        }
    }

}
close IN;
return (\%gene,\%pos,\%gene2trans);
}

