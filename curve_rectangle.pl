#!/opt/local/bin/perl -w
use strict;
use Cairo;

# parameters like cairo_rectangle
my ($x0,$y0,$rect_width,$rect_height,$radius) = (25.6,25.6, 204.8,204.8,102.4);

my $x1 = $x0+$rect_width;
my $y1 = $y0+$rect_height;

my $surface = Cairo::ImageSurface->create('argb32', 400,400);
my $cr = Cairo::Context->create($surface);

return if (!$rect_width || !$rect_height); 
if ($rect_width/2 < $radius) {
    if ($rect_height/2 < $radius) {
        $cr->move_to($x0, ($y0+$y1)/2);
        $cr->curve_to($x0,$y0,$x0,$y0,($x0+$x1)/2,$y0);
        $cr->curve_to($x1,$y0,$x1,$y0,$x1,($y0+$y1)/2);
        $cr->curve_to($x1,$y1,$x1,$y1,($x0+$x1)/2,$y1);
        $cr->curve_to($x0,$y1,$x0,$y1,$x0,($y0+$y1)/2);
    } else {
        $cr->move_to($x0,$y0+$radius);
        $cr->curve_to($x0,$y0,$x0,$y0,($x0+$x1)/2,$y0);
        $cr->curve_to($x1,$y0,$x1,$y0,$x1,$y0+$radius);
        $cr->line_to($x1,$y1-$radius);
        $cr->curve_to($x1,$y1,$x1,$y1,($x1+$x0)/2,$y1);
        $cr->curve_to($x0,$y1,$x0,$y1,$x0,$y1-$radius);
    } 
} else {
    if ($rect_height/2 < $radius) {
        $cr->move_to($x0,($y0+$y1)/2);
        $cr->curve_to($x0,$y0,$x0,$y0,$x0+$radius,$y0);
        $cr->line_to($x1-$radius,$y0);
        $cr->curve_to($x1,$y0,$x1,$y0,$x1, ($y0+$y1)/2);
        $cr->curve_to($x0,$y0,$x0,$y0,$x0+$radius,$y0);
        $cr->line_to($x0+$radius,$y1);
        $cr->curve_to($x0,$y1,$x0,$y1,$x0,($y1+$y0)/2);
    } else {
        $cr->move_to($x0,$y0+$radius);
        $cr->curve_to($x0,$y0,$x0,$y0,$x0+$radius,$y0);
        $cr->line_to($x1-$radius,$y0);
        $cr->curve_to($x1,$y0,$x1,$y0,$x1,$y0+$radius);
        $cr->line_to($x1,$y1-$radius);
        $cr->curve_to($x1,$y1,$x1,$y1,$x1-$radius,$y1);
        $cr->line_to($x0+$radius,$y1);
        $cr->curve_to($x0,$y1,$x0,$y1,$x0,$y1-$radius);
    }
}

$cr->close_path();
$cr->set_source_rgb(0.5,.5,1);
$cr->fill_preserve();
$cr->set_source_rgba(0.5,0,0,0.5);
$cr->set_line_width(10.0);
$cr->stroke();

$cr->show_page;
$surface->write_to_png('curve_rectangle.png');


        
         
        
        


