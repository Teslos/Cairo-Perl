#!/opt/local/bin/perl -w
# ∃teslos
use strict;
use Cairo;
use DateTime;
use Gtk2 '-init';
use Glib qw(TRUE FALSE);
use constant PI => 3.141592;

Glib::Timeout->add(1000, \&progress_timeout);

my ($width, $height) = (400, 200);
my $window = Gtk2::Window->new('toplevel');
$window->set_title('Analog clock');
$window->set_size_request($width, $height); 

my $surface  = create_image();

$window->signal_connect('delete_event' => sub { Gtk2->main_quit; });

my $drawable = Gtk2::DrawingArea->new;

$drawable->size($width, $height);
$drawable->signal_connect(
   'expose_event' => \&on_expose_event,
   $surface
);

$window->add($drawable);
$window->show_all;
Gtk2->main;

sub progress_timeout {
	my $w = $window->allocation->width;
	my $h = $window->allocation->height;
	my $update_rect = Gtk2::Gdk::Rectangle->new(0,0,$w,$h);
	$drawable->window->invalidate_rect($update_rect, FALSE);
	return TRUE;
}

sub time_now {
	my $dt = DateTime->now(time_zone=>'local');
	
	my $hours = $dt->hour;
	my $minutes = $dt->minute;
	my $secs = $dt->second;
	
	my $second_arc = (2 * PI / 60) * $secs;
	my $minute_arc = (2 * PI / 60) * $minutes;
	if ($hours > 12) {
		$hours = $hours - 12;
	}
	my $hour_arc = (2 * PI / 12) * $hours + $minute_arc / 12;
	return ($hour_arc, $minute_arc, $second_arc);
}

sub min($$) { return ($_[0] < $_[1] ? $_[0] : $_[1]);  }

sub draw_cursor {
	my ($cr, $color, $width_line, $length, $position) = @_;
	my $mid = min($width,$height);
	$cr->set_source_rgba($color->[0],$color->[1], $color->[2], $color->[3]);
    $cr->set_line_width($width_line);
	$cr->set_line_cap('round');
    $cr->move_to($width/2, $height/2);
    $cr->line_to($width/2 + $length * cos($position - PI/2),
    $height/2 + $length * sin($position - PI/2));
    $cr->stroke;
}

sub draw_arc {
	my($cr, $color, $w, $h, $radius) = @_;
	$cr->set_source_rgb( $color->[0], $color->[1], $color->[2] );
	$cr->arc($w, $h, $radius, 0, 2 * PI);
	$cr->fill;
	$cr->stroke;
}
	
sub create_image {
	my $surface = Cairo::ImageSurface->create( 'argb32', $width, $height );
	my $cr = Cairo::Context->create( $surface );
   
	$width = $window->allocation->width;
	$height = $window->allocation->height;
	my($hour_arc, $minute_arc, $second_arc) = time_now();
	
	my $mid = min($width,$height);
	
	# make a clock background 
	my @color_back = (0,0,0);
	draw_arc($cr, \@color_back, $width/2, $height/2, $mid/2 - 8 );
	
	@color_back = (0.5, 0.5, 0.5);
	draw_arc($cr, \@color_back, $width/2, $height/2, $mid/2 - 20 );
	
	# pointer hour
	my @color = (0.4, .78, 0.0, 0.5);  
	draw_cursor($cr, \@color, ($mid/2 - 20)/6, ($mid/2 - 20) * 0.6, $hour_arc);
   
	#pointer minute
	draw_cursor($cr, \@color, ($mid/2 - 20)/6 * .53, ($mid/2 - 20) * 0.8, $minute_arc);

	#pointer second
	my @color_sec = (1.0, 0.0, 0.0, 1.0);
	draw_cursor($cr, \@color_sec, ($mid/2 - 20)/6 * .2, ($mid/2 - 20), $second_arc);
	
	# center arc
	@color_back = (1, 1, 1);
	draw_arc($cr, \@color_back, $width/2, $height/2, ($mid/2 - 20)/12 );
	
	$cr->set_source_rgb(0, 0, 0);
	$cr->select_font_face("Sans-serif", 'normal', 'bold');
	$cr->set_font_size(10.0);
	$cr->move_to(10, $height - 10);
	$cr->show_text("teslos");
	$cr->fill;
	$cr->show_page;
   
	return $surface;
}

sub on_expose_event {
   my ($widget, $event, $surface) = @_;
   $surface  = create_image();
   my $cr = Gtk2::Gdk::Cairo::Context->create($widget->window);
   $cr->set_source_surface($surface, 0, 0);
   $cr->paint;
   
   return FALSE;
}
