#!/usr/local/bin/perl -w
use CGI qw/:standard/;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

use strict;

#Begin HTML so errors show up in browser...
print CGI::header('text/html');
print "<HTML>\n";

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "CgiFunctions.pl";
require "DatabaseFunctions.pl";
require "UtilityFunctions.pl";

my $ProgramName = "GenAuthorizeNetFormECHECK.cgi";

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "1";
my $DebugUtilityFunctions  = "0";

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, 1); 
 
# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
	}
else
	{
		print "<!-- $Map{'CONFIG'} -->\n";
	}

my $cookie_name    = &CgiFunctions::Get_Cookie_Value("cookie_name", $DebugCgiFunctions);
my $cookie_password =  &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

# Die if the user is not logged in...
&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map) if($cookie_password eq "");

# Mail was sent internally...
&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);


my $card_type 		     = "Empty";
my $name_on_card 	 	 = "Empty";
my $account_number   	 = "Empty";
my $expiration_month 	 = "Empty";
my $expiration_year	 	 = "Empty";
my $bank_ABA_code	     = "Empty";
my $bank_account_number	 = "Empty";

my $PercentSavings 	 = 0;
my $PastDecimal 	 = 0;
my $DoTheMath 	 	 = 0;

my $SqlStatement = "SELECT * FROM billing_info WHERE user_name = '$cookie_name'";
my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "$ProgramName");
$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
$status = $MSSQL::DBlib::dbh->dbsqlexec();
	
##########################
# Get ONLY result set...
##########################
# dbresults() must be called for each result set...
$status = $MSSQL::DBlib::dbh->dbresults();
if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
	{
		if($DebugThisAp eq "1")
			{
				print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n";
			}
		my %dataref = ("jason" => "baumbach");
		my $dataref = \%dataref;
		# If in debug mode, print information...
		if($DebugThisAp == 1)
			{
				print "<!-- SQL: $SqlStatement -->\n";
			}
		# Check for global DB error...
		if($DatabaseFunctions::DatabaseError eq "1")
			{
				print "ERROR: ($SqlStatement) Failed!<BR>\n";
			}
		else
			{
				# Prevent infinite loop...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
					{
						# Since there is no global DB error check get 
						# all database fields returned by the query...
							
						$card_type 	      = $$dataref{card_type};
						$name_on_card 	  = $$dataref{name_on_card};
							
						$account_number   = $$dataref{account_number};
						$account_number =~ s/\s//g;
							
						$expiration_month     = $$dataref{expiration_month};
						$expiration_year  	  = $$dataref{expiration_year};
						$bank_ABA_code    	  = $$dataref{bank_ABA_code};
						$bank_account_number  = $$dataref{bank_account_number};
							
						if($DebugThisAp eq "1")
							{
								print "<!-- card_type           = ($card_type) -->\n";
								print "<!-- name_on_card        = ($name_on_card) -->\n";
								print "<!-- account_number      = ($account_number) -->\n";
								print "<!-- expiration_month    = ($expiration_month) -->\n";
								print "<!-- expiration_year     = ($expiration_year) -->\n";
								print "<!-- bank_ABA_code       = ($bank_ABA_code) -->\n";
								print "<!-- bank_account_number = ($bank_account_number) -->\n";
							}
					}
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}

print "          <TABLE border=\"0\" cellspacing=\"3\" cellpadding=\"3\" width=\"100%\">\n";
print "            <TR valign=\"bottom\">\n";
print "              <TD height=\"29\" width=\"604\" align=\"left\">\n";
print "                <P>\n";
print "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#FFFFFF\"><STRONG>The order for <FONT color=\"red\">$cookie_name</FONT> will be processed on a secure server.</STRONG></FONT>\n";
print "                </P>\n";
print "              </TD>\n";
print "            </TR>\n";
print "            <TR>\n";
print "              <TD height=\"311\" width=\"604\" valign=\"top\">\n";
print "                <TABLE width=\"100%\" border=\"2\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#FFFFDC\">\n";
print "                  <TR valign=\"top\">\n";
print "                    <TD height=\"235\">\n";
print "                      <FORM method=\"POST\" action=\"AuthorizeNetSendSSL.cgi\" onsubmit=\"return checkForm(this)\">\n";
print "                        <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" colspan=\"3\">\n";
print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><U><STRONG><FONT size=\"3\" color=\"#FFFFFF\">Step 1 - </FONT><FONT color=\"#FFFFFF\">Choose Membership Plan.</FONT></STRONG></U></FONT>\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" width=\"131\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"radio\" name=\"months_joined\" value=\"1\">One Month</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" width=\"178\">\n";
print "                              <FONT size=\"2\"> $Map{'PRICE_ONE'} (US \$)</FONT>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" width=\"215\">\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" width=\"131\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"radio\" name=\"months_joined\" value=\"3\">Three Month</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD nowrap height=\"30\" width=\"178\">\n";
# Calculate the potential amount of savings...
$DoTheMath = $Map{'PRICE_THREE'};
$DoTheMath /= ( $Map{'PRICE_ONE'} * 3 );
$DoTheMath -= 1;
$DoTheMath *= (-100);
# Split the number in two at the decimal...
($PercentSavings, $PastDecimal) = split(/\./, $DoTheMath);
# Check if rounding is needed...
if(substr($PastDecimal, 1, 1) > 5)
{
 $PercentSavings++;
}
print "                              <FONT size=\"2\">$Map{'PRICE_THREE'} (US \$) <FONT color=\"#FF0000\">save " . $PercentSavings . "%</FONT></FONT>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" width=\"215\">\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" width=\"131\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"radio\" name=\"months_joined\" value=\"12\">One Year</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD nowrap height=\"30\" width=\"178\">\n";
# Calculate the potential amount of savings...
$DoTheMath = $Map{'PRICE_TWELVE'};
$DoTheMath /= ( $Map{'PRICE_ONE'} * 12 );
$DoTheMath -= 1;
$DoTheMath *= (-100);
# Split the number in two at the decimal...
($PercentSavings, $PastDecimal) = split(/\./, $DoTheMath);
# Check if rounding is needed...
if(substr($PastDecimal, 1, 1) > 5)
{
 $PercentSavings++;
}
print "                              <FONT size=\"2\">$Map{'PRICE_TWELVE'} (US \$)<FONT color=\"#FF0000\"> save " . $PercentSavings . "%</FONT></FONT>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" width=\"215\">\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" width=\"131\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"radio\" name=\"months_joined\" value=\"240\">Lifetime</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD nowrap height=\"30\" width=\"178\">\n";
# Calculate the potential amount of savings...
$DoTheMath = $Map{'PRICE_LIFETIME'};
$DoTheMath /= ( $Map{'PRICE_ONE'} * 240 );
$DoTheMath -= 1;
$DoTheMath *= (-100);
# Split the number in two at the decimal...
($PercentSavings, $PastDecimal) = split(/\./, $DoTheMath);
# Check if rounding is needed...
if(substr($PastDecimal, 1, 1) > 5)
{
 $PercentSavings++;
}
print "                              <FONT size=\"2\">$Map{'PRICE_LIFETIME'} (US \$)<FONT color=\"#FF0000\"> save " . $PercentSavings . "%</FONT></FONT>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" width=\"215\">\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                        </TABLE>\n";
print "                        <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" colspan=\"2\">\n";
print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><U><STRONG><FONT size=\"3\" color=\"#FFFFFF\">Step 2 - Enter Bank Information.</FONT></STRONG></U>\n";
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "                            <TD height=\"30\" width=\"27%\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Bank ABA Code:</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" valign=\"top\">\n";
if($bank_ABA_code =~ m/Empty/)
	{
		print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"text\" name=\"bank_ABA_code\" value=\"\" size=\"25\" maxlength=\"64\"></FONT>\n";
	}
else
	{
		print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"text\" name=\"bank_ABA_code\" value=\"$bank_ABA_code\" size=\"25\" maxlength=\"64\"></FONT>\n";
	}
print "                            </TD>\n";
print "                          </TR>\n";
print "                            <TD height=\"30\" width=\"27%\">\n";
print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Bank Account Number:</FONT></STRONG>\n";
print "                            </TD>\n";
print "                            <TD height=\"30\" valign=\"top\">\n";
if($bank_account_number =~ m/Empty/)
	{
		print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"text\" name=\"bank_account_number\" value=\"\" size=\"25\" maxlength=\"64\"></FONT>\n";
	}
else
	{
		print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"text\" name=\"bank_account_number\" value=\"$bank_account_number\" size=\"25\" maxlength=\"64\"></FONT>\n";
	}
print "                            </TD>\n";
print "                          </TR>\n";
print "                          <TR>\n";
print "							 	<INPUT TYPE=\"HIDDEN\" NAME=\"x_method\" VALUE=\"ECHECK\">\n";
print "                          </TR>\n";
print "                        </TABLE>\n";

#print "<INPUT TYPE=\"HIDDEN\" NAME=\"cookie_name\" VALUE=\"\$cookie_name\">\n";

print "                        <BLOCKQUOTE>\n";
print "                          <DIV align=\"center\">\n";
print "                            <FONT face=\"Arial, Helvetica, sans-serif\"> <INPUT type=\"submit\" name=\"Submit\" value=\"submit\"></FONT>\n";
print "                          </DIV>\n";
print "                        </BLOCKQUOTE>\n";
print "                      </FORM>\n";
print "                      <TABLE width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
print "                        <TR>\n";
print "                          <TD align=\"left\" valign=\"top\">\n";
print "                            <IMG src=\"$Map{'IMAGES'}/SmallPadlock_SSL.gif\">\n";
print "                          </TD>\n";
print "                          <TD align=\"left\" valign=\"bottom\">\n";
print "                            <FONT face=\"arial,helvetica\" size=\"2\">Purchase with confidence. Our site uses SSL (Secure Sockets Layer) Technology to protect your transactions.</FONT>\n";
print "                          </TD>\n";
print "                        </TR>\n";
print "                      </TABLE>\n";
print "                      <P>\n";
print "                        <A href=\"GenAuthorizeNetFormCC.cgi\"><FONT face=\"Arial, Helvetica, sans-serif\"><FONT size=\"2\" color=\"navy\"><b>Pay using a valid credit card...<b></FONT></FONT></A>\n";
print "                        <BR>\n";
print "                      </P>\n";
print "                    </TD>\n";
print "                  </TR>\n";
print "                </TABLE>\n";
print "              </TD>\n";
print "            </TR>\n";
print "            <TR>\n";
print "              <TD height=\"2\">\n";
print "                &nbsp;\n";
print "              </TD>\n";
print "            </TR>\n";
print "          </TABLE>\n";

&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);

print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/GenAuthorizeNetFormECHECK.js\"></SCRIPT>\n";

#End BODY...
print "</BODY>\n";

#End HTML...
print "</HTML>\n";
exit 0;
