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
require "SendMailFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";
my $DebugMailSendFunctions = "0";

my $ProgramName = "SendMail.cgi";

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

# declare global variables...
my $sent_from 	 = "";
my $sent_to 	 = "";
my $sent_bcc 	 = "";
my $subject		 = "";
my $message_text = "";

if(CGI::param('sent_from'))   {$sent_from 	 = CGI::param('sent_from');}
if(CGI::param('sent_to'))	  {$sent_to 	 = CGI::param('sent_to');}
if(CGI::param('subject'))	  {$subject    	 = CGI::param('subject');}
if(CGI::param('message_text')){$message_text = CGI::param('message_text');}

my $cookie_name    = &CgiFunctions::Get_Cookie_Value("cookie_name", $DebugCgiFunctions);
my $cookie_password =  &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

# Die if the user is not logged in...
&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map) if($cookie_password eq "");

# Escape special characters...
if($subject =~ m/"/)
	{
		$subject =~ s/"/""/g;
	}
#print "<!-- pre removal message_text ($message_text) -->\n";
if($message_text =~ m/"/)
	{
		$message_text =~ s/"/""/g;
		#print "<!-- post removal message_text ($message_text) -->\n";
	}


if($sent_from eq "")
	{
		$sent_from = $cookie_name;
	}


my $output;

# Build email to send to the person receiving the new PC Mail...
my $BlatPath 		= "$Map{'BLAT_PATH'}/EXE/blat.exe";
my $MailServer 		= "$Map{'SMTP_HOST'}";
my $NotifySender   	= $Map{'EMAIL'};
#my $NotifyReceiver 	= "baumbach\@bellatlantic.net";
my $NotifySubject	= "Hello $sent_to, you have new $Map{'WHICH_CONNECTIONS'} Mail.";
my $TempFile		= "";
my $NotifyMessage 	= "\"$sent_from\" sent you mail.\n\nPlease log into your $Map{'ROOT'} account to read your new message.\n\nView \"$sent_from\'s\" profile: $Map{'CGIBIN'}/SingleProfile.exe?user_name=$sent_from";
my $TempFilePath 	= "C:\\Temp";
my $BlatLogFilePath = "$Map{'BLAT_PATH'}/EXE/blat.log";

# Build an email message to send to the receiver of the message
# when that person does not have an email address in the login_info table
my $NoEmail_sender 		= $Map{'WHICH_CONNECTIONS'};
my $NoEmail_subject		= "$Map{'WHICH_CONNECTIONS'}.com FYI:";
my $NoEmail_message_text= "$Map{'WHICH_CONNECTIONS'}.com was unable to notify you that $sent_from sent you a message because you have not given us your email address.\nPlease go to Member Home ($Map{'CGIBIN'}/GenHome.exe) then go to Update Login Info ($Map{'CGIBIN'}/UpdateLogin.exe) and add your email address";

my $SqlStatement = "mailSend \"\", \"$sent_to\", \"$sent_from\", \"$subject\", \"$message_text\", \"\", \"\", \"\", \"\"";
my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'SendMail.cgi', $SqlStatement, $DebugDatabaseFunctions);
print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
if($return_value eq "1")
	{
		# get receiver's email outside address...
		$return_value = &DatabaseFunctions::Get_Email_By_UserName($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'SendMail.cgi', $sent_to, $DebugDatabaseFunctions);
		print "\n<!-- Get_Email_By_UserName return_value = $return_value-->\n" if $DebugThisAp eq "1";
		if($return_value eq "-1")
			{
				&UtilityFunctions::Print_Framed_Error("Error retreiving \"$sent_from\'s\" email address.\n<!-- return_value = $return_value-->\n", $DebugUtilityFunctions, %Map);
			}
		elsif($return_value eq "-2")
			{
				print "\n<!-- Attempting to notify $sent_to that they do not have an email address in the database. -->\n" if $DebugThisAp eq "1";
				$SqlStatement = "mailSend \"\", \"$sent_to\", \"$NoEmail_sender\", \"$NoEmail_subject\", \"$NoEmail_message_text\", \"\", \"\", \"\", \"\"";
				$return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'SendMail.cgi', $SqlStatement, $DebugDatabaseFunctions);
				print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
				if($return_value eq "1")
					{
						print "\n<!-- SUCCESS:  $sent_to was notified by PC Mail that they need to add an email address. -->\n" if $DebugThisAp eq "1";
					}
				else
					{
						print "\n<!-- ERROR:  $sent_to was NOT notified by PC Mail that they need to add an email address because an error occured.-->\n";
					}
#			Only notify the user if internal mail fails...					
#			&UtilityFunctions::Print_HTML("SUCCESS: your mail has been sent to \"$sent_to\"", $DebugUtilityFunctions, %Map);
			}
		else
			{
				($return_value,$output)= &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $NotifySender, $return_value, "", $NotifySubject, $TempFile, $NotifyMessage, $TempFilePath, $BlatLogFilePath, $DebugMailSendFunctions);
				if($return_value < 1)
					{
						print "\n<!-- Mail_Blat Success return_value = $return_value \n output = $output\n-->\n" if $DebugThisAp eq "1";
						#&UtilityFunctions::Print_HTML("SUCCESS: your mail has been sent to \"$sent_to\"", $DebugUtilityFunctions, %Map);
					}
				else
					{
						print "\n<!-- Mail_Blat Error return_value = $return_value \n output = $output\n-->\n" if $DebugThisAp eq "1";
						#&UtilityFunctions::Print_Framed_Error("Error sending mail to \"$sent_to\".<!--\nreturn_value = $return_value \noutput value = $output\n-->\n", $DebugUtilityFunctions, %Map);
					}
			}
	 	# Mail was sent internally...
		&UtilityFunctions::Print_HTML("SUCCESS: your mail has been sent to \"$sent_to\"", $DebugUtilityFunctions, %Map);
	}
else
	{
		if($DatabaseFunctions::DatabaseError eq "1003" or $DatabaseFunctions::DatabaseError eq "1008")
			{
				&UtilityFunctions::Print_Framed_Error("\n<SCRIPT type=\"text/javascript\" language=\"javascript\">\n<!--\n window.location = \"../PaymentOptions.html\"\n//-->\n</SCRIPT>\nERROR: You must be a premium member to send mail.<BR><A href=\"GenAuthorizeNetForm.cgi\"><FONT color=\"RED\">Become A Premium Member</FONT></A>\n", $DebugUtilityFunctions, %Map);
			}
		elsif($DatabaseFunctions::DatabaseError eq "1026")
			{
				&UtilityFunctions::Print_Framed_Error("\n<SCRIPT type=\"text/javascript\" language=\"javascript\">\n<!--\n window.location = \"GenPicUpload.exe\"\n//-->\n</SCRIPT>\nERROR: You must upload a qualified photo to send mail.<BR><A href=\"GenAuthorizeNetForm.cgi\"><FONT color=\"RED\">Become A Premium Member</FONT></A>\n", $DebugUtilityFunctions, %Map);
			}
		else
			{
				&UtilityFunctions::Print_Framed_Error("ERROR: the system is currently unable to send a message from user \"$sent_from\".<BR>Make sure you are logged in and try again.\n", $DebugUtilityFunctions, %Map);
			}
	}

#End HTML...
print "</HTML>\n";
exit 0;
