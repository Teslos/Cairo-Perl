#!/opt/local/bin/perl -w
use strict;
use Cairo;

my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

my @dashes = (50.0,10.0,10.0,10.0);
my $offset = -50.0;

$cr->set_dash($offset, @dashes);
$cr->set_line_width(10.0);
$cr->move_to(128, 25.6);
$cr->line_to(230.4,230.4);
$cr->rel_line_to(-102.4,0.0);
$cr->curve_to(51.2,230.4,51.2,128.0,128.0,128.0);
$cr->stroke();

$cr->show_page;
$surface->write_to_png('dash.png');

