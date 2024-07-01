#!/usr/bin/perl -w
# a script to calculate distance (in xyz file) between two atoms, given their sequential numbers in a molecule
# the output distance is to the standard output.
# The user has to make sure that it is not a multimolecule xyz file, the program will report the calcuation for the first molecule encountered.
# V. Kairys, Life Sciences Center at  Vilnius University
#

use strict;
use warnings;

die "Usage: $0 Filename.xyz Number1 Number2\n" if(@ARGV!=3);


print STDERR "File: $ARGV[0]\n";
print STDERR "atom number 1: $ARGV[1], atom number 2: $ARGV[2]\n";
my $file=$ARGV[0];
my $nat1=$ARGV[1];
my $nat2=$ARGV[2];

my @crd1=();
my @crd2=();
open(MOLF,"<$file") or die "Error while opening $file $!\n";
while(<MOLF>){
        if($. == $nat1+2){
            chomp; my @tmp=split;
            print STDERR "atom 1 $.\n";
            print STDERR "$_\n";
            my $temp=shift(@tmp);
            @crd1=@tmp;
            #print STDERR "xyz: $crd1[0] $crd1[1] $crd1[2]\n";
        }
        if($. == $nat2+2){
            chomp; my @tmp=split;
            print STDERR "atom 2 $.\n";
            print STDERR "$_\n";
            my $temp=shift(@tmp);
            @crd2=@tmp;
            #print STDERR "xyz: $crd2[0] $crd2[1] $crd2[2]\n";
        }
}
close(MOLF);
my $distance=sqrt( ($crd1[0] - $crd2[0])**2 + ($crd1[1] - $crd2[1])**2 + ($crd1[2] - $crd2[2])**2 );
print STDERR "Calculated distance:\n";
print STDOUT "$distance\n";
