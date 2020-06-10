#!/usr/local/bin/perl -w
use strict;
use Tk;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "DatabaseFunctions.pl";
require "SendMailFunctions.pl";

my $DebugThisAp			   = "1";
my $DebugDatabaseFunctions = "0";
my $DebugMailSendFunctions = "0";

my $ProgramName = "Admin_MassMail.pl";
# Global file name that is automatically generated when Get_Unique_File_Name is called
# Open_Recovery_File also depends on "UniqueFileName" 
my $UniqueFileName = "";

my $PreSendMailFile   = "PreSendMail.html";
my $PreMailStatus = "0";
my $TotalMailToSend = 0;

my $mw = MainWindow->new;

$mw->title("Mass Email GUI");

my $info = "Program Waiting...";
################################################
# Create Info Label for bottom of the screen...										
################################################
my $label_l = $mw->Label(-textvariable => \$info
, -relief => 'ridge')->pack(-side => 'bottom'
		   				, -fill => 'x'
);

################################################
# Create Which Connections Dialog Frame...
my $dialog_f = $mw->Frame()->pack(-side => 'top');
	
# Create Which Connecitons Label...										
my $wc_l = $dialog_f->Label(-text => "Which Connections:"
)->pack(-side => 'left');		
 
# Create Which Connecitons Optionmenu...										
my $wc_value = "";
my $wc_om = $dialog_f->Optionmenu(-options => [(qw/Persian Israeli Personals Test/)]
, -variable => \$wc_value
)->pack;
 
################################################
# Create Dev/Test/Live Radio Buttons Frame...
my $dtl_f = $mw->Frame()->pack(-side => 'top');
# the default value for the Dev/Test/Live Radio Button selection
my $dtl_value = "";					
	
# Create Dev Radio Button...										
$dtl_f->Radiobutton(-text => 'Dev'
, -value => 'Dev'
, -variable => \$dtl_value
)->pack(-side => 'left');
# Create Test Radio Buttons...										
$dtl_f->Radiobutton(-text => 'Test'
, -value => 'Test'
, -variable => \$dtl_value
)->pack(-side => 'left');
# Create Live Radio Buttons...										
$dtl_f->Radiobutton(-text => 'Live'
, -value => 'Live'
, -variable => \$dtl_value
)->pack(-side => 'left');
 
################################################
## Create From Dialog Frame...
#$from_f = $mw->Frame()->pack(-side => 'top');
#	
## Create From Label...										
#$from_l = $from_f->Label(-text => "From:"
#					)->pack(-side => 'left');			   
## Create From Optionmenu...										
#$from_value = "";
#$from_om = $from_f->Optionmenu(-options => [(qw/admin@PersianConnections.com connections.admin@verizon.com personals.admin@verizon.com/)]
#		   					 , -variable => \$from_value
#							 )->pack;
 
################################################
# Create To Frame...
my $to_f = $mw->Frame()->pack(-side => 'top'
);
# Create From Optionmenu...										
my $to_l = $to_f->Label(-text => "To:"
)->pack(-side => 'left');			   
my $to_value = "";
my $to_om = $to_f->Optionmenu(-options => ["All Users"
, "Users Older Than 3 Months"
, "Users With Duplicate Profiles"
, "Users With Unread Mail"
, "Users Who Have Not Logged In For 1 Month"
, "Users Outside The USA"
]
#                		 , -command => \&Default_Message
, -variable => \$to_value
)->pack;

#    $to->addOptions([may=>5],[jun=>6],[jul=>7],[aug=>8]);

#    $sql_f->Label(-textvariable=>\$var, -relief=>'groove')->pack;

################################################
# Create Internal/External/Both Radio Buttons Frame...
my $ieb_f = $mw->Frame()->pack(-side => 'top');
# the default value for the Dev/Test/Live Radio Button selection
my $ieb_value = "Both";					
	
# Create Dev Radio Button...										
$ieb_f->Radiobutton(-text => 'Internal'
, -value => 'Internal'
, -variable => \$ieb_value
)->pack(-side => 'left');
# Create Test Radio Buttons...										
$ieb_f->Radiobutton(-text => 'External'
, -value => 'External'
, -variable => \$ieb_value
)->pack(-side => 'left');
# Create Live Radio Buttons...										
$ieb_f->Radiobutton(-text => 'Both'
, -value => 'Internal and External'
, -variable => \$ieb_value
)->pack(-side => 'left');
 
 
################################################
# Create Subject Frame...
my $subject_f = $mw->Frame()->pack(-side => 'top'
);
	
# Create Subject Label...										
my $subject_l = $subject_f->Label(-text => "Subject:"
)->pack(-side => 'left');	

my $subject_value = "";		   
# Create Subject Entry...										
my $subject_e = $subject_f->Entry(-textvariable => \$subject_value
, -width => 70
)->pack(-side => 'left');			   

################################################
# Create Message Frame...
my $message_f = $mw->Frame()->pack(-side => 'top'
);
	
# Create Message Label...										
my $message_l = $message_f->Label(-text => "Message:"
)->pack(-side => 'left');			   
# Create Message Text...										
my $message_t = $message_f->Scrolled("Text"
, -scrollbars => 'oe'
, -width => 70
, -height => 20
, -wrap => 'word'
)->pack(-side => 'left');			   
 
################################################
# Create Action Buttons Frame...
my $action_f = $mw->Frame()->pack(-side => 'top'
);
my $exit_b = $action_f->Button(-text => "Quit"
, -command => sub { exit; } 
)->pack(-side => 'right');
 
my $open_recovery_b = $action_f->Button(-text => "Open Recovery File"
, -state => 'disabled'
, -command => \&Open_Recovery_File)->pack(-side => 'right');

my $save_default_b = $action_f->Button(-text => "Save as Default"
, -command => \&Save_Default_File)->pack(-side => 'right');

my $restore_default_b = $action_f->Button(-text => "Restore Defaults"
, -command => \&Default_Message )->pack(-side => 'right');
 
my $send_mail_b = $action_f->Button(-text => "Send Mails"
, -command => [ \&Send_Mass_Mail, "Mass_Mail" ]
, -state => 'disabled'
)->pack(-side => 'right');

my $send_test_b = $action_f->Button(-text => "Send Test Mail"
, -command => [ \&Send_Mass_Mail, "Test_Mail" ]
, -state => 'disabled'
)->pack(-side => 'right');

my $pre_send_mail_b = $action_f->Button(-text => "Pre-Send Mails"
, -state => 'disabled'
, -command => \&Pre_Send_Mail 
)->pack(-side => 'right');
###################################################
# Add the command option to the To field...
# (NOTE: this must be done after the Message Text has been defined)
$wc_om->configure(-command => \&Activate_Pre_Send_Mail);
#$from_om->configure(-command => \&Activate_Pre_Send_Mail);
$to_om->configure(-command => \&Default_Message);

##############################################################
######################## END GUI #############################
##############################################################

MainLoop;


sub Activate_Pre_Send_Mail
	{
		$pre_send_mail_b->configure(-state => 'normal');
	}
	
# Default_Message determins what file to find then tries to open it to
# display the contained mail text in "supject_value" and "message_t"...
sub Default_Message 
	{
		my $FileToOpen = &Get_Default_File_Name;
		$info = "Loading file '$FileToOpen'...";
		$subject_value = "";
		$message_t->delete("1.0", "end");
		if (!open(FILE_TO_OPEN, "$FileToOpen")) {
			$message_t->insert("end", "ERROR: Could not open $FileToOpen\n"); 
			return; 
		}
	my $WhichConnections = $wc_value . "Connections";
	while (<FILE_TO_OPEN>) 
		{ 
			if($_ =~ m/SUBJECT:/)
				{
					s/SUBJECT://;
					$subject_value =  $_; 
				}
			else
				{
					$message_t->insert("end", $_); 
				}
		}
	close (FILE_TO_OPEN);
	$pre_send_mail_b->configure(-state => 'normal');
	$info = "File '$FileToOpen' loaded";
}

# Save_Default_File saves the file using the filename in the entry box.
sub Save_Default_File {
	my $FileToOpen = &Get_Default_File_Name;
	$info = "Replacing '$FileToOpen'";
	open (FILE_TO_REPLACE, ">$FileToOpen");
	print FILE_TO_REPLACE "SUBJECT:" . $subject_value . "\n";
	print FILE_TO_REPLACE $message_t->get("1.0", "end");
	$info = "Saved '$FileToOpen' As New '$to_value' Default Message File.";
	close(FILE_TO_REPLACE);
}# END sub Save_Default_File


sub Pre_Send_Mail
	{
		use LWP::UserAgent;
		use HTTP::Request;
		use HTTP::Response;
			
		my $ua = new LWP::UserAgent;
		if($wc_value eq "Persian" and $dtl_value eq "Dev")
			{
				$ua->proxy('http', 'http://SMITHERS:8080/');
			}
			
		my $UserName = "baumbach";
		my $Password = "janesays";
			
		open (PRE_SEND_MAIL_FILE, "> $PreSendMailFile") || die "Can't open newfile $PreSendMailFile: $!\n";
			
		my $Sql = &Get_Stored_Procedure_Name;
			
		my $HtmlRoot = &Get_Html_Root;
			
		my $CgiURL = "$HtmlRoot/cgi-bin/Admin_PreSendMail.pl?user_name=$UserName&password=$Password&sql=$Sql";
		my $CgiStatus = "0";
		my $request = new HTTP::Request('GET', $CgiURL);
		my $response = $ua->request($request);
		if ($response->is_success) 
			{
				print PRE_SEND_MAIL_FILE $response->content;
				print "SUCCESS: URL was accessed.";
				print "URL: $CgiURL\n";
				$PreMailStatus = "1"
			}
		else 
			{
				$info = "Error: Address Not Found\n";
				print PRE_SEND_MAIL_FILE "ERROR URL: $CgiURL\n";
				print PRE_SEND_MAIL_FILE $response->error_as_HTML;
				print "ERROR URL: $CgiURL\n";
				print $response->error_as_HTML;
				$PreMailStatus = "0"
			}
		close (PRE_SEND_MAIL_FILE);
			
		# Perform some error checking on the file that was just written by the Cgi...
		if (!open(PRE_SEND_MAIL_FILE, "$PreSendMailFile")) 
			{
				$info->insert("end", "ERROR: Could not open $PreSendMailFile\n to perform validation checks."); 
				return "0";
			}
			
		if($PreMailStatus eq "1")
			{
				my $PreMailStatus = "0";
				while (<PRE_SEND_MAIL_FILE>) 
					{ 
						if($_ =~ m/<!-- total_found = \((.*)\) -->/)
							{
								$TotalMailToSend = $1;
							}
						elsif($_ =~ m/returned_over_found 1/)
							{
								$PreMailStatus = "1";
								last;
							}
						else
							{
								$PreMailStatus = "0";
							} 
					}
				if($PreMailStatus eq "1")
					{
						$info = "Success: Pre-SendMails Completed\nThere are $TotalMailToSend Mails Queued (see: $PreSendMailFile)\n";
						$send_test_b->configure(-state => 'normal');
						return "1";
					}
				else
					{
						$info = "Error: Validity Check On $PreSendMailFile Failed";
						$send_test_b->configure(-state => 'normal');
						return "0";# ***** should return 0 but I changed it for a fast fix *****
					}
				close (PRE_SEND_MAIL_FILE);
			}
		else
			{
				$info = "Error: Contacting $CgiURL.\n Check $PreSendMailFile for details";
				return "0";
			}
			
	}# END Pre_Send_Mail


# Send_Mass_Mail checks to see what the filename is and loads it if possible
sub Send_Mass_Mail 
	{
		my ($TestOrMass) = @_;
		print "TestOrMass = $TestOrMass\n";
		$info = "Loading file '$PreSendMailFile'...";
			
		if (!open(PRE_SEND_MAIL_FILE, "$PreSendMailFile")) 
			{
				$subject_e->insert("end", "ERROR: Could not open $PreSendMailFile\n"); 
				return; 
			}
		my $RecoveryFile = &Get_Unique_File_Name;		
		if (!open(RECOVERY_FILE, "> $RecoveryFile")) 
			{
				$info = "ERROR: Could not open $RecoveryFile\n"; 
				return; 
			}
			
		print RECOVERY_FILE "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
		print RECOVERY_FILE "<HTML>\n";
		print RECOVERY_FILE "  <HEAD>\n";
		print RECOVERY_FILE "    <TITLE>\n";
		print RECOVERY_FILE "      	Admin_SendMail.cgi time out recovery file\n";
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
		print RECOVERY_FILE "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>Results from sending multiple unique \"To:\" messages</STRONG></FONT>\n";
		print RECOVERY_FILE "                  <BR>&nbsp;<BR>\n";
		print RECOVERY_FILE "              </TD>\n";
		print RECOVERY_FILE "            </TR>\n";
			
		my $Count = 1;
		if($TestOrMass eq "Test_Mail")
			{
				$Count = -1; 
			}
			
		my $WhichConnections = "";
		my $ConnectionsEmail = "";
		my $HtmlRoot 		 = "";
			
		my $BlatExe  = "";
		my $BlatSmtp = "";
		my $BlatLog  = "";
			
		my $UserName      = "";
		my $Password      = "";
		my $Sex			  = "";
		my $Email      	  = "";
		my $FirstName     = "";
		my $LastName      = "";
		my $StreetAddress = "";
		my $City	      = "";
		my $State	      = "";
		my $Country	      = "";
		my $Zip			  = "";
		my $Questionable  = "";
		my $CreationDate  = "";
		my $LastLogin	  = "";
			
			
		while (<PRE_SEND_MAIL_FILE>) 
			{ 
				my $Subject = "";
				my $Message = "";
					
				if($Count == 0)
					{
						last;
					}
				elsif ($_ =~ m%^Local Paramaters%)
					{
						#       WhichConnections,Email, Admin/cgi-bin 
						m%Local Paramaters <!-- (.*), (.*), (.*) -->%;
						$WhichConnections = $1;
						$ConnectionsEmail = $2;
						$HtmlRoot		  = $3;
					}
				elsif ($_ =~ m%^Blat Paramaters%)
					{
						#            			Exe, Smtp, Log 
						m%Blat Paramaters <!-- (.*), (.*), (.*) -->%;
						$BlatExe  = $1;
						$BlatSmtp = $2;
						$BlatLog  = $3;
                		if($wc_value eq "Persian" and $dtl_value eq "Dev")
                			{
                				$BlatSmtp = "10.10.10.19";
                			}
					}
				elsif ($_ =~ m%^\(%)
					{
						#          UN,   PW,   Em,   Sx,   LN,   SA,   Ct,   St,   Ct,   Zp,   Qu,   Cd,  LL 
						m%^\(.*\)<!-- (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*) -->%;
						$UserName 	   = $1;
						$Password 	   = $2;
						$Email 	  	   = $3;
						$Sex 	  	   = $4;
						$LastName 	   = $5;
						$StreetAddress = $6;
						$City 		   = $7;
						$State 		   = $8;
						$Country 	   = $9;
						$Zip 		   = $10;
						$Questionable  = $11;
						$CreationDate  = $12;
						$LastLogin 	   = $13;
							
						$Subject = $subject_e->get;
						$Message = $message_t->get("1.0", "end");
							
						if($Sex eq "Male")
							{
								$Subject =~ s/replace_last_name/Mr. $LastName/g;
							}
						else
							{
								$Subject =~ s/replace_last_name/Ms. $LastName/g;
							}
							
						$Subject =~ s/replace_user_name/$UserName/g;
						$Subject =~ s/replace_which_connections/$WhichConnections/g;
							
						$Message =~ s/replace_user_name/$UserName/g;
						$Message =~ s/replace_password/$Password/g;
						$Message =~ s/replace_which_connections/$WhichConnections/g;
						$Message =~ s/replace_admin_email/$ConnectionsEmail/g;
						$Message =~ s/replace_html_root/$HtmlRoot/g;
							
						if ($ieb_value =~ m/Internal/)
							{
        						if($TestOrMass eq "Test_Mail")
        							{
        								$UserName = "Administrator"; 
        							}
								my $return_value = &Send_Internal_Mail($UserName, "Administrator", $Subject, $Message);
								if($return_value < 1)
									{
										print RECOVERY_FILE "<TR><TD><FONT color=\"red\">Error! $DatabaseFunctions::DatabaseError</FONT> Internal Mail ($Count) Failed</TD></TR>\n";
										if($TestOrMass eq "Test_Mail")
											{
												$info = "Error sending test email internally to $Email.\n View file $RecoveryFile for details.";
											}
									}
								else
									{
										print RECOVERY_FILE "<TR><TD>Internal Mail ($Count) sent</TD></TR>\n";
										if($TestOrMass eq "Mass_Mail")
											{
												print "Mail #$Count sent internally to $UserName\n"; 
											}
										else
											{
												$send_mail_b->configure(-state => 'normal');
												$info = "Sent test email internally to $UserName.\n View file $RecoveryFile for details.";
											}
									}
									
							}
						if ($ieb_value =~ m/External/)
							{
        						if($TestOrMass eq "Test_Mail")
        							{
        								$Email = "jatlast\@hotmail.com"; 
        							}
								# Slow the mailing process down so the smtp server can handle the traffic...
#								sleep(5); # Sleep for 5 seconds
								my $return_value = &Send_Individual_Blat_Mail($BlatExe, $BlatSmtp, $BlatLog, $ConnectionsEmail, $Email, "", $Subject, $Message);
								if($return_value < 1)
									{
										print RECOVERY_FILE "<TR><TD><FONT color=\"red\">Error! $DatabaseFunctions::DatabaseError</FONT> Resend Mail ($Count): <A href=\"javascript:newWindowGeneric('$HtmlRoot/admin/cgi-bin/Admin_GenSendMail.cgi?sent_from=$ConnectionsEmail&amp;sent_to=$Email&amp;sent_bcc=&amp;subject=$Subject&amp;message_text=$Message')\">$Email</A></TD></TR>\n";
										if($TestOrMass eq "Test_Mail")
											{
												$info = "Error sending test email to $Email.\n View file $RecoveryFile for details.";
											}
									}
								else
									{
										print RECOVERY_FILE "<TR><TD>View/Resend Mail ($Count): <A href=\"javascript:newWindowGeneric('$HtmlRoot/admin/cgi-bin/Admin_GenSendMail.cgi?sent_from=$ConnectionsEmail&amp;sent_to=$Email&amp;sent_bcc=&amp;subject=$Subject&amp;message_text=$Message')\">$Email</A></TD></TR>\n";
										if($TestOrMass eq "Mass_Mail")
											{
												print "Mail #$Count sent to $Email\n"; 
											}
										else
											{
												$send_mail_b->configure(-state => 'normal');
												$info = "Sent test email to $Email.\n View file $RecoveryFile for details.";
											}
									}
							}
							
						$Count++;
					}
				else
					{
						next;
					}
			}
		close (PRE_SEND_MAIL_FILE);
			
		print RECOVERY_FILE "                    <!-- submit -->\n";
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
			
		close(RECOVERY_FILE);
		$open_recovery_b->configure(-state => 'normal');
		
	} # END Send_Mass_Mail


sub Send_Individual_Blat_Mail
	{
		my($BlatPath, $MailServer, $BlatLogFilePath, $SentFrom, $SentTo, $BccFile, $Subject, $MessageText, %Map) = @_;
			
		my $TempFile		= "";
		my $TempFilePath 	= "C://Temp";
			
		(my $return_value, my $output)= &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $SentFrom, $SentTo, $BccFile, $Subject, $TempFile, $MessageText, $TempFilePath, $BlatLogFilePath, $DebugMailSendFunctions);
		if($return_value < 1)
			{
				return 1;
			}
		else
			{
				return -1;
			}
	}# END Send_Individual_Blat_Mail
	
# Get_Default_File_Name determins the name of the file based on the 
# selected value of the "To:" field (stored in $to_value)...
sub Get_Default_File_Name 
	{
		my $FileToOpen = "";
		if($to_value eq "All Users")
			{
				$FileToOpen = "DefaultMailMessages/AllUsers.msg";
			}
		elsif($to_value eq "Users Older Than 3 Months")
			{
				$FileToOpen = "DefaultMailMessages/3MonthsOld.msg";
			}
		elsif($to_value eq "Users With Duplicate Profiles")
			{
				$FileToOpen = "DefaultMailMessages/DuplicateUsers.msg";
			}
		elsif($to_value eq "Users With Unread Mail")
			{
				$FileToOpen = "DefaultMailMessages/UnreadMail.msg";
			}
		elsif($to_value eq "Users Who Have Not Logged In For 1 Month")
			{
				$FileToOpen = "DefaultMailMessages/InactiveUsers.msg";
			}
		elsif($to_value eq "Users Outside The USA")
			{
				$FileToOpen = "DefaultMailMessages/UsersOutsideUSA.msg";
			}
		else
			{
				$FileToOpen = "File Not Found";
			}
		return $FileToOpen;
	}# END Get_Default_File_Name

# Get_Stored_Procedure_Name determins the name of the stored procedure based on the 
# selected value of the "To:" field (stored in $to_value)...
sub Get_Stored_Procedure_Name 
	{
		my $Sql = "";
		if($to_value eq "All Users")
			{
				$Sql = "massMail_GetAllUsers";
			}
		elsif($to_value eq "Users Older Than 3 Months")
			{
				$Sql = "";
			}
		elsif($to_value eq "Users With Duplicate Profiles")
			{
				$Sql = "massMail_FindDuplicates";
			}
		elsif($to_value eq "Users With Unread Mail")
			{
				$Sql = "massMail_GetUsersWithUnreadMail";
			}
		elsif($to_value eq "Users Who Have Not Logged In For 1 Month")
			{
				$Sql = "";
			}
		elsif($to_value eq "Users Outside The USA")
			{
				$Sql = "massMail_GetUsersOutsideUSA";
			}
		else
			{
				$Sql = "Sql Not Found";
			}
		return $Sql;
	}# END Get_Stored_Procedure_Name

# Get_Html_Root determins the Html Root based on the selected values of 
# the "Which Connections" field (stored in $wc_value) 
# and the Dev/Test/Live fields (stored in $dtl_value)...
sub Get_Html_Root 
	{
		my $HtmlRoot = "";
		if($wc_value eq "Persian")
			{
				if($dtl_value eq "Dev")
					{
						$HtmlRoot = "http://10.10.10.19:1900";
					}
				elsif($dtl_value eq "Test")
					{
						$HtmlRoot = "Persian has no Test";
					}
				elsif($dtl_value eq "Live")
					{
						$HtmlRoot = "http://www.persianconnections.com";
					}
			}
		elsif($wc_value eq "Israeli")
			{
				if($dtl_value eq "Dev")
					{
						$HtmlRoot = "Israeli has no Dev";
					}
				elsif($dtl_value eq "Test")
					{
						$HtmlRoot = "Israeli has no Test";
					}
				elsif($dtl_value eq "Live")
					{
						$HtmlRoot = "http://www.isralionnections.com";
					}
			}
		elsif($wc_value eq "Personals")
			{
				if($dtl_value eq "Dev")
					{
						$HtmlRoot = "Personals has no Dev";
					}
				elsif($dtl_value eq "Test")
					{
						$HtmlRoot = "Personals has no Test";
					}
				elsif($dtl_value eq "Live")
					{
						$HtmlRoot = "http://www.personalsconnections.com";
					}
			}
		elsif($wc_value eq "Test")
			{
				if($dtl_value eq "Dev")
					{
						$HtmlRoot = "Test has no Dev";
					}
				elsif($dtl_value eq "Test")
					{
						$HtmlRoot = "http://216.205.68.45";
					}
				elsif($dtl_value eq "Live")
					{
						$HtmlRoot = "Test has no Live";
					}
			}
		else
			{
				$HtmlRoot = "Html Root Not Found";
			}
		return $HtmlRoot;
	}# END Get_Html_Root

# Get_Unique_File_Name determins the Html Root based on the selected values of 
# the "Which Connections" field (stored in $wc_value) 
# and the Dev/Test/Live fields (stored in $dtl_value)...
sub Get_Unique_File_Name 
	{
		# Parse the current date...
		(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
		# use parsed date to create unique file name for mass mail recovery file...
		# 	  		 	 	 			   	WhichConnections   Dev/Test/live	   	  Stored Procedure Name 
		$UniqueFileName = "RecoveryFiles/" . $wc_value . 	 $dtl_value . "_" . &Get_Stored_Procedure_Name . "_" . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . ".html";
		return $UniqueFileName;
	}# END Get_Unique_File_Name

# Open_Recovery_File opens the current recovery file. 
# (stored in $UniqueFileName)...
sub Open_Recovery_File 
	{
		my $ProgramToUse = "C:\\PROGRA~1\\INTERN~1\\iexplore.exe";
		my $RecoveryDir = "";
		if($wc_value eq "Persian" and $dtl_value eq "Dev")
			{
				$RecoveryDir = "D:\\MyData\\Personal\\Projects\\Connections\\Connections_Admin\\MassMail\\";
			}
		else
			{
				$RecoveryDir = "D:\\wwwroot\\Connections_Admin\\MassMail\\";
			}
		
		my $FileToOpen = $UniqueFileName;
		my $SystemCall = $ProgramToUse . " " . $RecoveryDir . $FileToOpen;  
			
		$info = "Trying to use $ProgramToUse \n To open $UniqueFileName";
		#		print "System Call = ($SystemCall)\n";		
		`$SystemCall`;		
	}# END Get_Unique_File_Name

sub Send_Internal_Mail
	{
		my($SentTo, $SentFrom, $Subject, $MessageText) = @_;

		my $DbUser  	= "";
		my $DbPassword	= "";
		my $DbName		= "";
			
		if($dtl_value eq "Dev")
			{
				$DbUser  	= "Connections_Dev";
				$DbPassword	= "citrix";
				$DbName		= "SMITHERS";
			}
		elsif($dtl_value eq "Test")
			{
				$DbUser  	= "Connections_Test";
				$DbPassword	= "citrix";
				$DbName		= "DHP0170";
			}
		elsif($dtl_value eq "Live")
			{
        		if($wc_value eq "Persian")
        			{
        				$DbUser  	= "Persian";
        				$DbPassword	= "citrix";
        				$DbName		= "DHP0170";
        			}
        		elsif($wc_value eq "Israeli")
        			{
        				$DbUser  	= "Israeli";
        				$DbPassword	= "citrix";
        				$DbName		= "DHP0170";
        			}
        		elsif($wc_value eq "Personals")
        			{
        				$DbUser  	= "Personals";
        				$DbPassword	= "citrix";
        				$DbName		= "DHP0170";
					}
        		elsif($wc_value eq "Test")
        			{
        				$DbUser  	= "Connections_Test";
        				$DbPassword	= "citrix";
        				$DbName		= "DHP0170";
					}
			}
		else # This should never happen...
			{
				$DbUser  	= "ERROR";
				$DbPassword	= "ERROR";
				$DbName		= "ERROR";
			}

		$MessageText =~ s/\n/<BR>/g;

		my $SqlStatement = "mailSend \"\", \"$SentTo\", \"$SentFrom\", \"$Subject\", \"$MessageText\", \"\", \"\", \"\", \"\"";
		my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($DbUser, $DbPassword, $DbName, '$ProgramName', $SqlStatement, $DebugDatabaseFunctions);
		print RECOVERY_FILE "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
		if($return_value eq "1")
			{
				# Mail was sent internally...
				return 1;
			}
		else
			{
				# Mail was NOT sent internally...
				print RECOVERY_FILE "DbUser = $DbUser" if $DebugThisAp eq "1";
				print RECOVERY_FILE "DbPassword = $DbUser" if $DebugThisAp eq "1";
				print RECOVERY_FILE "DbName = $DbUser" if $DebugThisAp eq "1";
				return -1;
			}
	}# END Send_Internal_Mail
