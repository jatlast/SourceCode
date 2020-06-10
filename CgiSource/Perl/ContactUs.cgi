#!/usr/local/bin/perl -w
use CGI qw/:standard/;
#use strict;

# Add directories to perl environment path...
unshift @INC, "D:\\Required\\INC\\";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "SendMailFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";
my $DebugMailSendFunctions = "0";

my $ProgramName = "Adv_AuthorizeNetReceive.cgi";

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
		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
	}
else
	{
		print "<!-- $Map{'CONFIG'} -->\n";
	}

my @QueryStringParams;
my %QueryStringHash;

my $adv_cookie_id		= "";
my $adv_cookie_email	= "";
my $adv_cookie_password	= "";

$adv_cookie_id		 = &CgiFunctions::Get_Cookie_Value("adv_cookie_id"		, $DebugCgiFunctions);
$adv_cookie_email	 = &CgiFunctions::Get_Cookie_Value("adv_cookie_email"	, $DebugCgiFunctions);
$adv_cookie_password = &CgiFunctions::Get_Cookie_Value("adv_cookie_password", $DebugCgiFunctions);

my $UrlParams			= "";

# Load the values passed in into the QueryStringHash...
@QueryStringParams = CGI::param();
%QueryStringHash = &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

if($QueryStringHash{'x_ship_to_state'} eq "4")
	{
		$QueryStringHash{'x_ship_to_state'} = "Visa";
	}
elsif($QueryStringHash{'x_ship_to_state'} eq "5")
	{
		$QueryStringHash{'x_ship_to_state'} = "Master Card";
	}
else
	{
	 	print "<!-- Unknown card type ($QueryStringHash{'x_ship_to_state'}) -->\n";
		$QueryStringHash{'x_ship_to_state'} = "Unknown";
	}

my %HostSettings = &DatabaseFunctions::Get_Host_Settings($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $QueryStringHash{'x_ship_to_first_name'}, $DebugDatabaseFunctions);
$HostSettings{'show_top_nav'} = "true";
# Output all beginning HTML...
$UrlParams = "";
&UtilityFunctions::Print_Adv_Advertiser_HTML_Top(\$UrlParams, \$DebugUtilityFunctions, \%HostSettings, \%Map);

# Initialize the sql statement and build it as you go...
my $SqlStatement = "transaction_credit_card_receive \"$QueryStringHash{'x_ship_to_address'}\", \"$QueryStringHash{'x_response_code'}\", \"$QueryStringHash{'x_cvv2_resp_code'}\", \"$QueryStringHash{'x_response_subcode'}\", \"$QueryStringHash{'x_response_reason_code'}\", \"$QueryStringHash{'x_response_reason_text'}\", \"$QueryStringHash{'x_auth_code'}\", \"$QueryStringHash{'x_avs_code'}\", \"$QueryStringHash{'x_trans_id'}\", \"$QueryStringHash{'x_MD5_Hash'}\"";

my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
if($return_value eq "1")
	{
		print "\n<!-- SUCCESS:  Received message for ($QueryStringHash{'x_ship_to_address'}) was successfully logged to the DB. -->\n";
			
		print "                        <TABLE align=\"center\" border=\"0\" width=\"60%\" cellspacing=\"3\" cellpadding=\"3\">\n";
		# Approved...
		if($QueryStringHash{'x_response_code'} eq "1")
			{
    		if($QueryStringHash{'x_type'} eq "AUTH_CAPTURE" 
				or $QueryStringHash{'x_type'} eq "auth_capture"
				)
    			{
    				# user_name / WHICH_CONNECTIONS...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT>, thank you for using $Map{'WHICH_CONNECTIONS'}\'s text ads to help fulfill your advertising needs.</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";

					# Adjust the amount of transaction based on processing mode
					#  and send the Host an email message abt. pending ads...
					my $actual_amount = $QueryStringHash{'x_amount'};
					if($QueryStringHash{'x_description'} =~ m/TEST MODE/i)
					{
						$actual_amount = "0.00";
					}
					my $sub_return_value = &Email_Ads_Pending_Approval_Message_To_Host(\$QueryStringHash{'x_ship_to_city'}
																						, \$actual_amount
																						, \%HostSettings
																						, \%Map
																						, \$DebugUtilityFunctions
																						);
					if($sub_return_value eq "1")
						{
							print "\n<!-- SUCCESS:  Email message was successfully sent to ($adv_cookie_email). -->\n";
						}
					else
						{
							print "\n<!-- ERROR:  Could not send email message to ($adv_cookie_email). -->\n";
						}
    			}
    		elsif($QueryStringHash{'x_type'} eq "BYPASS")
    			{
    				# user_name / WHICH_CONNECTIONS...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT>, thank you for using your default advertiser account to add text ads to your site.</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";

					# Adjust the amount of transaction based on processing mode
					#  and send the Host an email message abt. pending ads...
					my $actual_amount = "0.00";
					my $sub_return_value = &Email_Ads_Pending_Approval_Message_To_Host(\$QueryStringHash{'x_ship_to_city'}
																						, \$actual_amount
																						, \%HostSettings
																						, \%Map
																						, \$DebugUtilityFunctions
																						);
					if($sub_return_value eq "1")
						{
							print "\n<!-- SUCCESS:  Email message was successfully sent to ($adv_cookie_email). -->\n";
						}
					else
						{
							print "\n<!-- ERROR:  Could not send email message to ($adv_cookie_email). -->\n";
						}
    			}
			elsif($QueryStringHash{'x_type'} eq "CREDIT" or $QueryStringHash{'x_type'} eq "credit")
    			{
    				# user_name / Credit...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT> was successfully credited $QueryStringHash{'x_amount'} (US \$)</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
    			}
			elsif($QueryStringHash{'x_type'} eq "VOID" or $QueryStringHash{'x_type'} eq "void")
    			{
    				# user_name / Credit...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\">Successfully voided <FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT> transaction of $QueryStringHash{'x_amount'} (US \$)</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
    			}
			else
			{
    				# user_name / Unknown...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT> -- approved but unknown transaction type ($QueryStringHash{'x_type'}) to us</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
			}

				# x_response_code...
				print "\n<!-- x_response_code: ($QueryStringHash{'x_response_code'}) -->\n";
				# x_response_reason_text...
				print "\n<!-- x_response_reason_text: ($QueryStringHash{'x_response_reason_text'}) -->\n\n";
				
				# transaction_id...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'x_ship_to_address'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				# months_joined / amount...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction Amount:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" width=\"13%\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Total: $QueryStringHash{'x_amount'} (US \$)</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
					
			}
		# Declined...
		elsif($QueryStringHash{'x_response_code'} eq "2")
			{
    		if($QueryStringHash{'x_type'} eq "AUTH_CAPTURE" or $QueryStringHash{'x_type'} eq "auth_capture")
    			{
    				# user_name / WHICH_CONNECTIONS...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT>, $Map{'WHICH_CONNECTIONS'} is sorry but your credit card has been declined.</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
    			}
			elsif($QueryStringHash{'x_type'} eq "CREDIT" or $QueryStringHash{'x_type'} eq "credit")
    			{
    				# user_name / Credit...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT> could not be credited $QueryStringHash{'x_amount'} (US \$)</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
    			}
			else
			{
    				# user_name / Unknown...
    				print "                          <TR>\n";
    				print "                            <TD height=\"30\" colspan=\"3\">\n";
    				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT> -- was not credited $QueryStringHash{'x_amount'} (US \$) and there was an unknown transaction type ($QueryStringHash{'x_type'}) to us</FONT></STRONG></FONT>\n";
    				print "                            </TD>\n";
    				print "                          </TR>\n";
			}
				# x_response_reason_text...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Reason Declined:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"#FF0033\"> $QueryStringHash{'x_response_reason_text'}</FONT></FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				# transaction_id...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'x_ship_to_address'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
			}
		# Error...
		elsif($QueryStringHash{'x_response_code'} eq "3")
			{
				# user_name / WHICH_CONNECTIONS...
				print "                          <TR>\n";
				print "                            <TD height=\"30\" colspan=\"3\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$QueryStringHash{'x_ship_to_last_name'}</FONT>, $Map{'WHICH_CONNECTIONS'} is sorry but there has been an error while processing your transaction.</FONT></STRONG></FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				# x_response_reason_text...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Error Message:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"#FF0033\"> $QueryStringHash{'x_response_reason_text'}</FONT></FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				# transaction_id...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'x_ship_to_address'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
			}
		# Unknown...
		else
			{
				# x_response_code...
				print "\n<!-- Unknown x_response_code: ($QueryStringHash{'x_response_code'}) -->\n";
				# x_cvv2_resp_code...
				print "\n<!--        x_cvv2_resp_code: ($QueryStringHash{'x_cvv2_resp_code'}) -->\n";
			}

		if($QueryStringHash{'x_type'} ne "BYPASS")
			{
				# name_on_card...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Cardholder's Name:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'x_ship_to_last_name'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";

				# card_type...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Card Type:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'x_ship_to_state'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				# last_four...
				print "                          <TR valign=\"middle\">\n";
				print "                            <TD height=\"30\" width=\"32%\">\n";
				print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Account Number:</FONT></STRONG>\n";
				print "                            </TD>\n";
				print "                            <TD height=\"30\" colspan=\"2\">\n";
				print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> ************$QueryStringHash{'x_ship_to_zip'}</FONT>\n";
				print "                            </TD>\n";
				print "                          </TR>\n";
				print "                        </TABLE>\n";
			}
	}
else
	{
		&UtilityFunctions::Adv_Print_Framed_Error($adv_cookie_id, "ERROR: The system is currently unable to process the creditcard transaciton for \"$QueryStringHash{'x_ship_to_last_name'}\".  Please try again<BR>(Note: If you continue to experience this problem contact $Map{'EMAIL'}.)<BR>\n", $DebugUtilityFunctions, %Map);
	}

#&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);

# declare global variables...
#End HTML...
print "</HTML>\n";

sub Email_Ads_Pending_Approval_Message_To_Host
	{
		my $my_email				= shift;		
		my $my_transaction_amount	= shift;		
		my $My_HostSettingsHash		= shift;

		my $My_Map					= shift;
		my $My_Debug				= shift;

		print "\n<!-- Within: Email_Multiple_Login_Info_To_User($$my_email, $$my_transaction_amount, $$My_HostSettingsHash{'host_unique_id'}, $$My_Map{'ROOT'}, $$My_Debug)\n-->\n" if $$My_Debug eq "1";


		# Build email to send as status report...
		my $BlatPath 		= "$$My_Map{'BLAT_PATH'}/EXE/blat.exe";
		my $SMTP 			= "$$My_Map{'SMTP_HOST'}";

		my $From   			= "$$My_Map{'EMAIL'}";
#		my $From   			= "baumbach\@optonline.net";

		my $To 				= $$my_email;
#		my $To 				= "jatlast\@hotmail.com";

		my $Bcc				= "baumbach\@optonline.net";
		my $Subject			= "OneMonkey: New Text Ads Pending Approval...";
		my $TempFile		= "";
		my $TempFilePath 	= "C:\\Temp";
		my $BlatLogFilePath = "$$My_Map{'BLAT_PATH'}/EXE/blat.log";
		my $return_value	= 0;
		my $output			= "";
		my $StatusMessage	= "";

# Initialize the Email Body by escaping the carriage return so it is easier to read...
		my $Body 			= "\
One Monkey, Inc. is pleased to inform Host $$My_HostSettingsHash{'host_unique_id'} that $$my_email has purchased \$$$my_transaction_amount worth of advertising on $$My_HostSettingsHash{'site_url'}.\
\
In order to allow the new advertising to appear on your sites you must first approve the contents of the text ads by following the directions below:\
\
 1. Log in to $$My_Map{'ROOT'}\
 2. Click the \"Ads_Pending_Approval\" tab.\
 3. Follow the directions in the center \"Ad To Approve\" column\
    to Approve or Decline each individual ad.\
\
\
Thank you again for choosing One Monkey, Inc.
\
Sincerely,\
\
\
Jason Baumbach\
One Monkey Text Ads Team
$$My_Map{'EMAIL'}";

		($return_value, $output)= &SendMailFunctions::Mail_Blat($BlatPath, $SMTP, $From, $To, $Bcc, $Subject, $TempFile, $Body, $TempFilePath, $BlatLogFilePath, $$My_Debug);
		if($return_value < 1)
			{
				print "\n<!-- Email_Multiple_Login_Info_To_User Success return_value = $return_value \n output = $output\n-->\n";
				return (1);
			}
		else
			{
				print "\n<!-- Email_Multiple_Login_Info_To_User Error return_value = $return_value \n output = $output\n-->\n";
				return (-1);
			}
	}

exit 0;

