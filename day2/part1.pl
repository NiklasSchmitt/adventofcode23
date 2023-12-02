#!/bin/perl

use strict;
use warnings;
use utf8;

use Data::Dumper;

# adventofcode - day 2 - part 1


my $File  = 'examples.txt';
# my $File  = 'input.txt';

my %CubesInBag = (
    'red'   => 12,
    'green' => 13,
    'blue'  => 14,
);
my $Result = 0;

open (my $IO, '<', $File) or die "Could not open $File!";
while( my $Line = <$IO> ) {
    chomp $Line;
    print STDERR Dumper $Line;

    my $Cubes;
    my ($Game) = $Line =~ /^Game (\d+):/;
    my $Possible = 1;

    my (@Parties) = split(/; /, $Line);
    $Parties[0] =~ s/Game \d+: //;

    foreach my $Round ( @Parties ) {
        my @Results = split(/, /, $Round);
        foreach my $ResultLine ( @Results ) {
            my ($Count, $Color) = split(/ /, $ResultLine);

            if ($Cubes->{$Color}) {
                $Cubes->{$Color} += $Count;
            } else {
                $Cubes->{$Color} = $Count;
            }


            if ($Count <= $CubesInBag{$Color} && $Possible != 0) {
                $Possible = 1;
            } else {
                $Possible = 0;
            }

        }

        foreach my $Color ( qw(red blue green) ) {
            if ($Cubes->{$Color} <= $CubesInBag{$Color} && $Possible != 0) {
                $Possible = 1;
            } else {
                $Possible = 0;
            }
        }
    }

    print STDERR "  Possible: $Possible\n";

    if ($Possible == 1) {
        $Result += $Game;
        #print STDERR "  Result: $Result\n";
    }

}

print "RESULT: $Result\n";