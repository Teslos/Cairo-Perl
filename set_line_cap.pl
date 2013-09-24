#!/opt/local/bin/perl -w
use strict;
use Cairo;
my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

$cr->set_line_width(30.0);
$cr->set_line_cap('butt');
$cr->move_to(64.0, 50.0);
$cr->line_to(64.0, 200.0);
$cr->stroke();

$cr->set_line_cap('round');
$cr->move_to(128.0, 50.0);
$cr->line_to(128.0, 200.0);
$cr->stroke();

$cr->set_line_cap('square');
$cr->move_to(192.0, 50.0);
$cr->line_to(192.0, 200.0);
$cr->stroke();

# drawing helping lines
$cr->set_source_rgb(1, 0.2, 0.2);
$cr->set_line_width(2.56);
$cr->move_to(64.0, 50.0);
$cr->line_to(64.0, 200.0);
$cr->move_to(128.0, 50.0);
$cr->line_to(128.0, 200.0);
$cr->move_to(192.0, 50.0);
$cr->line_to(192.0, 200.0);
$cr->stroke();

$surface->write_to_png('set_line_caps.png')
