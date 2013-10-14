#!/usr/bin/perl
# Test script for DrawTransmembrane.pm

use strict;
use warnings;
use lib 'lib';
use Bio::Tools::Tmhmm;
use DrawTransmembrane;

my $im = DrawTransmembrane->new(-title=>'Let\'s parse some Tmhmm data...',
                                -bold_helices=> 1,
				                -n_terminal=> 'out');

## Parse tmhmm output
 
open(FILE, 'input/tmhmm.out');  

my $parser = new Bio::Tools::Tmhmm(-fh => \*FILE );
while(my $tmhmm_feat = $parser->next_result ) {

	## Load features into DrawTransmembrane object
	$im->add_tmhmm_feat($tmhmm_feat);

}

close FILE;

## Write to a .png file

my $output = 'output/draw_transmembrane_tmhmm.png';

print "\nGenerating image $output\n\n";

open(OUTPUT, ">$output");

binmode OUTPUT;

print OUTPUT $im->png; 

close OUTPUT;


exit;
