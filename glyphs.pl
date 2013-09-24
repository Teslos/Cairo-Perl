#!/opt/local/bin/perl -w
use strict;
use Cairo;
my $surface = Cairo::ImageSurface->create('argb32', 600, 300);
my $cr = Cairo::Context->create($surface);

$cr->select_font_face('serif', 'normal', 'normal');
$cr->set_font_size(13);
my @glyphs = ();
my $index = 0;

for my $y (0..20) {
	for my $x (0..35) {
		push @glyphs, {index=>$index, x=>$x*15 + 20, y=>$y*18 + 20};
		$index ++;
	}
} 

$cr->show_glyphs(@glyphs);

$surface->write_to_png('glyphs.png')