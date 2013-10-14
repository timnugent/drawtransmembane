#!/usr/bin/perl
# Test script for DrawTransmembrane.pm

use strict;
use warnings;
use lib 'lib';
use DrawTransmembrane;

my ($hash,%labels);

## Here's some data from a few different topology prediction methods for the protein CLN3
$hash->{'SPEP_TMHMM2.0'}{'n_term'} = 'out'; 
$hash->{'SPEP_TMHMM2.0'}{'topology'} = 'A.38,60;B.99,121,C.128,150,D.154,176,E.183,202,F.212,231,G.281,303,H.318,337,I.344,366,J.371,393,K.406,428';
$hash->{'SPEP_PRODIV_TMHMM_0.91'}{'n_term'} = 'in';
$hash->{'SPEP_PRODIV_TMHMM_0.91'}{'topology'} = 'A.36,56;B.97,117;C.124,144;D.153,173;E.180,200;F.211,231;G.277,297;H.318,338;I.345,365;J.371,391;K.407,427';
$hash->{'SPEP_MEMSAT'}{'n_term'} = 'out';
$hash->{'SPEP_MEMSAT'}{'topology'} = 'A.38,58;B.98,119;C.128,144;D.152,172;E.180,202;F.213,231;G.281,298;H.345,361;I.371,390;J.407,430';
$hash->{'SPEP_ENSEMBLE_1.0'}{'n_term'} = 'in';
$hash->{'SPEP_ENSEMBLE_1.0'}{'topology'} = 'A.36,60;B.99,120;C.125,159;E.192,206;F.209,230;G.276,298;H.320,334;I.340,368;J.370,385;K.416,433';
$hash->{'PHOBIUS'}{'n_term'} = 'out';
$hash->{'PHOBIUS'}{'topology'} = 'A.39,59;B.98,122;C.128,145;D.152,175;E.181,200;F.212,230;G.281,298;H.344,365;I.371,390'; 

## Here are our labels, some experimentally determined constraints
%labels = ( 1   => '1 - 33 Cytoplasmic',
            71  => 'N71 Glycosylated/Lumenal',
            85  => 'N85 Glycosylated/Lumenal',
            310 => 'N310 Glycosylated/Lumenal',      
            199 => '199 Lumenal',
            242 => '242 - 264 Cytoplasmic',
	        321 => '321 Lumenal',
	        401 => '401 Cytoplasmic',
	        435 => 'C435 Prenylated',
	         12 => '12 Phosphorylation Site',
	         69 => '69 Phosphorylation Site',
	         14 => '14 Phosphorylation Site',
             19 => '19 Phosphorylation Site',	      
             73 => '73 Phosphorylation Site',
	         88 => '88 Phosphorylation Site',
            232 => '232 Phosphorylation Site',
	        270 => '270 Phosphorylation Site');

foreach (keys %$hash){

	my $output = "output/".$_.'_CLN3.png';

	print "\nGenerating image $output";
	
	my $title = "CLN3 topology prediction using $_";

	my $im = DrawTransmembrane->new(-title=>$title,
	                                -n_terminal=>$hash->{$_}{'n_term'},
					                -topology_string=>$hash->{$_}{'topology'},
					                -labels=> \%labels,
					                -text_offset=>-25,
					                -outside_label=>'Lumen',
					                -inside_label=>'Cytoplasm',
					                -membrane_label=>'Membrane',
					                -vertical_padding=>200,
					                -horizontal_padding=>170,
					                -n_terminal_offset=>50,
					                -n_terminal_height=>220,
					                -c_terminal_offset=>30,
					                -c_terminal_height=>220,
					                -helix_label=>'HELIX',
					                -colour_scheme=>'yellow');	
	## Write to a .png file
		
	open(OUTPUT, ">$output");	
	binmode OUTPUT;	
	print OUTPUT $im->png; 	
	close OUTPUT;

}
print "\n\n";

exit;
