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

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "1";
my $DebugUtilityFunctions  = "0";

my $ProgramName = "CancelPayingMembership.cgi";

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
		$Map{'PROGRAM_NAME'} = $ProgramName;
		print "<!-- $Map{'SYSTEM'} -->\n" if $DebugThisAp eq "1";
	}

my $reason_for_leaving = "empty";
my $membership_prices  = "empty";
my $website_design	   = "empty";
my $suggestions		   = "empty";

if(CGI::param('reason_for_leaving')) {$reason_for_leaving = CGI::param('reason_for_leaving');}
if(CGI::param('membership_prices'))  {$membership_prices  = CGI::param('membership_prices');}
if(CGI::param('website_design'))	 {$website_design	  = CGI::param('website_design');}
if(CGI::param('suggestions'))		 {$suggestions		  = CGI::param('suggestions');}

my $cookie_name    	= &CgiFunctions::Get_Cookie_Value("cookie_name"	   , $DebugCgiFunctions);
my $cookie_password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

# Die if the user is not logged in...
&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map) if($cookie_password eq "");

&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);

# Initialize the sql statement and build it as you go...												   														  
my $SqlStatement = "cancel_paying_membership \"$cookie_name\", \"$cookie_password\", \"$reason_for_leaving\", \"$membership_prices\", \"$website_design\", \"$suggestions\"";

my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
if($return_value eq "1")
	{
		
		print "\n<!-- SUCCESS:  User ($cookie_name) has successfully canceled their paying membership in the DB. -->\n" if $DebugThisAp eq "1";
			
		print "                        <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n";
		# Approved...
		# Goodbye Message to the cancelled user...
		print "                          <TR>\n";
		print "                            <TD height=\"30\" colspan=\"3\">\n";
		print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$cookie_name</FONT>, ";
		print "we are sorry to see you cancel your Premium membership on $Map{'WHICH_CONNECTIONS'}.<BR>\n";
		print "We Appreciate your input and hope you will continue to enjoy the free services offered by $Map{'WHICH_CONNECTIONS'}.<BR><BR>\n";
		print "Thank you,<BR><BR>$Map{'EMAIL'}<BR><BR></FONT></STRONG></FONT>\n";
		print "                            </TD>\n";
		print "                          </TR>\n";
		print "                        </TABLE>\n";
			
	}
else
	{
		my $ErrorText = "";
		if($DatabaseFunctions::DatabaseError eq "1007")
			{
				$ErrorText = "<FONT COLOR=\"#8B0000\">ERROR: User \"$cookie_name\" is not currently a paying member.</FONT><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		else
			{
				$ErrorText = "<FONT COLOR=\"#8B0000\">ERROR: The system is currently unable to process the membership cancellation for \"$cookie_name\".</FONT><BR><FONT COLOR=\"#0000FF\">Note: If you continue to experience this problem contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		print "\n<!-- FAILURE:  User ($cookie_name) could not cancel their paying membership in the DB. -->\n";
			
		print "                        <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n";
		# Failed...
		# Print the error text...
		print "                          <TR>\n";
		print "                            <TD height=\"30\" colspan=\"3\">\n";
		print "                              $ErrorText\n";
		print "                            </TD>\n";
		print "                          </TR>\n";
		print "                        </TABLE>\n";
	}

&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);

#End HTML...
print "</HTML>\n";
exit 0;

