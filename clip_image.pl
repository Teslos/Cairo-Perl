#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.14;

my $surface = Cairo::ImageSurface->create('argb32', 200,200);
my $cr = Cairo::Context->create($surface);

$cr->arc(128.0,128.0,76.8,0, 2*PI);
$cr->clip();
$cr->new_path(); # path not consumed by clip

my $image = Cairo::ImageSurface->create_from_png("poplav.png");
my $w = $image->get_width();
my $h = $image->get_height();
$cr->scale(256.0/$w,256.0/$h);
$cr->set_source_surface($image,0,0);
$cr->paint();

$surface->write_to_png('clipimage.png');
