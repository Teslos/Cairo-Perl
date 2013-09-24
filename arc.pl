#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.14;

my ($xc,$yc) = 128.0;
my $radius = 100.0;
my $angle1 = 45.0 * (PI/180.0);
my $angle2 = 180.0 * (PI/180.0);

my $surface = Cairo::ImageSurface->create('argb32', 400,200);
my $cr = Cairo::Context->create($surface);

$cr->set_line_width(10.0);
$cr->arc($xc, $yc, $radius, $angle1, $angle2);

$cr->stroke();

# drawing helping lines 
$cr->set_source_rgb(0.2, 0.2, 0.6);
$cr->set_line_width(6.0);

$cr->arc($xc,$yc,10.0,0, 2*PI);
$cr->fill();

$cr->arc($xc,$yc,$radius, $angle1, $angle1);
$cr->line_to($xc,$yc);

$cr->arc($xc,$yc,$radius, $angle2, $angle2);
$cr->line_to($xc,$yc);
$cr->stroke();

$surface->write_to_png('arc.png');
