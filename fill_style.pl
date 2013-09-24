#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.14159;

my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

$cr->rectangle(12, 12, 232, 70);
$cr->new_sub_path();
$cr->arc(64, 64, 40, 0, 2 * PI);
$cr->new_sub_path();
$cr->arc_negative(192, 64, 40, 0, -2 * PI);

$cr->set_fill_rule("even-odd");
$cr->set_source_rgb(0,0.7,0);
$cr->fill_preserve();
$cr->set_source_rgb(0,0,0); 
$cr->stroke();
$cr->translate(0,128);
$cr->rectangle(12,12,232,70);
$cr->new_sub_path(); $cr->arc(64,64,40,0,2*PI);
$cr->new_sub_path(); $cr->arc_negative(192,64,40,0,-2*PI);

$cr->set_fill_rule("winding");
$cr->set_source_rgb(0,0,0.9); $cr->fill_preserve();
$cr->set_source_rgb(0,0,0); $cr->stroke();


$surface->write_to_png('fill_style.png');


