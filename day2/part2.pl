#!/bin/perl

use strict;
use warnings;
use utf8;

use Data::Dumper;

# adventofcode - day 2 - part 2


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
    my $Multi = 0;

    my (@Parties) = split(/; /, $Line);
    $Parties[0] =~ s/Game \d+: //;

    foreach my $Round ( @Parties ) {
        my @Results = split(/, /, $Round);
        foreach my $ResultLine ( @Results ) {
            my ($Count, $Color) = split(/ /, $ResultLine);

            if ($Cubes->{$Color}) {
                if ($Count > $Cubes->{$Color}) {
                    $Cubes->{$Color} = $Count;
                }
            } else {
                # set when empty
                $Cubes->{$Color} = $Count;
            }
        }
    }

    $Multi = $Cubes->{'red'} * $Cubes->{'green'} * $Cubes->{'blue'};
    $Result += $Multi;

}

print "RESULT: $Result\n";