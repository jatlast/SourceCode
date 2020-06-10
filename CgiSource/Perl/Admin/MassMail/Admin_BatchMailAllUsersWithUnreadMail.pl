#!/usr/local/bin/perl -w

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
require "SendMailFunctions.pl";
require "UtilityFunctions.pl";

my $ProgramName = "Admin_BatchMailAllUsersWithUnreadMail.pl";

my $DebugThisAp			   = "1";
my $DebugDatabaseFunctions = "0";
my $DebugMailSendFunctions = "0";
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
		print "<!-- $Map{'SYSTEM'} -->\n";
	}

# Parse the current date...
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
# use parsed date to create unique name for the RECOVERY_FILE...
# Unique Name has the folling format Admin_BatchUnreadMail_m[m]_d[d]_yyyy_h[h]_m[m]_s[s]
my $UniqueID = "Admin_BatchUnreadMail_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
# use parsed date to create unique file name for RECOVERY_FILE file...
my $UniqueRecoveryFile = "Log/"  . $UniqueID . ".html";

# Create and open the file that this program will populate...
open (RECOVERY_FILE, "> $UniqueRecoveryFile") || die "Can't open $UniqueRecoveryFile: $!\n";

my $Now = localtime();

print RECOVERY_FILE "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
print RECOVERY_FILE "<HTML>\n";
print RECOVERY_FILE "  <HEAD>\n";
print RECOVERY_FILE "    <TITLE>\n";
print RECOVERY_FILE "      	$ProgramName time out recovery file started at $Now\n";
print RECOVERY_FILE "    </TITLE>\n";
# Open in new JavaScript...
print RECOVERY_FILE"	 <SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
print RECOVERY_FILE"	 <!--\n";
print RECOVERY_FILE"	 function newWindowGeneric(picName) \n";
print RECOVERY_FILE"	 {\n";
print RECOVERY_FILE"	 		var myWindow = window.open(picName, 'Guidelines', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=850,height=1000')\n";
print RECOVERY_FILE"				myWindow.focus()\n";
print RECOVERY_FILE"	 }\n";
print RECOVERY_FILE"	 // -->\n";
print RECOVERY_FILE"	 </SCRIPT>\n";
	
print RECOVERY_FILE "  </HEAD>\n";
print RECOVERY_FILE "  <BODY>\n";
print RECOVERY_FILE "    <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"700\">\n";
print RECOVERY_FILE "            <TR align=\"left\">\n";
print RECOVERY_FILE "              <TD>\n";
print RECOVERY_FILE "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>Results from sending multiple unique \"To:\" messages to all users with unread mail in all databases.</STRONG></FONT>\n";
print RECOVERY_FILE "                  <BR>&nbsp;<BR>\n";
print RECOVERY_FILE "              </TD>\n";
print RECOVERY_FILE "            </TR>\n";


# Build email to send to the person receiving the new PC Mail...
my $BlatExe 		= "$Map{'BLAT_PATH'}/EXE/blat.exe ";
my $MailServer 		= "$Map{'SMTP_HOST'}";
my $BlatLog 		= "$Map{'BLAT_PATH'}/LOG/Blat.log";

my $SentFrom 		= "";

my $GoodMailCount 	= 0;
my $ErrorMailCount 	= 0;
my $Temp 		 	= "";

my $_sent_to	 			= "";
my $_count		 			= "";
my $_db_name	 			= "";
my $_email		 			= "";
my $_sex		 			= "";
my $_password	 			= "";
my $_days_since_last_login	= "";
my $_last_name			 	= "";

my $RootURL	= "";
my $WebName	= "";

# Sql statement used to access the desired group to SPAM...
my $SqlStatement = 'sp_admin_GetUsersWithUnreadMail';

print RECOVERY_FILE "            <TR align=\"left\">\n";
print RECOVERY_FILE "              <TD>\n";
print RECOVERY_FILE "                  Mailing all users who are returned by the following SQL statement:\n";
print RECOVERY_FILE "                  <HR>\n";
print RECOVERY_FILE "                  $SqlStatement\n";
print RECOVERY_FILE "              </TD>\n";
print RECOVERY_FILE "            </TR>\n";
 
my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "UnreadMailSpam");
$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
$status = $MSSQL::DBlib::dbh->dbsqlexec();

	
##########################
# Get Only result set...
##########################
# dbresults() must be called for each result set...
$status = $MSSQL::DBlib::dbh->dbresults();
if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
	{
		my $Count = 1;
		my $Bcc_Every = $Map{'SPAM_BCC_EVERY'}; #this is used with the modulus operator (%) to send a bcc mail every time (Bcc_Every % Count) == 0
		my %dataref = ("jason" => "baumbach");
		my $dataref = \%dataref;
		# If in debug mode, print information...
		if($DebugThisAp == 1)
			{
				print RECOVERY_FILE "<!-- SQL: $SqlStatement -->\n";
			}
		# Check for global DB error...
		if($DatabaseFunctions::DatabaseError eq "1")
			{
				print RECOVERY_FILE "ERROR: ($SqlStatement) Failed!<BR>\n";
			}
		else
			{
			my $MaxCount = $Map{'SPAM_TOTAL_MAIL_TO_SEND'};
				# Prevent infinite loop...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
					{
					last if $Count > $MaxCount; 
						if($Count >= $Map{'SPAM_START_AFTER_MAIL_COUNT'}) # change this paramater to limit the number of mails sent
							{
								# Get special LinkMap keys based on the DB name...
								$_db_name = $$dataref{_db_name};
								$_db_name =~ s/\s//g;

								my $RootURLKey = $_db_name;
								$RootURLKey = $RootURLKey . "_ROOT";

								my $WebNameKey = $_db_name;
								$WebNameKey = $WebNameKey . "_NAME";

								my $EmailKey = $_db_name;
								$EmailKey = $EmailKey . "_EMAIL";
								$SentFrom = $Map{$EmailKey};

								$_email	= $$dataref{_email};
								$_email =~ s/\s//g;

								$_sent_to = $$dataref{_sent_to};
								$_sent_to =~ s/\s//g;

								# Since there is no global DB error check if email address is valid
								if($_email !~ m/\@/g || $_email eq "")
									{
										print RECOVERY_FILE "\n<!-- Email ERROR: user_name = ($_sent_to) dataref{_email} = ($$dataref{_email}) -->\n";
										$ErrorMailCount++;
									}
								# If a spacific database name does not get a LinkMap value do NOT send mail...
								elsif($Map{$RootURLKey} !~ m/\w/ || $Map{$WebNameKey} !~ m/\w/ || $Map{$EmailKey} !~ m/\w/ )
									{
										print RECOVERY_FILE "\n<!-- LinkMap ERROR: user_name = ($_sent_to) _email = ($_email) Count = ($Count) -->\n";
										print RECOVERY_FILE "<!-- LinkMap ERROR: Map{$RootURLKey} = ($Map{$RootURLKey}) -->\n";
										print RECOVERY_FILE "<!-- LinkMap ERROR: Map{$WebNameKey} = ($Map{$WebNameKey}) -->\n";
										print RECOVERY_FILE "<!-- LinkMap ERROR: Map{$EmailKey}   = ($Map{$EmailKey}) -->\n";
										$ErrorMailCount++;
									}
								else
									{
										$_count		 			= $$dataref{_count};
										$_count =~ s/\s//g;

										$_sex		 			= $$dataref{_sex};
										$_sex =~ s/\s//g;

										$_password	 			= $$dataref{_password};

										$_days_since_last_login	= $$dataref{_days_since_last_login};

										$_last_name			 	= $$dataref{_last_name};

										if($_last_name !~ m/\w/)
											{
												$_last_name = $_sent_to;
											}
										else
											{
#												print "<!-- _last_name = ($_last_name) -->\n";
											}


										# Test...	
										if($Map{'SPAM_TEST_MODE'} eq "1")
    										{
												$_email= $Map{'SPAM_TEST_MAIL'};
    										}
										
										my $BccAddress = $Map{'SPAM_BCC_MAIL'};

										my $Subject	= "Hello";

										if($_sex eq "1")
											{
												$Subject = $Subject . " Mr. $_last_name";
											}
										else
											{
												$Subject = $Subject . " Ms. $_last_name";
											}
										
										my $Message = "This messages is to inform you that we have not seen you at $Map{$WebNameKey} for $_days_since_last_login days and now you have $_count unread mail messages.\n\nUser Name:	$_sent_to\nPassword:	$_password\n\nPlease log in to $Map{$RootURLKey} to view your new mail.\n\nThank you,\n\n$Map{$WebNameKey}\n$Map{$EmailKey}";

										if($_email =~ m/hotmail.com/i)
											{
												$Message = $Message . "\n\n\n\nNOTE:  In order to avoid improper browser behavior please copy and past the link you wish to access into a seperate browser's address bar.";
												$Message = $Message . "\n\nWe apologize for the inconvenience this may cause you, but unfortunately your current Hotmail window has an external domain that will cause login problems while navigating $Map{$WebNameKey}.";
											}
										my $return_code = "";
										
										# check if a status bcc mail should be sent...
										#print "Bcc_Every = $Bcc_Every\n";
										#print "mod = " . ($Count % $Bcc_Every) . "\n";
										if( ($Count % $Bcc_Every) == 0)
    										{
    										 	$return_code = &My_Send_Individual_Blat_Mail($BlatExe, $MailServer, $BlatLog, $SentFrom, $_email, $BccAddress, $Subject, $Message);
    										}
										else
    										{
    										 	$return_code = &My_Send_Individual_Blat_Mail($BlatExe, $MailServer, $BlatLog, $SentFrom, $_email, "", $Subject, $Message);
    										}

										if($return_code < 1)
											{
												$GoodMailCount++;
												print RECOVERY_FILE "<TR><TD>Sent Mail ($Count) to: $_email</TD></TR>\n";
												print "($GoodMailCount) Sent mail to: ($_email)\n";
											}
										else
											{
												$ErrorMailCount++;
												print RECOVERY_FILE "<TR><TD><FONT color=\"red\">Error!</FONT> Resend Mail ($Count): <A href=\"javascript:newWindowGeneric('$Map{'SPAM_CGIBIN'}/Admin_GenSendMail.cgi?sent_from=$SentFrom&amp;sent_to=$_email&amp;sent_bcc=&amp;subject=$Subject&amp;message_text=$Message')\">$_email</A></TD></TR>\n";
												print "($ErrorMailCount) Error sending mail to: ($_email)\n";
											}
									}# END else (valid Email Address)
							}# if count++ > 2240
						$Count++;
					}# END while != NO_MORE_ROWS
			}# END else (No db error) 
        }# END if($status != FAIL)
else
	{
		print "ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}
	
print RECOVERY_FILE "                    <TR>\n";
print RECOVERY_FILE "                      <TD>\n";
print RECOVERY_FILE "						   $GoodMailCount sent mail.\n";
print RECOVERY_FILE "                      </TD>\n";
print RECOVERY_FILE "                    </TR>\n";
print RECOVERY_FILE "                    <TR>\n";
print RECOVERY_FILE "                      <TD>\n";
print RECOVERY_FILE "						   $ErrorMailCount not sent mail.\n";
print RECOVERY_FILE "                      </TD>\n";
print RECOVERY_FILE "                    </TR>\n";
print RECOVERY_FILE "                    <TR>\n";
$Now = localtime();
print RECOVERY_FILE "                    <TR>\n";
print RECOVERY_FILE "                      <TD>\n";
print RECOVERY_FILE "						   End: $Now\n";
print RECOVERY_FILE "                      </TD>\n";
print RECOVERY_FILE "                    </TR>\n";
print RECOVERY_FILE "                    <!-- Close Window -->\n";
print RECOVERY_FILE "                    <TR>\n";
print RECOVERY_FILE "                      <TD>\n";
print RECOVERY_FILE "						   <INPUT TYPE=BUTTON VALUE=\"Close Window\" onClick=\"Closer()\">\n";
print RECOVERY_FILE "                      </TD>\n";
print RECOVERY_FILE "                    </TR>\n";
print RECOVERY_FILE "						  <SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
print RECOVERY_FILE "						  <!--\n";
print RECOVERY_FILE "    					 		 function Closer()\n";
print RECOVERY_FILE "    							 {\n";
print RECOVERY_FILE "        						 	  window.close()\n";
print RECOVERY_FILE "    							 }\n";
print RECOVERY_FILE "						  //-->\n";
print RECOVERY_FILE "						 </SCRIPT>\n";
	
print RECOVERY_FILE "          </TABLE>\n";
print RECOVERY_FILE "        </TD>\n";
print RECOVERY_FILE "        <!-- End Main Data Cell -->\n";
print RECOVERY_FILE "      </TR>\n";
print RECOVERY_FILE "      <!-- End Navigation and Main Row -->\n";
print RECOVERY_FILE "    </TABLE>\n";
	
print RECOVERY_FILE "  </BODY>\n";
print RECOVERY_FILE "</HTML>\n";
	
close (RECOVERY_FILE);
	
sub My_Send_Individual_Blat_Mail
	{
		my($BlatPath, $MailServer, $BlatLogFilePath, $SentFrom, $SentTo, $BccFile, $Subject, $MessageText, %Map) = @_;
			
		my $TempFile		= "";
		my $TempFilePath 	= "C://Temp";
			
		(my $return_value, my $output)= &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $SentFrom, $SentTo, $BccFile, $Subject, $TempFile, $MessageText, $TempFilePath, $BlatLogFilePath, $DebugMailSendFunctions);
		if($return_value < 1)
			{
				return 0;
			}
		else
			{
				print "\n<!-- Mail_Blat Error return_value = $return_value \n output = $output\n-->\n" if $DebugThisAp eq "1";
				return 1;
			}
	}# END Send_Individual_Blat_Mail

exit 0;
