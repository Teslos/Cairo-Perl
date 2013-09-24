#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.141592;

my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

my $pat = Cairo::LinearGradient->create(0.0, 0.0, 0.0, 256.0);
$pat->add_color_stop_rgba(1, 0, 0, 0, 1);
$pat->add_color_stop_rgba(0, 1, 1, 1, 1);
$cr->rectangle(0, 0, 256, 256);
$cr->set_source($pat);
$cr->fill();

$pat = Cairo::RadialGradient->create(115.2, 102.4, 25.6,
        102.4, 102.4, 128.0);
$pat->add_color_stop_rgba(0, 1, 1, 1, 1);
$pat->add_color_stop_rgba(1, 0, 0, 0, 1);
$cr->set_source($pat);
$cr->arc(128.0, 128.0, 76.8, 0, 2 * PI);
$cr->fill();

$surface->write_to_png('gradient.png');



