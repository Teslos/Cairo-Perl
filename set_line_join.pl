#!/opt/local/bin/perl -w
use strict;
use Cairo;
my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

$cr->set_line_width(40.96);
$cr->move_to(76.8, 84.48);
$cr->rel_line_to(51.2, -51.2);
$cr->rel_line_to(51.2, 51.2);
$cr->set_line_join('miter');
$cr->stroke();

$cr->move_to(76.8, 161.28);
$cr->rel_line_to(51.2, -51.2);
$cr->rel_line_to(51.2, 51.2);
$cr->set_line_join('bevel');
$cr->stroke();

$cr->move_to(76.8, 238.08);
$cr->rel_line_to(51.2, -51.2);
$cr->rel_line_to(51.2, 51.2);
$cr->set_line_join('round');
$cr->stroke();

$surface->write_to_png('set_line_join.png')