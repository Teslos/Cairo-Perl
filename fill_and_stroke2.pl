#!/opt/local/bin/perl -w
use strict;
use Cairo;

my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

$cr->move_to(128.0, 25.6);
$cr->line_to(230.4, 230.4);
$cr->rel_line_to(-102.4, 0.0);
$cr->curve_to(51.2, 230.4, 51.2, 128.0, 128.0, 128.0);
$cr->close_path();

$cr->move_to(64.0, 25.6);
$cr->rel_line_to(51.2, 51.2);
$cr->rel_line_to(-51.2, 51.2);
$cr->rel_line_to(-51.2, -51.2);
$cr->close_path();

$cr->set_line_width(10.0);
$cr->set_source_rgb(0, 0, 1);
$cr->fill_preserve();
$cr->set_source_rgb(0, 0, 0);
$cr->stroke();

$surface->write_to_png('fill_and_stroke2.png');



