#!/opt/local/bin/perl -w
use strict;
use Cairo;
use constant PI => 3.141592;

my $surface = Cairo::ImageSurface->create('argb32', 300, 300);
my $cr = Cairo::Context->create($surface);

$cr->select_font_face('sans', 'normal', 'bold');
$cr->set_font_size(90.0);

$cr->move_to(10.0, 135.0);
$cr->show_text("Hello");

$cr->move_to(70.0, 165.0);
$cr->text_path("void");
$cr->set_source_rgb(0.5, 0.5, 1);
$cr->fill_preserve();

$cr->set_source_rgb(0, 0, 0);
$cr->set_line_width(2.56);
$cr->stroke();

# draw helping lines
$cr->set_source_rgba(1, 0.2, 0.2, 0.6);
$cr->arc(10.0, 135.0, 5.12, 0, 2 * PI);
$cr->close_path();
$cr->arc(70.0, 165.0, 5.12, 0, 2 * PI);
$cr->fill();

$surface->write_to_png('text.png')
