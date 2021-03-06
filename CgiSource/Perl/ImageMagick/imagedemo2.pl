#!/usr/local/bin/perl
#
# Make simple beveled button and output to STDOUT in GIF format
#
# a little more complex - the gradient colours are passed in as CGI parameters
#
# to embed this image in a web page, use:
# img src="imagedemo2.pl?colour1=ff0000&colour2=0000ff"

use Image::Magick;
use CGI;


my $query = new CGI; # create new CGI object
my $colour1 = ($query->param("colour1") or "ff0000");
my $colour2 = ($query->param("colour2") or "0000ff");

print "Content-type: image/gif\r\n\r\n";

$image=Image::Magick->new;
$image->Set(size=>'30x180');
$image->Read("gradient:#$colour1-#$colour2");
$image->Raise('3x3');
$image->Rotate(-90);
$image->Write('gif:-');
