#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.14;

my $surface = Cairo::ImageSurface->create('argb32',200,200);
my $cr = Cairo::Context->create($surface);

$cr->arc(128.0,128.0,76.8,0,2*PI);
$cr->clip();

$cr->new_path();
$cr->rectangle(0,0,256,256);
$cr->fill();

$cr->set_source_rgb(0,1,0);
$cr->move_to(0,0);
$cr->line_to(256,256);
$cr->move_to(256,0);
$cr->line_to(0,256);
$cr->set_line_width(10.0);
$cr->stroke();

$cr->show_page();
$surface->write_to_png('clip.png');
