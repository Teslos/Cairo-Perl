#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.141592;
my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

my $utf8 = "cairo";
$cr->select_font_face('sans', 'normal', 'normal');
$cr->set_font_size(100.0);
my $extents = $cr->text_extents($utf8);

my $x = 25.0;
my $y = 150.0;

$cr->move_to($x, $y);
$cr->show_text($utf8);

# draw helping lines
$cr->set_source_rgba(1, 0.2, 0.2, 0.6);
$cr->set_line_width(6.0);
$cr->arc($x, $y, 10.0, 0, 2 * PI);
$cr->fill();
$cr->move_to($x, $y);
$cr->rel_line_to(0, -$extents->{'height'});
$cr->rel_line_to($extents->{'width'}, 0);
$cr->rel_line_to($extents->{'x_bearing'},-$extents->{'y_bearing'});
$cr->stroke();

$surface->write_to_png('text_align_center.png')

