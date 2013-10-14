#!/usr/bin/perl
## Test script for DrawTransmembraneSchematic.pm

use strict;
use warnings;
use lib 'lib';
use DrawTransmembraneSchematic;

## Create a hash and store topology, N-terminal and signal peptide information as follows
my %topology;

$topology{'TMHMM2.0'}{'topology'} = [5,22,46,68,89,111,135,157];
$topology{'TMHMM2.0'}{'n_term'} = 'in';

$topology{'PHOBIUS1.01'}{'signal'} = 22;
$topology{'PHOBIUS1.01'}{'topology'} = [45,67,88,109,135,156];
$topology{'PHOBIUS1.01'}{'n_term'} = 'out';

$topology{'PRODIV0.92'}{'topology'} = [5,25,46,66];
$topology{'PRODIV0.92'}{'n_term'} = 'out';

$topology{'PROFPHD'}{'topology'} = [3,20,46,65,87,106,138,155,166,183];
$topology{'PROFPHD'}{'n_term'} = 'in';

$topology{'SIGNALP3.0'}{'signal'} = 24;
$topology{'SIGNALP3.0'}{'topology'} = [];
$topology{'SIGNALP3.0'}{'n_term'} = 'out';

$topology{'MEMSAT3.0'}{'topology'} = [5,24,48,67,89,112,135,158];
$topology{'MEMSAT3.0'}{'n_term'} = 'out';


## Title, sequence and the order to display topologies:
my $title = 'DrawTransmembraneSchematic.pm Test';
my $fa = 'MANMFALILVIATLVTGILWCVDGQSLNAPTSGNFFFAPVAPNPGWLVTGASVFPVLAIVLIVRSFIYEPFQIPSGSMMPTLLIGEVPMANMFFALILVIATLVTGILWCVDGQSLNAPTSGKFFFAPVKPKPGWLVTGASVFPVLAIVLIVRSFIYEPFQIPSGSMMPTLLIGDFILVEKFAYGIKDPIYQKTLIETGHPKRGDIVVFKYPEDPKLDYIKRAVGLPGDKVTYDPVSKELTIQPGCSSGQACENALPVTYSNVEPSDFVQTFSRRNGGEATSGFFEVPKNETKENGIRLSERKETLGDVTHRILTVPIAQDQVGMYYQQPGQQLATWIVPPGQYFMMGDNRDNSADSRYWGFVPEANLVGRATAIWMSFDKQEGEWPTGLRLSRIGGIH';
my @order = ('MEMSAT3.0','PROFPHD','PRODIV0.92','PHOBIUS1.01','TMHMM2.0','SIGNALP3.0');

## If you want to use TTF fonts set this path and uncomment -ttf_font below
my $font = '/usr/share/fonts/msttcorefonts/arial.ttf';

my $im = DrawTransmembraneSchematic->new(-title=>$title,
					 #-order=>\@order,
					 #-ttf_font=>$font,
					 -inside_rgb=>[256,5,50],
					 -outside_rgb=>[140,399,70],
					 -signal_rgb=>[633,23,46],
					 -sequence=>$fa,
                     -topologies=>\%topology,
					 -signal_overides=>1,
					 -exclude_from_consensus=>'SIGNALP3.0');
my %hash;

$hash{'-method'} = 'MEMSAT4';
$hash{'-topology'}= [5,24,48,67,89,112,135,158];
$hash{'-n-term'} = 'out';
$hash{'-signal'} = 0;

$im->add_topology(%hash);

my $output = 'output/consensus_schematic.png';
open(OUTPUT, ">$output");
binmode OUTPUT;
print OUTPUT $im->png; 
close OUTPUT;

print "$output Created\n";

exit;
