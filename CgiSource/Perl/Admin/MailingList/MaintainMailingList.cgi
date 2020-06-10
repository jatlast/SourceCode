#!/usr/local/bin/perl -w
use CGI qw/:standard/;
use strict;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "UtilityFunctions.pl";
require "DatabaseFunctions.pl";
require "CgiFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";

my $ProgramName = "MaintainMailingList.cgi";

#Begin HTML so errors show up in browser...
print CGI::header('text/html');
print "<HTML>\n";

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, 1); 

# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		#Begin HTML so errors show up in browser...
		print CGI::header('text/html');
		print "<HTML>\n";
		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
		print "</HTML>\n";
	}
else
	{
		$Map{'PROGRAM_NAME'} = $ProgramName;
	}

my $email_new = "empty";
my $email	  = "empty";
my $submit    = "empty";

if(CGI::param('email_new'))	{$email_new  = CGI::param('email_new');}
if(CGI::param('email'))		{$email		= CGI::param('email');}
if(CGI::param('submit'))	{$submit	= CGI::param('submit');}

if($DebugThisAp eq "1")
{
	print "<!-- email_new = $email_new -->\n";
	print "<!-- email     = $email -->\n";
	print "<!-- submit    = $submit -->\n";
}
my $ResultMessage	= "empty";
my $SqlStatement	= "empty";

if($submit eq "Unsubscribe")
{
	$SqlStatement = "public_OptOut \'$email\'";
}
elsif($submit eq "Subscribe")
{
#									   email,        name,                  origin,     address, valid, which_connections
	$SqlStatement = "public_OptIn \'$email\', \'Unknown\', \'MaintainMailingList\', \'Unknown\', \'2\', \'AllConnections\'";
}
elsif($submit eq "Change")
{
	$SqlStatement = "public_UpdateEmail \'$email\', \'$email_new\'";
}
else
{
	$submit = "Access Error";
	$ResultMessage = "\nAccess Error:<BR><BR>This page is not directly accessable.\n";			
	&Print_Result_Html
}

my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER_MAILING_LIST'}, $Map{'DBPWD_MAILING_LIST'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
if($return_value eq "1")
	{
		$ResultMessage = "\nSUCCESS:<BR><BR>The email address ($email) has successfully been $submit" . "d" . "\n";			
		if($submit eq "Change")
		{
			$ResultMessage = $ResultMessage . "to ($email_new)\n";
		}
	}
else
	{
		if($DatabaseFunctions::DatabaseError eq "1004")
			{
				if($email_new eq "empty")
				{
					$ResultMessage = "\nFAILURE:<BR><BR>The email address ($email) is not unique so it has not been $submit" . "d" . ".\n";						
				}
				else
				{
					$ResultMessage = "\nFAILURE:<BR><BR>The email address ($email_new) is not unique so it has not been $submit" . "d" . ".\n";						
				}
			}
		elsif($DatabaseFunctions::DatabaseError eq "1009")
			{
				$ResultMessage = "\nFAILURE:<BR><BR>The email address ($email) does not exist so it has not been $submit" . "d" . ".\n";						
			}
		else
			{
				$ResultMessage = "\nFAILURE:<BR><BR>The email address ($email) has not been $submit" . "d" . ".\n";						
			}
	}

&Print_Result_Html;
#End HTML...
exit 0;

sub Print_Result_Html
{
print "  <HEAD>\n";
print "    <TITLE>\n";
print "      $submit\n";
print "    </TITLE>\n";
print "	<SCRIPT type=\"text/javascript\" language=\"javascript\" src=\"../JavaScript/MailingList.js\"></SCRIPT>\n";
print "  </HEAD>\n";
print "  <BODY bgcolor=\"#000000\" text=\"#eeeecc\" link=\"#aaddff\" vlink=\"#88aacc\" alink=\"#ffffff\" marginheight=\"0\" topmargin=\"0\" marginwidth=\"0\" leftmargin=\"0\">\n";
print "    <P>\n";
print "      <BR>\n";
print "      <BR>\n";
print "      <BR>\n";
print "    </P>\n";
print "    <TABLE align=\"center\" width=\"400\" border=\"0\" bgcolor=\"#333333\" cellspacing=\"0\" cellpadding=\"0\">\n";
print "      <TR>\n";
print "        <TD colspan=\"4\">\n";
print "		&nbsp;\n";
print "        <BR>\n";
print "        </TD>\n";
print "      </TR>\n";
print "      <TR>\n";
print "        <TD bgcolor=\"#666666\" width=\"1\">\n";
print "		&nbsp;\n";
print "        </TD>\n";
print "        <TD width=\"10\">\n";
print "		&nbsp;\n";
print "        </TD>\n";
print "        <TD>\n";
print "		 <h3><font face=\"Arial, Helvetica, Sans Serif\" color=\"#00FF00\">$ResultMessage</font></h3>\n";
print "            <TABLE border=\"0\" cellpadding=\"1\" cellspacing=\"2\">\n";
print "              <TR>\n";
print "                <TD>\n";
print "                </TD>\n";
print "              </TR>\n";
print "              <TR>\n";
print "                <TD>\n";
print "                </TD>\n";
print "              </TR>\n";
print "              <TR>\n";
print "                <TD>\n";
print "                  &nbsp;\n";
print "                </TD>\n";
print "              </TR>\n";
print "              <TR>\n";
print "                <TD>\n";
print "                </TD>\n";
print "              </TR>\n";
print "            </TABLE>\n";
print "          <P>\n";
print "            [ <A href=\"../MailingList_OptIn.html\" name=\"subscribe\" onmouseover=\"subscribeOver()\" onmouseout=\"subscribeOut()\"><font face=\"Arial, Helvetica, Sans Serif\" size=\"-1\">Subscribe</font></A> ] \n";
print "			[ <A href=\"../MailingList_OptOut.html\" name=\"unsubscribe\" onmouseover=\"unsubscribeOver()\" onmouseout=\"unsubscribeOut()\"><font face=\"Arial, Helvetica, Sans Serif\" size=\"-1\">Unsubscribe</font></A> ] \n";
print "			[ <A href=\"../MailingList_ChangeAddress.html\" name=\"changeAddress\" onmouseover=\"changeAddressOver()\" onmouseout=\"changeAddressOut()\"><font face=\"Arial, Helvetica, Sans Serif\" size=\"-1\">Change Address</font></A> ] \n";
print "          </P>\n";
print "          <P>\n";
print "            <A href=\"../MailingList_What.html\" name=\"what\" onmouseover=\"whatOver()\" onmouseout=\"whatOut()\"><font face=\"Arial, Helvetica, Sans Serif\" size=\"-2\">What is this list?</font></A> \n";
print "          </P>\n";
print "          <BR>\n";
print "          <BR>\n";
print "        </TD>\n";
print "        <TD bgcolor=\"#666666\">\n";
print "		&nbsp;\n";
print "        </TD>\n";
print "      </TR>\n";
print "      <TR>\n";
print "        <TD colspan=\"4\" bgcolor=\"#666666\">\n";
print "		&nbsp;\n";
print "        </TD>\n";
print "      </TR>\n";
print "    </TABLE>\n";
print "  </BODY>\n";
print "</HTML>\n";
exit 0;
}