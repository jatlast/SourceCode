#!/usr/local/bin/perl -w
use CGI qw/:standard/;

use strict;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugUtilityFunctions  = "0";

print CGI::header('text/html');
print "<HTML>\n";

my $ProgramName = "FixUrl.cgi";

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, $DebugUtilityFunctions); 
# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
	}
else
	{
		$Map{'PROGRAM_NAME'} = $ProgramName;
	}

my @QueryStringParams;
my %QueryStringHash;

# Load the values passed in into the QueryStringHash...
@QueryStringParams = CGI::param();
%QueryStringHash = &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

# Since the url is not kept in tact we must regenerate it...
my $processed_url = $QueryStringHash{'turl'};
while( (my $Key, my $Value) = each(%QueryStringHash) )
{
	if($Key ne "turl")
	{
		print "<!-- $Key = ($Value) -->\n" if $DebugThisAp eq "1";
		$Value =~ s/ /+/g;
		if ($processed_url =~ m/\?$/) 
			{
				$processed_url = $processed_url . "$Key=$Value";
			}
		else
			{
				$processed_url = $processed_url . "&$Key=$Value";
			}
	}
}       

$processed_url =~ s/\'/%27/g;

print "<!-- processed_url = ($processed_url) -->\n" if $DebugThisAp eq "1";

if($processed_url ne "")
	{
		print "<BODY>\n";
		print "<SCRIPT LANGUAGE=JavaScript>\n";
		print "<!--\n";
		print "document.write(\"This window has an external domain that will cause problems while viewing our pages.<BR>A new window should have been opened.\")\n";

		print "window.open(\'$processed_url\')\n";
		print "window.close()\n";
#		print "window.setTimeout(\"self.close()\", 2000)\n";
		print "// -->\n";
		print "</SCRIPT>\n";
		print "If a new window did not open please copy and past the link below into your browser's Address Bar:<br><br>&nbsp;&nbsp;&nbsp;<FONT color=\"red\">$processed_url</FONT>\n";
		print "<NOSCRIPT>\n";
		print "<H3>To avoid this problem in the future please enable JavaScript</H3>\n";
		print "</NOSCRIPT>\n";
		print "</BODY>\n";
		print "</HTML>\n";
	}
else
	{
		# These 2 line need to be romoved for the program to be able to redirect properly...
		#Begin HTML so errors show up in browser...
		&UtilityFunctions::Adv_Print_Framed_Error("", "Unable to automatically redirect.<BR>Please proceed to the $Map{'WHICHCONNECTIONS'} home page: <A href=\"$Map{'CGIBIN'}/FixUrl.cgi?turl=$Map{'ROOT'}/index.html\">$Map{'ROOT'}/index.html</A>\n<BR>", $DebugUtilityFunctions, %Map);		
	}
exit 0;
