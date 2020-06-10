#!/usr/local/bin/perl -w

use strict;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "CgiFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugUtilityFunctions  = "0";

my $ProgramName = "FlirtHome.cgi";

#Begin HTML so errors show up in browser...
print CGI::header('text/html');
print "<HTML>\n";

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
		my @QueryStringParams;
		my %QueryStringHash;

		my $cookie_name    	= &CgiFunctions::Get_Cookie_Value("cookie_name"	   , $DebugCgiFunctions);
		my $cookie_password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

		if ($cookie_name eq "" or $cookie_password eq "") 
			{
				&UtilityFunctions::Print_Framed_Error("<a href=\"/CreateLogin.html\"><img src=\"../images/PC_Flirt_Intro_Login.gif\" width=\"630\" height=\"501\" border=\"0\"></a>", $DebugUtilityFunctions, %Map) if($cookie_password eq "");
			}
		else
			{
				&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
				# Load the values passed in into the QueryStringHash...
		#		@QueryStringParams = CGI::param();
		#		%QueryStringHash = &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

				print "      <DIV> \n";
				print "        <table width=\"100%\" height=\"630\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
				print "          <tr> \n";
				print "            <td height=\"507\"><a href=\"FlirtCreateProfile.cgi\"><img src=\"../images/PC_Flirt_Intro_LoggedIn.gif\" width=\"630\" height=\"501\" border=\"0\"></a></td>\n";
				print "          </tr>\n";
				print "          <tr> \n";
				print "            <td height=\"106\">\n";
				print "			     <TABLE WIDTH=585 BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
				print "                <TR> \n";
				print "                  <TD> <img src=\"../images/FlirtStepsOff_01.gif\" alt=\"\"></TD>\n";
				print "                  <TD> <IMG SRC=\"../images/FlirtStepsOff_02.gif\" ALT=\"\"></TD>\n";
				print "                  <TD> <IMG SRC=\"../images/FlirtStepsOff_03.gif\" ALT=\"\"></TD>\n";
				print "                  <TD> <IMG SRC=\"../images/FlirtStepsOff_04.gif\" ALT=\"\"></TD>\n";
				print "                </TR>\n";
				print "              </TABLE></td>\n";
				print "          </tr>\n";
				print "        </table>\n";
				print "      </DIV>\n";       			
				&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
			}
	}

#End HTML...
print "</HTML>\n";
exit 0;