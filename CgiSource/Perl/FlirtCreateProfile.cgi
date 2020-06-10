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
require "UtilityFunctions.pl";

my $DebugThisAp			   = "1";
my $DebugDatabaseFunctions = "1";
my $DebugCgiFunctions 	   = "1";
my $DebugUtilityFunctions  = "1";

my $ProgramName = "FlirtOne.cgi";

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
		my $first_name	= "";
		my $last_name	= "";
		my $phone1		= "";
		my $phone2		= "";
		my $phone3		= "";
		my $carrier		= "";
		my $city		= "";
		my $state		= "";
		my $zip			= "";
		my @QueryStringParams;
		my %QueryStringHash;

		# Load the values passed in into the QueryStringHash...
		@QueryStringParams	= CGI::param();
		%QueryStringHash	= &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

		my $cookie_name    	= &CgiFunctions::Get_Cookie_Value("cookie_name"	   , $DebugCgiFunctions);
		my $cookie_password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

		print "<!-- submit          = ($QueryStringHash{'submit'}) -->\n";
		print "<!-- cookie_name     = ($cookie_name) -->\n";
		print "<!-- cookie_password = ($cookie_password) -->\n";
		if ($cookie_name eq "" or $cookie_password eq "") 
			{
				&UtilityFunctions::Print_Framed_Error("<a href=\"/CreateLogin.html\"><img src=\"../images/PC_Flirt_Intro_Login.gif\" width=\"630\" height=\"501\" border=\"0\"></a>", $DebugUtilityFunctions, %Map) if($cookie_password eq "");
			}
		else
			{
				# Get the flirt_user_info table info for use throughout this application...
				my $SqlStatement = "SELECT * FROM flirt_user_info WHERE user_name = \'$cookie_name\'";
				my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "$ProgramName");
				$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
				$status = $MSSQL::DBlib::dbh->dbsqlexec();
					
				if($DatabaseFunctions::DatabaseError eq "1000" or $DatabaseFunctions::DatabaseError eq "1001")
					{
						&UtilityFunctions::Adv_Print_Framed_Error("", "User Name ($cookie_name) and password did not match.<BR><BR>", $DebugUtilityFunctions, %Map);		
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
													
												$first_name	= $$dataref{first_name};
												$last_name	= $$dataref{last_name};
												$phone1		= $$dataref{phone1};
												$phone2		= $$dataref{phone2};
												$phone3		= $$dataref{phone3};
												$carrier	= $$dataref{carrier};
												$city		= $$dataref{city};
												$state		= $$dataref{state};
												$zip		= $$dataref{zip};

												if($DebugThisAp eq "1")
													{
														print "<!-- first_name  = ($first_name) -->\n";
														print "<!-- last_name   = ($last_name) -->\n";
														print "<!-- phone1      = ($phone1) -->\n";
														print "<!-- phone2      = ($phone2) -->\n";
														print "<!-- phone3      = ($phone3) -->\n";
														print "<!-- carrier     = ($carrier) -->\n";
														print "<!-- city        = ($city) -->\n";
														print "<!-- state       = ($state) -->\n";
														print "<!-- zip         = ($zip) -->\n";
													}
											}
									}# END else (No db error) 
							}# END if($status != FAIL)
						else
							{
								print "ERROR: $SqlStatement Failed for first result set!\n";
								$status = $MSSQL::DBlib::dbh->dbcancel();
							}
					}

				# Process the different "submit" possibilities
				if ($QueryStringHash{'submit'} eq "Start Flirting") 
					{
						&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);

                        print "		<table bgcolor=\"ffffff\" width=\"100%\" height=\"434\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
                        print "          <tr> \n";
                        print "            <td height=\"327\"> \n";
                        print "              <table width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
                        print "              <tr> \n";
                        print "                <td width=\"415\" height=\"399\"> <img src=\"../images/section_names_start_flirtin.gif\" width=\"400\" height=\"99\"> \n";
                        print "                  <table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">\n";
                        print "                    <tr> \n";
                        print "                      <td class=\"BlackTextLargeBold\">Congratulations! You are \n";
                        print "                        now ready to start flirting.</td>\n";
                        print "                    </tr>\n";
                        print "                    <tr> \n";
                        print "                      <td>&nbsp;</td>\n";
                        print "                    </tr>\n";
                        print "                    <tr> \n";
                        print "                      <td>&nbsp;</td>\n";
                        print "                    </tr>\n";
                        print "                    <tr> \n";
                        print "                      <td>&nbsp;</td>\n";
                        print "                    </tr>\n";
                        print "                    <tr> \n";
                        print "                      <td height=\"37\">&nbsp;</td>\n";
                        print "                    </tr>\n";
                        print "                  </table>\n";
                        print "                  <p><img src=\"../images/spacer.gif\" width=\"10\" height=\"200\"></p>\n";
                        print "                  <p>&nbsp;</p>\n";
                        print "                  <p>&nbsp;</p>\n";
                        print "<td width=\"5%\"><p><a href=\"FlirtHelp.html\"><img src=\"../images/Flirt_Intro_Help.gif\" width=\"128\" height=\"59\" border=\"0\"></a></p>\n";
                        print "                    \n";
                        print "                  <p><img src=\"../images/persian_phone.jpg\"></p></td>\n";
                        print "                </tr>\n";
                        print "              </table>\n";
                        print "            </td>\n";
                        print "          </tr>\n";
                        print "          <tr> \n";
                        print "            <td> \n";
                        print "              <TABLE WIDTH=585 BORDER=0 CELLPADDING=0 CELLSPACING=0>\n";
                        print "                <TR> \n";
                        print "                  <TD> <img src=\"../images/FlirtStepsOff_01.gif\" alt=\"\"></TD>\n";
                        print "                  <TD> <IMG SRC=\"../images/FlirtStepsOff_02.gif\" ALT=\"\"></TD>\n";
                        print "                  <TD> <IMG SRC=\"../images/FlirtStepsOff_03.gif\" ALT=\"\"></TD>\n";
                        print "                  <TD> <IMG SRC=\"../images/FlirtSteps_04.gif\" ALT=\"\"></TD>\n";
                        print "                </TR>\n";
                        print "              </TABLE>\n";
                        print "            </td>\n";
                        print "          </tr>\n";
                        print "        </table>\n";
                        &UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
					}
				elsif ($QueryStringHash{'submit'} eq "ORDER NOW!") 
					{
						(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
						# use parsed date to create unique name for transaction_id and SSLOG_FILE...
						# Unique Name has the folling format username_m[m]_d[d]_yyyy_h[h]_m[m]_s[s]
						my $UniqueID = "Flirt_" . $cookie_name . "_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
						# use parsed date to create unique file name for SSLog file...
						my $UniqueSSLogFile = "$Map{'LOG_FOLDER'}/"  . $UniqueID . ".html";
						# Create and open the file that this program will populate...
						open (SSLOG_FILE, "> $UniqueSSLogFile") || die "Can't open $UniqueSSLogFile: $!\n";
						#print "After opening the log file.<BR>\n";

						my $ClockStart = localtime();
						print SSLOG_FILE "Start: ($ClockStart)<BR><BR>\n";
						my $transaction_id 		= $UniqueID;

					# Test ccn = 1234123412341234
						my $ccresp_respcode = ""; 
						my $ccresp_resp = ""; 
						my $ccresp_rrcode = "";
						my $ccresp_reasonstr = "";
						my $ccresp_amount = "";
						my $ccresp_fname = "";
						my $ccresp_lname = "";

						my $addcr_respcode = ""; 
						my $addcr_respstr = ""; 
						my $addcr_credits = "";
						my $addcr_phone = "";

						# Add transaction to database...
						my $SqlStatement = "flirt_transaction_send \'$transaction_id\'\
																		, \'$cookie_name\'\
																		, \'$first_name\'\
																		, \'$last_name\'\
																		, \'$phone1\'\
																		, \'$phone2\'\
																		, \'$phone3\'\
																		, \'$carrier\'\
																		, \'$city\'\
																		, \'$state\'\
																		, \'$zip\'\
																		, \'$QueryStringHash{'pack'}\'\
																		, \'$QueryStringHash{'cctype'}\'\
																		, \'$QueryStringHash{'exmon'}\'\
																		, \'$QueryStringHash{'exyear'}\'\
																		, \'$QueryStringHash{'ccn'}\'\
																		, \'$QueryStringHash{'bywho'}\'\
																		"; 

						my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
						if($return_value eq "1")
							{
								my $ua = new LWP::UserAgent;
								# URL to check process orders for flirt...
								# Development URL...
								my $URL = "https://www.cellus-usa.com/billing/creditbillingxtest.pl";
								# Production URL...
#								my $URL = "https://www.cellus-usa.com/billing/creditbillingx.pl";
								$URL = $URL . "?phone1=$phone1";
								$URL = $URL . "&phone2=$phone2";
								$URL = $URL . "&phone3=$phone3";
								$URL = $URL . "&state=$state";
								$URL = $URL . "&city=$city";
								$URL = $URL . "&zip=$zip";
								$URL = $URL . "&msnop=$carrier";
								$URL = $URL . "&exmon=$QueryStringHash{'exmon'}";
								$URL = $URL . "&exyear=$QueryStringHash{'exyear'}";
								$URL = $URL . "&ccn=$QueryStringHash{'ccn'}";
								$URL = $URL . "&fname=$first_name";
								$URL = $URL . "&lname=$last_name";
								$URL = $URL . "&bywho=$QueryStringHash{'bywho'}";
								$URL = $URL . "&pack=$QueryStringHash{'pack'}";
								$URL = $URL . "&action=$QueryStringHash{'action'}";
								# Not in spec...
		#						$URL = $URL . "&amount=6";

								# List all the field value pairs passed to Flirt processing...
								my $ContentList = $URL;
								print SSLOG_FILE "<BR>\n<FONT COLOR=\"#0000FF\">Field<\/FONT> = <FONT COLOR=\"#8B0000\">Value:<\/FONT><BR>\n<FONT COLOR=\"#0000FF\">";
								$ContentList =~ s/=/<\/FONT> = <FONT COLOR="#8B0000">/g;
								$ContentList =~ s/&/<BR><\/FONT>\n<FONT COLOR="#0000FF">/g;
								print SSLOG_FILE $ContentList . "<\/FONT>\n<BR>\n";

								my $request = new HTTP::Request('GET', $URL);
								$request->content_type('application/x-www-form-urlencoded');

								&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);

								my $response = $ua->request($request);
								if ($response->is_success) 
									{
										print SSLOG_FILE "SUCCESS:<BR>\n";
										print SSLOG_FILE "Response Code: (" . $response->code . ")<BR>\n";
										print SSLOG_FILE $response->content . "<BR>\n";
										print "<!-- SUCCESS: -->\n" if $DebugThisAp eq "1";
										print "<!-- URL: (" . $URL . ") -->\n" if $DebugThisAp eq "1";
										print "<!-- Response Code: (" . $response->code . ") -->\n" if $DebugThisAp eq "1";
										print "<!-- Response Content: (" . $response->content . ") -->\n" if $DebugThisAp eq "1";

										# Begin <ccresp>
										if ($response->content =~ m%<ccresp>.*<respcode>(.*)</respcode>.*</ccresp>%s) 
											{
												$ccresp_respcode	= $1;
												print "<!-- ccresp_respcode  = ($ccresp_respcode) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_respcode  = ($ccresp_respcode)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_respcode not found -->\n";
												print SSLOG_FILE "ccresp_respcode not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<resp>(.*)</resp>.*</ccresp>%s) 
											{
												$ccresp_resp		= $1;
												print "<!-- ccresp_resp      = ($ccresp_resp) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_resp      = ($ccresp_resp)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_resp not found -->\n";
												print SSLOG_FILE "ccresp_resp not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<rrcode>(.*)</rrcode>.*</ccresp>%s) 
											{
												$ccresp_rrcode		= $1;
												print "<!-- ccresp_rrcode    = ($ccresp_rrcode) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_rrcode    = ($ccresp_rrcode)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_rrcode not found -->\n";
												print SSLOG_FILE "ccresp_rrcode not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<reasonstr>(.*)</reasonstr>.*</ccresp>%s) 
											{
												$ccresp_reasonstr	= $1;
												print "<!-- ccresp_reasonstr = ($ccresp_reasonstr) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_reasonstr = ($ccresp_reasonstr)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_reasonstr not found -->\n";
												print SSLOG_FILE "resp_reasonstr not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<amount>(.*)</amount>.*</ccresp>%s) 
											{
												$ccresp_amount		= $1;
												print "<!-- ccresp_amount    = ($ccresp_amount) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_amount    = ($ccresp_amount)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_amount not found -->\n";
												print SSLOG_FILE "ccresp_amount not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<fname>(.*)</fname>.*</ccresp>%s) 
											{
												$ccresp_fname		= $1;
												print "<!-- ccresp_amount    = ($ccresp_amount) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_amount    = ($ccresp_amount)<BR>\n";
											}
										else
											{
												print "<!-- ccresp_fname not found -->\n";
												print SSLOG_FILE "ccresp_fname not found<BR>\n";
											}
										if ($response->content =~ m%<ccresp>.*<lname>(.*)</lname>.*</ccresp>%s) 
											{
												$ccresp_lname		= $1;
												print "<!-- ccresp_lname     = ($ccresp_lname) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "ccresp_lname     = ($ccresp_lname)<BR>\n";
											}
										else
											{
												print "<!-- lname not found -->\n";
												print SSLOG_FILE "lname not found<BR>\n";
											}
										# Begin <addcr>
										if ($response->content =~ m%<addcr>.*<respcode>(.*)</respcode>.*</addcr>%s) 
											{
												$addcr_respcode	= $1;
												print "<!-- addcr_respcode  = ($addcr_respcode) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "addcr_respcode  = ($addcr_respcode)<BR>\n";
											}
										else
											{
												print "<!-- addcr_respcode not found -->\n";
												print SSLOG_FILE "addcr_respcode not found<BR>\n";
											}
										if ($response->content =~ m%<addcr>.*<respstr>(.*)</respstr>.*</addcr>%s) 
											{
												$addcr_respstr	= $1;
												print "<!-- addcr_respstr  = ($addcr_respstr) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "addcr_respstr  = ($addcr_respstr)<BR>\n";
											}
										else
											{
												print "<!-- addcr_respstr not found -->\n";
												print SSLOG_FILE "addcr_respstr not found<BR>\n";
											}
										if ($response->content =~ m%<addcr>.*<credits>(.*)</credits>.*</addcr>%s) 
											{
												$addcr_credits	= $1;
												print "<!-- addcr_credits  = ($addcr_credits) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "addcr_credits  = ($addcr_credits)<BR>\n";
											}
										else
											{
												print "<!-- addcr_credits not found -->\n";
												print SSLOG_FILE "ddcr_credits not found<BR>\n";
											}
										if ($response->content =~ m%<addcr>.*<phone>(.*)</phone>.*</addcr>%s) 
											{
												$addcr_phone	= $1;
												print "<!-- addcr_phone  = ($addcr_phone) -->\n" if $DebugThisAp eq "1";
												print SSLOG_FILE "addcr_phone  = ($addcr_phone)<BR><BR>\n";
											}
										else
											{
												print "<!-- addcr_phone not found -->\n";
												print SSLOG_FILE "addcr_phone not found<BR><BR>\n";
											}

										# Update transaction in database...
										my $SqlStatement = "flirt_transaction_receive \'$transaction_id\'\
																						, \'$ccresp_resp\'\
																						, \'$ccresp_reasonstr\'\
																						, \'$ccresp_amount\'\
																						, \'$addcr_respstr\'\
																						, \'$addcr_credits\'\
																						"; 

										my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
										if($return_value eq "1")
											{
												print "\n<!-- SUCCESS:  Received message for ($transaction_id) was successfully logged to the DB. -->\n";
													
                                                print "          <TABLE bgcolor=\"ffffff\" width=\"100%\" height=\"487\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
                                                print "            <TR>\n";
                                                print "              <TD height=\"380\" valign=\"top\">\n";
                                                print "                <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
                                                print "                  <TR>\n";
                                                print "                    <TD width=\"477\" height=\"374\">\n";
                                                print "                      <TABLE cellspacing=\"0\" cellpadding=\"0\" width=\"400\" border=\"0\">\n";
                                                print "                        <TBODY>\n";
                                                print "                          <TR>\n";
                                                print "                            <TD height=\"338\">\n";
                                                print "                              <IMG src=\"../images/section_names_order_credits.gif\" width=\"400\" height=\"99\"> <!-- picker --> \n";
                                                print "                              <FORM name=\"Mobile_Receipt_Form\" action=\"FlirtCreateProfile.cgi\" method=\"post\">\n";
                                                
		  										print "                        <TABLE bgcolor=\"ffffff\" width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
												# Approved...
												if($ccresp_respcode eq "1")
													{
														# user_name / WHICH_CONNECTIONS...
														print "                          <TR>\n";
														print "                            <TD height=\"30\" colspan=\"3\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$cookie_name</FONT>,<BR> thank you for ordering $addcr_credits Flirt credits from $Map{'WHICH_CONNECTIONS'} for mobile phone number ($phone1) $phone2 - $phone3.</FONT></STRONG></FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
														# transaction_id...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" colspan=\"2\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $transaction_id</FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
														# plan / amount...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Credits:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" width=\"13%\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">$addcr_credits</FONT>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" width=\"55%\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Total: $ccresp_amount (US \$)</FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
													}
												# Declined...
												elsif($ccresp_respcode eq "2")
													{
														# user_name / WHICH_CONNECTIONS...
														print "                          <TR>\n";
														print "                            <TD height=\"30\" colspan=\"3\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$cookie_name</FONT>,<BR> $Map{'WHICH_CONNECTIONS'} is sorry but your credit card has been declined.</FONT></STRONG></FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
														# ccresp_reasonstr...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Reason Declined:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" colspan=\"2\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"#FF0033\"> $ccresp_reasonstr</FONT></FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
														# transaction_id...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" colspan=\"2\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $transaction_id</FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
													}
												# Error...
												elsif($ccresp_respcode eq "3" or $ccresp_respcode eq "")
													{
														# user_name / WHICH_CONNECTIONS...
														print "                          <TR>\n";
														print "                            <TD height=\"30\" colspan=\"3\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"3\"><FONT color=\"#FF0033\">$cookie_name</FONT>,<BR> $Map{'WHICH_CONNECTIONS'} is sorry but there has been an error while processing your transaction.</FONT></STRONG></FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
														# ccresp_reasonstr...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Error Message:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" colspan=\"2\">\n";
														if($ccresp_reasonstr ne "")
															{
																print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"#FF0033\"> $ccresp_reasonstr</FONT></FONT>\n";
															}
														else
															{
																print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"#FF0033\"> No message returned.\n<BR>Could be a URL error.</FONT></FONT>\n";
															}
														print "                            </TD>\n";
														print "                          </TR>\n";
														# transaction_id...
														print "                          <TR valign=\"middle\">\n";
														print "                            <TD height=\"30\" width=\"32%\">\n";
														print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Transaction ID:</FONT></STRONG>\n";
														print "                            </TD>\n";
														print "                            <TD height=\"30\" colspan=\"2\">\n";
														print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $transaction_id</FONT>\n";
														print "                            </TD>\n";
														print "                          </TR>\n";
													}
												# Unknown...
												else
													{
														# ccresp_respcode...
														print "\n<!-- Unknown ccresp_respcode: ($ccresp_respcode) -->\n";
													}

												# name_on_card...
												print "                          <TR valign=\"middle\">\n";
												print "                            <TD height=\"30\" width=\"32%\">\n";
												print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Cardholder's Name:</FONT></STRONG>\n";
												print "                            </TD>\n";
												print "                            <TD height=\"30\" colspan=\"2\">\n";
												print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $first_name $last_name</FONT>\n";
												print "                            </TD>\n";
												print "                          </TR>\n";
												# card_type...
												print "                          <TR valign=\"middle\">\n";
												print "                            <TD height=\"30\" width=\"32%\">\n";
												print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Card Type:</FONT></STRONG>\n";
												print "                            </TD>\n";
												print "                            <TD height=\"30\" colspan=\"2\">\n";
												print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> $QueryStringHash{'cctype'}</FONT>\n";
												print "                            </TD>\n";
												print "                          </TR>\n";
												# last_four...
												my $LastFour = substr($QueryStringHash{'ccn'}, -4); 
												print "                          <TR valign=\"middle\">\n";
												print "                            <TD height=\"30\" width=\"32%\">\n";
												print "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Account Number:</FONT></STRONG>\n";
												print "                            </TD>\n";
												print "                            <TD height=\"30\" colspan=\"2\">\n";
												print "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> ************$LastFour</FONT>\n";
												print "                            </TD>\n";
												print "                          </TR>\n";
                                                print "                          <TR>\n";
                                                print "                            <TD colspan=\"2\" class=\"AlignCenter\">\n";
                                                print "                              <P>\n";
                                                print "                                &nbsp;\n";
                                                print "                              </P>\n";
                                                print "                              <P>\n";
                                                print "                                <INPUT type=\"submit\" name=\"submit\" value=\"Start Flirting\">\n";
                                                print "                              </P>\n";
                                                print "                            </TD>\n";
                                                print "                          </TR>\n";

												print "                        </TABLE>\n";

                                                print "                   </FORM>\n";
                                                print "                 </TD>\n";
                                                print "               </TR>\n";
                                                print "             </TBODY>\n";
                                                print "           </TABLE>\n";
                                                print "          </TD>\n";
                                                print "          <TD width=\"141\">\n";
                                                print "            <P>\n";
                                                print "               <A href=\"FlirtHelp.html\"><IMG src=\"../images/Flirt_Intro_Help.gif\" width=\"128\" height=\"59\" border=\"0\"></A>\n";
                                                print "            </P>\n";
                                                print "            <P>\n";
                                                print "               <IMG src=\"../images/persian_phone.jpg\">\n";
                                                print "            </P>\n";
                                                print "          </TD>\n";
                                                print "        </TR>\n";
                                                print "      </TABLE>\n";
                                                print "    </TD>\n";
                                                print "  </TR>\n";
                                                print "  <TR>\n";
                                                print "    <TD>\n";
                                                print "      <TABLE width=\"585\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
                                                print "        <TR>\n";
                                                print "          <TD>\n";
                                                print "            <IMG src=\"../images/FlirtStepsOff_01.gif\" alt=\"\">\n";
                                                print "          </TD>\n";
                                                print "          <TD>\n";
                                                print "            <IMG src=\"../images/FlirtStepsOff_02.gif\" alt=\"\">\n";
                                                print "          </TD>\n";
                                                print "          <TD>\n";
                                                print "            <IMG src=\"../images/FlirtSteps_03.gif\" alt=\"\">\n";
                                                print "          </TD>\n";
                                                print "          <TD>\n";
                                                print "            <IMG src=\"../images/FlirtStepsOff_04.gif\" alt=\"\">\n";
                                                print "          </TD>\n";
                                                print "        </TR>\n";
                                                print "      </TABLE>\n";
                                                print "    </TD>\n";
                                                print "  </TR>\n";
                                                print "</TABLE>\n";
                                                &UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
											}
										elsif($DatabaseFunctions::DatabaseError eq "1012")
											{
												&UtilityFunctions::Print_Framed_Error("<FONT COLOR=\"#8B0000\">You must first <A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">verify your email address</A> before becoming a premium member.</FONT><BR><A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">click here to verify email...</A><BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
											}
										else
											{
												&UtilityFunctions::Print_Framed_Error("ERROR: Unable verify your transaction.<BR><BR>Please check your current number of Flirt credits before trying to purchase more credits.<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \n($DatabaseFunctions::DatabaseError)\n -->\n", $DebugUtilityFunctions, %Map);
											}
										}
									else 
										{
											print SSLOG_FILE "<!-- ERROR: -->\n";
											print SSLOG_FILE "<!-- URL: $URL -->\n";
											print SSLOG_FILE "<!-- Response Code: (" . $response->code . ") -->\n";
											print SSLOG_FILE $response->content . "\n";
											print SSLOG_FILE $response->error_as_HTML . "\n";

											print "<!-- ERROR: -->\n";
											print "<!-- URL: $URL -->\n";
											print "<!-- Response Code: (" . $response->code . ") -->\n";
											print $response->content . "\n";
											print $response->error_as_HTML . "\n";
										}
							}
						elsif($DatabaseFunctions::DatabaseError eq "1012")
							{
								&UtilityFunctions::Print_Framed_Error("<FONT COLOR=\"#8B0000\">You must first <A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">verify your email address</A> before becoming a premium member.</FONT><BR><A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">click here to verify email...</A><BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("ERROR: Unable to process your order.<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \n($DatabaseFunctions::DatabaseError)\n -->\n", $DebugUtilityFunctions, %Map);
							}
						my $ClockEnd = localtime();
						print SSLOG_FILE "End: ($ClockEnd)\n";
						#print SSLOG_FILE "Duration: ($ClockStart - $ClockEnd)\n";
						close(SSLOG_FILE);
						
					}
				elsif ($QueryStringHash{'submit'} eq "Submit 2") 
					{
						if($QueryStringHash{'msnop'} ne "" and $QueryStringHash{'state'} ne "")
							{
								# Update login_info table to change the user's email address...
								my $SqlStatement = "flirt_UpdateCarrierState \'$cookie_name\'\
																				, \'$cookie_password\'\
																				, \'$QueryStringHash{'msnop'}\'\
																				, \'$QueryStringHash{'state'}\'\
																				"; 

								my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
								if($return_value eq "1")
									{
										&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
										print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/FlirtCreateProfile.js\"></SCRIPT>\n";
										print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/MyFunctions.js\"></SCRIPT>\n";

										print "          <TABLE bgcolor=\"ffffff\" width=\"100%\" height=\"640\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
										print "            <TR>\n";
										print "              <TD height=\"534\">\n";
										print "                <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
										print "                 <FORM name=\"Purchase_Credits_Form\" action=\"FlirtCreateProfile.cgi\" method=\"post\" onsubmit=\"return checkCCFields(this)\">\n";
										print "                  <TR>\n";
										print "                    <TD width=\"415\" valign=\"top\">\n";
										print "                      <P class=\"BlackTextLarge3\">\n";
										print "                        <IMG src=\"../images/section_names_order_credits.gif\" width=\"400\" height=\"99\">\n";
										print "                      </P>\n";
										print "                      <TABLE width=\"400\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"BGLeftColumn\">\n";
										print "                        <TBODY>\n";
										print "                          <TR>\n";
										print "                            <TD class=\"BlackTextLargeBold\">\n";
										print "                              <INPUT type=\"radio\" value=\"a\" name=\"pack\"> A - 20 credits - \$5.99\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD class=\"BlackTextLargeBold\">\n";
										print "                              <INPUT type=\"radio\" value=\"b\" name=\"pack\"> B - 40 credits - \$10.99\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD class=\"BlackTextLargeBold\">\n";
										print "                              <INPUT type=\"radio\" value=\"c\" name=\"pack\"> C - 60 credits - \$14.99\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD height=\"16\" class=\"BlackTextLargeBold\">\n";
										print "                              <INPUT type=\"radio\" value=\"d\" name=\"pack\"> D - 80 credits - \$19.99\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD>\n";
										print "                              &nbsp;\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD width=\"50%\">\n";
										print "                              <TABLE cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\">\n";
										print "                                <TBODY>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      First Name:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <INPUT maxlength=\"32\" size=\"24\" value=\"$first_name\" name=\"fname\">\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"RedTextMediumAlignRight\">\n";
										print "                                      ex:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      John\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      <P class=\"AlignRight\">\n";
										print "                                        Last Name:\n";
										print "                                      </P>\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <INPUT maxlength=\"32\" size=\"24\" value=\"$last_name\" name=\"lname\">\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      Doe\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      City:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <INPUT maxlength=\"32\" id=\"city\" size=\"24\" value=\"$city\" name=\"city\">\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      Denver\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      Zip:\n";
										print "                                    </TD>\n";
										print "                                    <TD>\n";
										print "                                      <INPUT id=\"zip\" maxlength=\"5\" size=\"5\" value=\"$zip\" name=\"zip\">\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      80014\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      Card Type:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <SELECT name=\"cctype\">\n";
										print "                                        <OPTION>\n";
										print "                                          \n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION>\n";
										print "                                          MasterCard\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION>\n";
										print "                                          VISA\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION>\n";
										print "                                          American Express\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION>\n";
										print "                                          Discover\n";
										print "                                        </OPTION>\n";
										print "                                      </SELECT>\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      Visa\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      Card Number:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <INPUT onkeypress=\"CheckNumeric()\" maxlength=\"19\" name=\"ccn\" autocomplete=\"off\">\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      xxxxxxxxxxxxxxxx\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD class=\"AlignRight\">\n";
										print "                                      Expiration:\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\">\n";
										print "                                      <SELECT name=\"exmon\">\n";
										print "                                        <OPTION value=\"00\" selected>\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"01\">\n";
										print "                                          01 January\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"02\">\n";
										print "                                          02 February\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"03\">\n";
										print "                                          03 March\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"04\">\n";
										print "                                          04 April\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"05\">\n";
										print "                                          05 May\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"06\">\n";
										print "                                          06 June\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"07\">\n";
										print "                                          07 July\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"08\">\n";
										print "                                          08 August\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"09\">\n";
										print "                                          09 September\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"10\">\n";
										print "                                          10 October\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"11\">\n";
										print "                                          11 November\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"12\">\n";
										print "                                          12 December\n";
										print "                                        </OPTION>\n";
										print "                                      </SELECT> <SELECT name=\"exyear\">\n";
										print "                                        <OPTION value=\"00\" selected>\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"02\">\n";
										print "                                          2002\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"03\">\n";
										print "                                          2003\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"04\">\n";
										print "                                          2004\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"05\">\n";
										print "                                          2005\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"06\">\n";
										print "                                          2006\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"07\">\n";
										print "                                          2007\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"08\">\n";
										print "                                          2008\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"09\">\n";
										print "                                          2009\n";
										print "                                        </OPTION>\n";
										print "                                        <OPTION value=\"10\">\n";
										print "                                          2010\n";
										print "                                        </OPTION>\n";
										print "                                      </SELECT>\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                  <TR>\n";
										print "                                    <TD>\n";
										print "                                      &nbsp;\n";
										print "                                    </TD>\n";
										print "                                    <TD colspan=\"4\" class=\"RedTextMedium\">\n";
										print "                                      06 June 2003\n";
										print "                                    </TD>\n";
										print "                                  </TR>\n";
										print "                                </TBODY>\n";
										print "                              </TABLE>\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD colspan=\"2\" height=\"27\">\n";
										print "                              <P class=\"AlignCenter\">\n";
										print "                                 <INPUT type=\"checkbox\" value=\"0\" name=\"agree\"> <SPAN class=\"BlackTextLargeBold\">I have checked to make sure my phone has 2-way text mesaging.</SPAN>\n";
										print "                              </P>\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                          <TR>\n";
										print "                            <TD height=\"62\" colspan=\"2\">\n";
										print "                              <P class=\"AlignCenter\">\n";
										print "                                 <INPUT type=\"hidden\" value=\"1009\" name=\"bywho\"> <INPUT type=\"hidden\" value=\"processcc\" name=\"action\"> <INPUT type=\"submit\" value=\"ORDER NOW!\" name=\"submit\">\n";
										print "                              </P>\n";
										print "                            </TD>\n";
										print "                          </TR>\n";
										print "                        </TBODY>\n";
										print "                      </TABLE>\n";
										print "                    </TD>\n";
										print "                    <TD width=\"141\" class=\"AlignTop\">\n";
										print "                      <P class=\"AlignCenter\">\n";
										print "                        <A href=\"FlirtHelp.html\"><IMG src=\"../images/Flirt_Intro_Help.gif\" width=\"128\" height=\"59\" border=\"0\"></A>\n";
										print "                      </P>\n";
										print "                      <P>\n";
										print "                        <IMG src=\"../images/persian_phone.jpg\">\n";
										print "                      </P>\n";
										print "                    </TD>\n";
										print "                  </TR>\n";
										print "                </TABLE>\n";
										print "              </TD>\n";
										print "            </TR>\n";
										print "            <TR>\n";
										print "              <TD>\n";
										print "                <TABLE width=\"585\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
										print "                  <TR>\n";
										print "                    <TD>\n";
										print "                      <IMG src=\"../images/FlirtStepsOff_01.gif\" alt=\"\">\n";
										print "                    </TD>\n";
										print "                    <TD>\n";
										print "                      <IMG src=\"../images/FlirtStepsOff_02.gif\" alt=\"\">\n";
										print "                    </TD>\n";
										print "                    <TD>\n";
										print "                      <IMG src=\"../images/FlirtSteps_03.gif\" alt=\"\">\n";
										print "                    </TD>\n";
										print "                    <TD>\n";
										print "                      <IMG src=\"../images/FlirtStepsOff_04.gif\" alt=\"\">\n";
										print "                    </TD>\n";
										print "                  </TR>\n";
										print "                 </FORM>\n";
										print "                </TABLE>\n";
										print "              </TD>\n";
										print "            </TR>\n";
										print "          </TABLE>\n";

										&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
									}
								elsif($DatabaseFunctions::DatabaseError eq "1012")
									{
										&UtilityFunctions::Print_Framed_Error("<FONT COLOR=\"#8B0000\">You must first <A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">verify your email address</A> before becoming a premium member.</FONT><BR><A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">click here to verify email...</A><BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
									}
								else
									{
										&UtilityFunctions::Print_Framed_Error("ERROR: Unable to save your carrier ($QueryStringHash{'carrier'}) and state ($QueryStringHash{'state'}).<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \n($DatabaseFunctions::DatabaseError)\n -->\n", $DebugUtilityFunctions, %Map);
									}
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("ERROR: You must choose a valide carrier and state from the drop down menu\n<BR>carrier ($QueryStringHash{'carrier'}) / state ($QueryStringHash{'state'})<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
							}
					}
				elsif ($QueryStringHash{'submit'} eq "Submit 1") 
					{

						if($QueryStringHash{'phone1'} ne "" and $QueryStringHash{'phone2'} ne "" and $QueryStringHash{'phone3'} ne "")
							{
								# Update login_info table to change the user's email address...
								my $SqlStatement = "flirt_CreateUpdatePhoneNumber \'$cookie_name\'\
																				, \'$cookie_password\'\
																				, \'$QueryStringHash{'phone1'}\'\
																				, \'$QueryStringHash{'phone2'}\'\
																				, \'$QueryStringHash{'phone3'}\'\
																				"; 

								my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
								if($return_value eq "1")
									{
										&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
										print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/FlirtCreateProfile.js\"></SCRIPT>\n";
										print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/MyFunctions.js\"></SCRIPT>\n";

										print "            <TABLE bgcolor=\"ffffff\" width=\"100%\" height=\"487\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
										print "              <TR>\n";
										print "                <TD height=\"380\" valign=\"top\">\n";
										print "                  <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
										print "                    <TR>\n";
										print "                      <TD width=\"477\" height=\"374\">\n";
										print "                        <TABLE cellspacing=\"0\" cellpadding=\"0\" width=\"400\" border=\"0\">\n";
										print "                          <TBODY>\n";
										print "                            <TR>\n";
										print "                              <TD height=\"338\">\n";
										print "                                <IMG src=\"../images/section_names_select_servic.gif\" width=\"400\" height=\"99\"> <!-- picker --> \n";
										print "                                <FORM name=\"Mobile_Carrier_Form\" action=\"FlirtCreateProfile.cgi\" method=\"post\" onsubmit=\"return checkCarrierFields(this)\">\n";
										print "                                  <TABLE cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" border=\"0\">\n";
										print "                                    <TBODY>\n";
										print "                                      <TR>\n";
										print "                                        <TD width=\"311\">\n";
										print "                                          <TABLE width=\"400\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"BGLeftColumn\">\n";
										print "                                            <TBODY>\n";
										print "                                              <TR>\n";
										print "                                                <TD height=\"28\" class=\"BlackTextLargeBold\">\n";
										print "                                                  &nbsp;\n";
										print "                                                </TD>\n";
										print "                                                <TD colspan=\"4\" class=\"BlackTextLargeBold\">\n";
										print "                                                  <SPAN class=\"BlackTextLargeBold\">Select from the options below:</SPAN>\n";
										print "                                                </TD>\n";
										print "                                              </TR>\n";
										print "                                              <TR>\n";
										print "                                                <TD width=\"48\" class=\"BlackTextLargeBold\">\n";
										print "                                                  &nbsp;\n";
										print "                                                </TD>\n";
										print "                                                <TD width=\"67\" class=\"BlackTextLargeBold\">\n";
										print "                                                  Step 1\n";
										print "                                                </TD>\n";
										print "                                                <TD width=\"260\" colspan=\"3\">\n";
										print "                                                  <SPAN class=\"BlackTextLarge\">Select your phone Carrier:&nbsp;</SPAN>\n";
										print "                                                  <BR>\n";
										print "                                                   <SELECT name=\"msnop\">\n";
										print "                                                    <OPTION value=\"0\">\n";
										print "                                                      --Please select one--\n";
										print "                                                    </OPTION>\n";
										# carrier ...
										&DatabaseFunctions::Print_Lookup_Table_Options('flirt_carrier', '', $carrier, '', '1', $DebugThisAp, %Map);
										print "                                                  </SELECT>\n";
										print "                                                </TD>\n";
										print "                                              </TR>\n";
										print "                                              <TR>\n";
										print "                                                <TD colspan=\"5\">\n";
										print "                                                  <IMG height=\"10\" src=\"\" width=\"1\" border=\"0\">\n";
										print "                                                </TD>\n";
										print "                                              </TR>\n";
										print "                                              <TR>\n";
										print "                                                <TD width=\"48\" class=\"BlackTextLargeBold\">\n";
										print "                                                  &nbsp;\n";
										print "                                                </TD>\n";
										print "                                                <TD width=\"67\" height=\"55\" class=\"BlackTextLargeBold\">\n";
										print "                                                  Step 2\n";
										print "                                                </TD>\n";
										print "                                                <TD colspan=\"3\">\n";
										print "                                                  <SPAN class=\"BlackTextLarge\">Select Your State:&nbsp;</SPAN>\n";
										print "                                                  <BR>\n";
										print "                                                   <SELECT name=\"state\">\n";
										print "                                                    <OPTION value=\"0\">\n";
										print "                                                      --Please select one--\n";
										print "                                                    </OPTION>\n";
										# state ...
										&DatabaseFunctions::Print_Lookup_Table_Options('flirt_state', '', $state, '', '1', $DebugThisAp, %Map);
										print "                                                  </SELECT>\n";
										print "                                                </TD>\n";
										print "                                              </TR>\n";
										print "                                            </TBODY>\n";
										print "                                          </TABLE>\n";
										print "                                        </TD>\n";
										print "                                      </TR>\n";
										print "                                      <TR>\n";
										print "                                        <TD colspan=\"2\" class=\"AlignCenter\">\n";
										print "                                          <P>\n";
										print "                                            &nbsp;\n";
										print "                                          </P>\n";
										print "                                          <P>\n";
										print "                                            <INPUT type=\"submit\" name=\"submit\" value=\"Submit 2\">\n";
				#						print "                                            <A href=\"javascript:check();\"> <INPUT type=\"submit\" name=\"submit\" value=\"Submit 2\"></A>\n";
										print "                                          </P>\n";
										print "                                        </TD>\n";
										print "                                      </TR>\n";
										print "                                    </TBODY>\n";
										print "                                  </TABLE>\n";
										print "                                </FORM>\n";
										print "                                <!-- picker -->\n";
										print "                              </TD>\n";
										print "                            </TR>\n";
										print "                          </TBODY>\n";
										print "                        </TABLE>\n";
										print "                      </TD>\n";
										print "                      <TD width=\"141\">\n";
										print "                        <P>\n";
										print "                          <A href=\"FlirtHelp.html\"><IMG src=\"../images/Flirt_Intro_Help.gif\" width=\"128\" height=\"59\" border=\"0\"></A>\n";
										print "                        </P>\n";
										print "                        <P>\n";
										print "                          <IMG src=\"../images/persian_phone.jpg\">\n";
										print "                        </P>\n";
										print "                      </TD>\n";
										print "                    </TR>\n";
										print "                  </TABLE>\n";
										print "                </TD>\n";
										print "              </TR>\n";
										print "              <TR>\n";
										print "                <TD>\n";
										print "                  <TABLE width=\"585\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
										print "                    <TR>\n";
										print "                      <TD>\n";
										print "                        <IMG src=\"../images/FlirtStepsOff_01.gif\" alt=\"\">\n";
										print "                      </TD>\n";
										print "                      <TD>\n";
										print "                        <IMG src=\"../images/FlirtSteps_02.gif\" alt=\"\">\n";
										print "                      </TD>\n";
										print "                      <TD>\n";
										print "                        <IMG src=\"../images/FlirtStepsOff_03.gif\" alt=\"\">\n";
										print "                      </TD>\n";
										print "                      <TD>\n";
										print "                        <IMG src=\"../images/FlirtStepsOff_04.gif\" alt=\"\">\n";
										print "                      </TD>\n";
										print "                    </TR>\n";
										print "                  </TABLE>\n";
										print "                </TD>\n";
										print "              </TR>\n";
										print "            </TABLE>\n";

										&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
									}
								elsif($DatabaseFunctions::DatabaseError eq "1012")
									{
										&UtilityFunctions::Print_Framed_Error("<FONT COLOR=\"#8B0000\">You must first <A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">verify your email address</A> before becoming a premium member.</FONT><BR><A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">click here to verify email...</A><BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
									}
								else
									{
										&UtilityFunctions::Print_Framed_Error("ERROR: Unable to save your mobile phone number ($QueryStringHash{'phone1'}) $QueryStringHash{'phone2'} - $QueryStringHash{'phone3'}.<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \n($DatabaseFunctions::DatabaseError)\n -->\n", $DebugUtilityFunctions, %Map);
									}
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("ERROR: You must enter a valide mobile phone number\n<BR>The number you entered ($QueryStringHash{'phone1'}) $QueryStringHash{'phone2'} - $QueryStringHash{'phone3'} is not valid.<BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n", $DebugUtilityFunctions, %Map);
							}
					}
				else
					{
						&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);
						print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/FlirtCreateProfile.js\"></SCRIPT>\n";
						print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/MyFunctions.js\"></SCRIPT>\n";

						print "          <TABLE bgcolor=\"ffffff\" width=\"100%\" height=\"501\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
						print "            <TR>\n";
						print "              <TD height=\"405\" valign=\"top\">\n";
						print "                <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
						print "                  <TR>\n";
						print "                    <TD width=\"472\" height=\"399\">\n";
						print "                      <TABLE cellspacing=\"0\" cellpadding=\"0\" width=\"400\" border=\"0\">\n";
						print "                        <TBODY>\n";
						print "                          <TR>\n";
						print "                            <TD>\n";
						print "                              <P>\n";
						print "                                <SPAN class=\"BlackTextLargeBold\"><IMG src=\"../images/section_names_enter_phone.gif\" width=\"400\" height=\"99\">\n";
						print "                                <BR>\n";
						print "                                <BR>\n";
						print "                                 Enter your 10-digit mobile number.</SPAN>\n";
						print "                              </P>\n";
						print "                              <FORM name=\"Mobile_Number_Form\" action=\"FlirtCreateProfile.cgi\" method=\"post\" onsubmit=\"return checkPhoneFields(this)\">\n";
						print "                                <TABLE width=\"400\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\" class=\"BGLeftColumn\">\n";
						print "                                  <TBODY>\n";
						print "                                    <TR>\n";
						print "                                      <TD>\n";
						print "                                        <TABLE cellspacing=\"0\" cellpadding=\"2\" width=\"366\" border=\"0\">\n";
						print "                                          <TBODY>\n";
						print "                                            <TR>\n";
						print "                                              <TD width=\"135\" class=\"BlackTextLargeBold\">\n";
						print "                                                Mobile Number\n";
						print "                                              </TD>\n";
						print "                                              <TD width=\"223\">\n";
						print "                                                (<INPUT onkeypress=\"CheckNumeric()\" id=\"phone1\" onkeyup=\"return autoTab(this, 3, event);\" maxlength=\"3\" size=\"3\" name=\"phone1\" value=\"$phone1\"> )<INPUT onkeypress=\"CheckNumeric()\" id=\"phone2\" onkeyup=\"return autoTab(this, 3, event);\" maxlength=\"3\" size=\"3\" name=\"phone2\" value=\"$phone2\"> - <INPUT onkeypress=\"CheckNumeric()\" id=\"phone3\" maxlength=\"4\" size=\"4\" name=\"phone3\" value=\"$phone3\">\n";
						print "                                              </TD>\n";
						print "                                            </TR>\n";
						print "                                            <TR>\n";
						print "                                              <TD width=\"135\">\n";
						print "                                                &nbsp;\n";
						print "                                              </TD>\n";
						print "                                              <TD width=\"223\">\n";
						print "                                                <BR>\n";
						print "                                                 <INPUT type=\"submit\" name=\"submit\" value=\"Submit 1\">\n";
						print "                                              </TD>\n";
						print "                                            </TR>\n";
						print "                                          </TBODY>\n";
						print "                                        </TABLE>\n";
						print "                                      </TD>\n";
						print "                                    </TR>\n";
						print "                                  </TBODY>\n";
						print "                                </TABLE>\n";
						print "                              </FORM>\n";
						print "                              <TABLE width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">\n";
						print "                                <TR>\n";
						print "                                  <TD>\n";
						print "                                    <SPAN class=\"BlackTextLargeBold\">PersianFlirt is currently only available to subscribers of the following services:</SPAN>\n";
						print "                                  </TD>\n";
						print "                                </TR>\n";
						print "                                <TR>\n";
						print "                                  <TD>\n";
						print "                                    &nbsp;\n";
						print "                                  </TD>\n";
						print "                                </TR>\n";
						print "                                <TR>\n";
						print "                                  <TD>\n";
						print "                                    <SPAN class=\"BlackTextLarge\">Alltel, AT&amp;T, Centennial Wireless, Centurytel, Cincinnati Bell, Cingular, Cricket, Dobson, Metro PCS, Minnesota Southern Wireless, Nextel, Primeco Chicago, Qwest Wireless, T-Mobile, Verizon, and Western Wireless.</SPAN>\n";
						print "                                  </TD>\n";
						print "                                </TR>\n";
						print "                                <TR>\n";
						print "                                  <TD>\n";
						print "                                    &nbsp;\n";
						print "                                  </TD>\n";
						print "                                </TR>\n";
						print "                                <TR>\n";
						print "                                  <TD>\n";
						print "                                    &nbsp;\n";
						print "                                  </TD>\n";
						print "                                </TR>\n";
						print "                              </TABLE>\n";
						print "                            </TD>\n";
						print "                          </TR>\n";
						print "                        </TBODY>\n";
						print "                      </TABLE>\n";
						print "                    </TD>\n";
						print "                    <TD width=\"141\">\n";
						print "                      <P>\n";
						print "                        <A href=\"FlirtHelp.html\"><IMG src=\"../images/Flirt_Intro_Help.gif\" width=\"128\" height=\"59\" border=\"0\"></A>\n";
						print "                      </P>\n";
						print "                      <P>\n";
						print "                        <IMG src=\"../images/persian_phone.jpg\">\n";
						print "                      </P>\n";
						print "                    </TD>\n";
						print "                  </TR>\n";
						print "                </TABLE>\n";
						print "              </TD>\n";
						print "            </TR>\n";
						print "            <TR>\n";
						print "              <TD>\n";
						print "                <TABLE width=\"585\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
						print "                  <TR>\n";
						print "                    <TD>\n";
						print "                      <IMG src=\"../images/FlirtStepsOff_01.gif\" alt=\"\">\n";
						print "                    </TD>\n";
						print "                    <TD>\n";
						print "                      <IMG src=\"../images/FlirtStepsOff_02.gif\" alt=\"\">\n";
						print "                    </TD>\n";
						print "                    <TD>\n";
						print "                      <IMG src=\"../images/FlirtStepsOff_03.gif\" alt=\"\">\n";
						print "                    </TD>\n";
						print "                    <TD>\n";
						print "                      <IMG src=\"../images/FlirtStepsOff_04.gif\" alt=\"\">\n";
						print "                    </TD>\n";
						print "                  </TR>\n";
						print "                </TABLE>\n";
						print "              </TD>\n";
						print "            </TR>\n";
						print "          </TABLE>\n";
						&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);
					}
			}
	}

#End HTML...
print "</HTML>\n";
exit 0;
