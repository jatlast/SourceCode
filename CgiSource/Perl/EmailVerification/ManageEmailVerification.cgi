#!/usr/local/bin/perl -w
use CGI qw/:standard/;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

use strict;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "SendMailFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";
my $DebugMailSendFunctions = "0";

my $ProgramName = "ManageEmailVerification.cgi";

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

my $submit					= "empty";
# Possible values:
#	Email_Me_My_Verification_Code
#	Verify_My_Email_Address
#	Change_My_Email_Address

my $user_name				= "empty";
my $password				= "empty";
my $cookie_name				= "empty";
my $cookie_password			= "empty";
my $email					= "empty";
my $email_verification_code	= "empty";
my $new_email				= "empty";

if(CGI::param('user_name'))					{$user_name					= CGI::param('user_name');}
if(CGI::param('password'))					{$password					= CGI::param('password');}
if(CGI::param('submit'))					{$submit					= CGI::param('submit');}
if(CGI::param('email'))						{$email						= CGI::param('email');}
if(CGI::param('email_verification_code'))	{$email_verification_code	= CGI::param('email_verification_code');}
if(CGI::param('new_email'))					{$new_email					= CGI::param('new_email');}

my $is_email_verified = "";

if($DebugThisAp eq "1")
	{
		print "<!-- Passed in web veriables... -->\n";
		print "<!-- submit                  = ($submit) -->\n";
		print "<!-- user_name               = ($user_name) -->\n";
		print "<!-- password                = ($password) -->\n";
		print "<!-- cookie_name             = ($cookie_name) -->\n";
		print "<!-- cookie_password         = ($cookie_password) -->\n";
		print "<!-- email                   = ($email) -->\n";
		print "<!-- email_verification_code = ($email_verification_code) -->\n";
		print "<!-- new_email               = ($new_email) -->\n";
	}

# user_name and password are only passed if the user is verifying her email address using the link supplied to her via email...
if ( ($user_name eq "empty" or $password eq "empty") )
	{
		# Since the user is not using the link supplied check the cookies for user session authentication...
		$cookie_name	 = &CgiFunctions::Get_Cookie_Value("cookie_name"	, $DebugCgiFunctions);
		$cookie_password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

		if ($cookie_name eq "" or $cookie_password eq "") 
			{
				# Die if the user is not logged in...
				&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map);
			}
		else
			{
				# Since the user session is authentic set the user_name and password variables with the same info as the cookies just to be thorough...
				$user_name	= $cookie_name;
				$password	= $cookie_password;
			}
	}
else
	{
		# Since the user is verifying using the link set the cookie variables just to be thorough...
		$cookie_name		= $user_name;
		$cookie_password	= $password;
	}

# Generate the unique email verification code...
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
# use parsed date to create unique verification code...
# verification code has the folling format m[m]-d[d]-yyyy-h[h]-m[m]-s[s]
my $UniqueVerificationCode = ($mon+1) . $mday . ($year+1900) . "-" . $hour . $min . $sec;



if ($submit eq "Email_Me_My_Verification_Code") 
	{
		my $SqlStatement = "SELECT email_verification_code FROM login_info where user_name = '$user_name' and password = '$password'";
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
									
								$email_verification_code = $$dataref{email_verification_code};
								if($email_verification_code){$email_verification_code =~ s/\s//g}
								else{$email_verification_code = "";}
									
								if($DebugThisAp eq "1")
									{
										print "<!-- email_verification_code = ($email_verification_code) -->\n";
									}
							}
					}# END else (No db error) 
			}# END if($status != FAIL)
		else
			{
				print "ERROR: $SqlStatement Failed for first result set!\n";
				$status = $MSSQL::DBlib::dbh->dbcancel();
			}

		my $return_value = &SendMailFunctions::Email_The_Verification_Code_To_User ($user_name, $password, $email, $email_verification_code, $DebugThisAp, %Map);
		if($return_value == 1)
			{
				print "<!-- Sent User Mail -->\n" if $DebugThisAp eq "1";
				# Print HTML Top...
				&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
				# Print HTML Body...
				# Print HTML Body...
				print "			<FONT face=\"Helvetica,Arial\">Your Email Verification Code has been sent to <FONT color=\"blue\">$email</FONT>.</FONT><BR>\n";
				print "				<UL>\n";
				print "					<LI><FONT face=\"Helvetica,Arial\">Please check for your verification code which has been sent to <FONT color=\"blue\">$email</FONT></FONT>\n";
				print "					<LI><FONT face=\"Helvetica,Arial\">Once you receive your verification code you can either follow one of the 4 procedures detailed in the email or</FONT>\n";
				print "					<LI><FONT face=\"Helvetica,Arial\">If you would rather manually enter the code into the previous form <A href=\"ManageEmailVerification.cgi\">Click Here</A> to return to the verification form and enter the code into the Verification Code field under Option 2.</FONT>\n";
				print "				</UL>\n";

				# Print HTML Bottom...
				&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
			}
		else
			{
				print "<!-- Unable To Send Mail -->\n" if $DebugThisAp eq "1";
				&UtilityFunctions::Print_Framed_Error("ERROR: Unable to send verification code to $email for user $user_name.<BR>You may need to re-login.<BR>\n", $DebugUtilityFunctions, %Map);
			}
	}
elsif ($submit eq "Verify_My_Email_Address")
	{
		# Update login_info table to change the user's email address...
		my $SqlStatement = "verifyEmailAddress \'$user_name\', \'$password\', \'$email\', \'$email_verification_code\'"; 

		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "$ProgramName");
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		if($DatabaseFunctions::DatabaseError eq "1000" or $DatabaseFunctions::DatabaseError eq "1001")
			{
				$status = $MSSQL::DBlib::dbh->dbcancel();
				print "<!-- Unable to update Email Verification Status -->\n" if $DebugThisAp eq "1";
				&UtilityFunctions::Print_Framed_Error("ERROR: Unable to verify that $email is the correct address for user $user_name.<BR>Please be sure you entered the correct Email Verification Code.<BR>\n", $DebugUtilityFunctions, %Map);
			}
		else
			{
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
						my $affiliate_tracking_id	= "";
						my $plan_unique_id			= "";
						my $profile_score			= "";
						my $credit_publisher		= "";
						# Prevent infinite loop...
						while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
							{
								$affiliate_tracking_id	= $$dataref{affiliate_tracking_id};
								$plan_unique_id			= $$dataref{plan_unique_id};
								$profile_score			= $$dataref{profile_score};
								$credit_publisher		= $$dataref{credit_publisher};

								if($DebugThisAp eq "1")
									{
										print "<!-- affiliate_tracking_id = ($affiliate_tracking_id) -->\n";
										print "<!-- plan_unique_id        = ($plan_unique_id) -->\n";
										print "<!-- profile_score	      = ($profile_score) -->\n";
										print "<!-- credit_publisher      = ($credit_publisher) -->\n";
									}
							}

						print "<!-- Updated Email Verification Status -->\n" if $DebugThisAp eq "1";
						# Print HTML Top...
						&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
						# Print HTML Body...

						if($plan_unique_id ne "" and $profile_score ne "" and $credit_publisher ne "")
							{
								print "<SCRIPT type=\"text/javascript\" src=\"$Map{'AFL_CGIBIN'}/Afl_ProcessAction.cgi?ckuid=$affiliate_tracking_id&pluid=$plan_unique_id&pfsc=$profile_score&crpub=$credit_publisher\"></SCRIPT>\n";					
							} 
						else
							{
								print "<!-- no afl action initiated for ckuid ($affiliate_tracking_id) -->\n";
							}

						print "			<FONT face=\"Helvetica,Arial\">Your email address <FONT color=\"blue\">$email</FONT> has been successfully verified.</FONT><BR>\n";
						print "				<UL>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">Make sure you are not still within your mail application.</FONT>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">If you are not within your mail application <A href=\"$Map{'ROOT'}/index.html\">click here to log in...</A></FONT>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">If you are already logged in you may use the navigation links on the left side of this page.</FONT>\n";
						print "				</UL>\n";
						# Print HTML Bottom...
						&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
						
					}# END if($status != FAIL)
			}
	}
elsif ($submit eq "Change_My_Email_Address")
	{
		$email_verification_code = $UniqueVerificationCode;
		# Update login_info table to change the user's email address...
		my $SqlStatement = "changeEmailAddress \'$user_name\', \'$password\', \'$email\', \'$new_email\', \'$email_verification_code\'"; 
		my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
		if($return_value eq "1")
			{
				print "<!-- Updated Email Address -->\n" if $DebugThisAp eq "1";
				$return_value = &SendMailFunctions::Email_The_Verification_Code_To_User ($user_name, $password, $new_email, $email_verification_code, $DebugThisAp, %Map);
				if($return_value == 1)
					{
						print "<!-- Sent User Mail -->\n" if $DebugThisAp eq "1";
						# Print HTML Top...
						&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
						# Print HTML Body...
						print "			<FONT face=\"Helvetica,Arial\">Your email address has been changed to <FONT color=\"blue\">$new_email</FONT>.</FONT><BR>\n";
						print "				<UL>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">Please check for your verification code which has been sent to <FONT color=\"blue\">$new_email</FONT></FONT>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">Once you receive your verification code you can either follow one of the 4 procedures detailed in the email or</FONT>\n";
						print "					<LI><FONT face=\"Helvetica,Arial\">If you would rather manually enter the code into the previous form <A href=\"ManageEmailVerification.cgi\">Click Here</A> to return to the verification form and enter the code into the Verification Code field under Option 2.</FONT>\n";
						print "				</UL>\n";

						# Print HTML Bottom...
						&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
					}
				else
					{
						print "<!-- Unable To Send Mail -->\n" if $DebugThisAp eq "1";
						&UtilityFunctions::Print_Framed_Error("ERROR: Unable to send verification code to $new_email for user $user_name.<BR>You may need to re-login.<BR>\n", $DebugUtilityFunctions, %Map);
					}
			}
		else
			{
				print "<!-- Unable to Update Email Address -->\n" if $DebugThisAp eq "1";
				&UtilityFunctions::Print_Framed_Error("ERROR: Unable to update $email to $new_email for user $user_name.<BR>You may need to re-login.<BR>\n", $DebugUtilityFunctions, %Map);
			}
	}
else
	{
		my $SqlStatement = "SELECT email, is_email_verified FROM login_info where user_name = '$cookie_name'";
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
									
								$email = $$dataref{email};
								if($email){$email =~ s/\s//g}
								else{$email = "";}
									
								$is_email_verified = $$dataref{is_email_verified};
								if($is_email_verified){$is_email_verified =~ s/\s//g}
								else{$is_email_verified = "";}
									
								if($DebugThisAp eq "1")
									{
										print "<!-- email             = ($email) -->\n";
										print "<!-- is_email_verified = ($is_email_verified) -->\n";
									}
							}
					}# END else (No db error) 
			}# END if($status != FAIL)
		else
			{
				print "ERROR: $SqlStatement Failed for first result set!\n";
				$status = $MSSQL::DBlib::dbh->dbcancel();
			}

		# Print HTML Top...
		&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
		# Print HTML Body...
		&Print_Email_Verification_Options_HTML($DebugThisAp, %Map);
		# Print HTML Bottom...
		&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
	}

print "</HTML>\n";
 


sub Print_Email_Verification_Options_HTML
	{
		(my $Debug, my %Map) = @_;

		if($is_email_verified == '1')
			{
				print "          <FONT size=\"4\" face=\"Helvetica,Arial\">Your email address (<STRONG>$email</STRONG>) has been verified.<BR><BR>If you change this email address you will have to verify the new address in order to regain access to all the features of $Map{'WHICH_CONNECTIONS'}.com</FONT> \n";
			}
		else
			{
				print "          <FONT size=\"4\" face=\"Helvetica,Arial\">Your email address (<STRONG>$email</STRONG>) has <FONT color=\" color=\"#8B0000\"\">NOT</FONT> been verified.<BR><BR>To access the features of $Map{'WHICH_CONNECTIONS'}.com you must first verify that you have access to the above email address.</FONT> \n";
			}
		print "		  <HR>\n";
		print "          <FONT size=\"5\" face=\"Helvetica,Arial\" color=\"Blue\"><STRONG>Email Verification Options...</STRONG></FONT> \n";
		print "          <HR>\n";
		print "          <TABLE border=\"0\" width=\"100%\" cellpadding=\"5\">\n";
		print "            <TR>\n";
		print "              <TD height=\"54\">\n";
		print "				<FONT face=\"arial,helvetica\" color=\"#990000\"><STRONG><FONT color=\"Blue\">Option 1:</FONT><BR>Enter Your Email Verification Number...</STRONG></FONT>\n";
		print "				<BR>\n";
		print "				  <OL>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">If you do not have an Email Verification Code follow the &#147;Option 2&#147; directions below.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">If you have already received your Email Verification Code please enter it below.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Press the &#147;Verify_My_Email_Address&#148; button to verify your email address.</FONT>\n";
		print "					</LI>\n";
		print "				  </OL>\n";
		print "<!--\n";
		print "				  <CENTER>\n";
		print "					<FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"800000\">(Alternatively: Follow the link provided in your confirmation email to automatically activate your account.)</FONT>\n";
		print "				  </CENTER>\n";
		print "-->\n";
		print "				<FORM onsubmit=\"return checkFormOne(this)\" action=\"ManageEmailVerification.cgi\" method=\"POST\">\n";
		print "					<TABLE>\n";
		print "					  <TBODY>\n";
		print "		              <!--    email -->\n";
		print "					  <TR>\n";
		print "						<TD align=\"right\">\n";
		print "						  <P>\n";
		print "							 <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Email:</FONT>\n";
		print "						  </P>\n";
		print "						</TD>\n";
		print "						<TD align=\"left\">\n";
		print "						  <P>\n";
		print "							 <INPUT type=\"hidden\" name=\"email\" value=\"$email\"><FONT face=\"Arial, Helvetica, sans-serif\"><STRONG>$email</STRONG></FONT>\n";
		print "						  </P>\n";
		print "						</TD>\n";
		print "					  </TR>\n";
		print "					  <!--    verification_code -->\n";
		print "					  <TR>\n";
		print "						<TD align=\"right\">\n";
		print "						  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Verification Code:</FONT>\n";
		print "						</TD>\n";
		print "						<TD align=\"left\">\n";
		print "						  <FONT face=\"Arial, Helvetica, sans-serif\"> <INPUT name=\"email_verification_code\" size=\"20\"> <FONT color=\"#FF0000\" size=\"2\">Number emailed to you.</FONT></FONT>\n";
		print "						</TD>\n";
		print "					  </TR>\n";
		print "						<TR>\n";
		print "						  <TD>\n";
		print "							&nbsp;\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\"><INPUT type=\"submit\" value=\"Verify_My_Email_Address\" name=\"submit\"></FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "					  </TBODY>\n";
		print "					</TABLE>\n";
		print "				</FORM>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "		  <HR>\n";
		print "          <TABLE border=\"0\" width=\"100%\" cellpadding=\"5\">\n";
		print "            <TR>\n";
		print "              <TD height=\"54\">\n";
		print "				<FONT face=\"arial,helvetica\" color=\"#990000\"><STRONG><FONT color=\"Blue\">Option 2:</FONT><BR>Receive Your Verification Number...</STRONG></FONT>\n";
		print "				<BR>\n";
		print "				  <OL>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">If the Email Address below is not correct follow the directions for &#147;Option 3&#148; to change your existing email address.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">If the Email Address below is correct press the &#147;Email_Me_My_Verification_Code&#148; button to send a Verification Code to your current email address.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Once you receive your Verification Code use it to complete &#147;Option 1&#147; above.</FONT>\n";
		print "					</LI>\n";
		print "				  </OL>\n";
		print "				<FORM action=\"ManageEmailVerification.cgi\" method=\"POST\">\n";
		print "					<TABLE>\n";
		print "					  <TBODY>\n";
		print "						<TR>\n";
		print "						  <TD align=\"right\">\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\">Email Address:</FONT>\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							 <INPUT type=\"hidden\" name=\"email\" value=\"$email\"><FONT face=\"Arial, Helvetica, sans-serif\"><STRONG>$email</STRONG></FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "						<TR>\n";
		print "						  <TD>\n";
		print "							&nbsp;\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\"><INPUT type=\"submit\" value=\"Email_Me_My_Verification_Code\" name=\"submit\"></FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "			            <TR>\n";
		print "						  <TD>\n";
		print "							&nbsp;\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "								<FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"800000\">(You should receive your email verification code within 5 minutes.)</FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "					  </TBODY>\n";
		print "					</TABLE>\n";
		print "				</FORM>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "          <HR>\n";
		print "          <TABLE border=\"0\" width=\"100%\" cellpadding=\"5\">\n";
		print "            <TR>\n";
		print "              <TD height=\"54\">\n";
		print "				<FONT face=\"arial,helvetica\" color=\"#990000\"><STRONG><FONT color=\"Blue\">Option 3:</FONT><BR>Change Your Email Address...</STRONG></FONT>\n";
		print "				<BR>\n";
		print "				  <OL>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Enter your new email address.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Press the &#147;Change_My_Email_Address&#148; button to change your email address.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Once you change your email address you will have to following the directions for &#147;Option 2&#147; above to receive your new Email Verification Code.</FONT>\n";
		print "					</LI>\n";
		print "					<LI>\n";
		print "					  <FONT size=\"3\" color=\"800000\" face=\"Helvetica,Arial\">Once you receive your Email Verification Code you will hve to follow the directions for &#147;Option 1&#147; above to verify your new email address.</FONT>\n";
		print "					</LI>\n";
		print "				  </OL>\n";
		print "				<FORM onsubmit=\"return checkFormTwo(this)\" action=\"ManageEmailVerification.cgi\" method=\"POST\">\n";
		print "					<TABLE>\n";
		print "					  <TBODY>\n";
		print "						<TR>\n";
		print "						  <TD align=\"right\">\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\">Current Email Address:</FONT>\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							 <INPUT type=\"hidden\" name=\"email\" value=\"$email\"><FONT face=\"Arial, Helvetica, sans-serif\"><STRONG>$email</STRONG></FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "						<TR>\n";
		print "						  <TD align=\"right\">\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\">New Email Address:</FONT>\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							<INPUT size=\"32\" name=\"new_email\">\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "						<TR>\n";
		print "						  <TD>\n";
		print "							&nbsp;\n";
		print "						  </TD>\n";
		print "						  <TD>\n";
		print "							<FONT face=\"geneva,arial\" size=\"-1\"><INPUT type=\"submit\" value=\"Change_My_Email_Address\" name=\"submit\"></FONT>\n";
		print "						  </TD>\n";
		print "						</TR>\n";
		print "					  </TBODY>\n";
		print "					</TABLE>\n";
		print "				</FORM>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "			<SCRIPT language=\"javascript\" src=\"../JavaScript/ManageEmailVerification.js\"></SCRIPT>\n";
		print "          <HR>\n";

	}

exit 0;