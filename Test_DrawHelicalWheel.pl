#!/usr/bin/perl
# Test script for DrawHelicalWheel.pm

use strict;
use warnings;
use lib 'lib';
use DrawHelicalWheel;

my $title = 'Aquaporin-4 (AQP-4) water channel';
my $sequence = 'MSDGAAARRWGKCGPPCSRESIMVAFKGVWTQAFWKAVTAEFLAMLIFVLLSVGSTINWGGSENPLPVDMVLISLCFGLSIATMVQCFGHISGGHINPAVTVAMVCTRKISIAKSVFYITAQCLGAIIGAGILYLVTPPSVVGGLGVTTVHGNLTAGHGLLVELIITFQLVFTIFASCDSKRTDVTGSVALAIGFSVAIGHLFAINYTGASMNPARSFGPAVIMGNWENHWIYWVGPIIGAVLAGALYEYVFCPDVELKRRLKEAFSKAAQQTKGSYMEVEDNRSQVETEDLILKPGVVHVIDIDRGDEKKGKDSSGEVLSSV';
my @helices = (34,56,70,88,136,178,189,203,231,252);

my $im = DrawHelicalWheel->new(-title=>$title,
                               -sequence=>$sequence,
                               -helices=>\@helices);	

print "Generating PNG image output/aquaporin.png\n";
open(OUTPUT, ">output/aquaporin.png");
binmode OUTPUT;
print OUTPUT $im->png; 
close OUTPUT;

print "Generating SVG image output/aquaporin.svg\n";
open(OUTPUT, ">output/aquaporin.svg");
binmode OUTPUT;
print OUTPUT $im->svg; 
close OUTPUT;

exit;
