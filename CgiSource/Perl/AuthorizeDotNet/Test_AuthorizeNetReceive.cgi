#!/usr/local/bin/perl #-w
use CGI qw/:standard/;
#use CGI qw/:all/;
#use strict;

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

my $x_response_code			= "empty";
my $x_response_subcode		= "empty";
my $x_response_reason_code	= "empty";
my $x_response_reason_text	= "empty";
my $x_auth_code				= "empty";
my $x_avs_code				= "empty";
my $x_trans_id				= "empty";
my $x_invoice_num			= "empty";
my $x_description			= "empty";
my $x_amount				= "empty";
my $x_method				= "empty";
my $x_type					= "empty";
my $x_cust_id				= "empty";
my $x_first_name 			= "empty";
my $x_last_name  			= "empty";
my $x_company  				= "empty";
my $x_address  				= "empty";
my $x_city  				= "empty";
my $x_state  				= "empty";
my $x_zip  					= "empty";
my $x_country  				= "empty";
my $x_phone  				= "empty";
my $x_fax  					= "empty";
my $x_email  				= "empty";
my $x_tax  	   		 		= "empty";
my $x_md5_hash  	 		= "empty";

if(CGI::param('x_response_code'))   {$x_response_code= CGI::param('x_response_code');}
if(CGI::param('x_response_subcode'))   {$x_response_code= CGI::param('x_response_subcode');}
if(CGI::param('x_response_reason_code'))   {$x_response_reason_code= CGI::param('x_response_reason_code');}
if(CGI::param('x_response_reason_text'))   {$x_response_reason_text= CGI::param('x_response_reason_text');}
if(CGI::param('x_auth_code'))   {$x_auth_code = CGI::param('x_auth_code');}
if(CGI::param('x_avs_code'))   {$x_avs_code = CGI::param('x_avs_code');}
if(CGI::param('x_trans_id'))   {$x_trans_id = CGI::param('x_trans_id');}
if(CGI::param('x_invoice_num'))   {$x_invoice_num = CGI::param('x_invoice_num');}
if(CGI::param('x_description'))   {$x_description = CGI::param('x_description');}
if(CGI::param('x_amount'))   {$x_amount = CGI::param('x_amount');}
if(CGI::param('x_method'))   {$x_method = CGI::param('x_method');}
if(CGI::param('x_type'))   {$x_type = CGI::param('x_type');}
if(CGI::param('x_cust_id'))   {$x_cust_id = CGI::param('x_cust_id');}
if(CGI::param('x_first_name'))   {$x_first_name = CGI::param('x_first_name');}
if(CGI::param('x_last_name'))   {$x_last_name  = CGI::param('x_last_name');}
if(CGI::param('x_company'))   {$x_company  = CGI::param('x_company');}
if(CGI::param('x_address'))   {$x_address  = CGI::param('x_address');}
if(CGI::param('x_city'))   {$x_city  = CGI::param('x_city');}
if(CGI::param('x_state'))   {$x_state  = CGI::param('x_state');}
if(CGI::param('x_zip'))   {$x_zip  = CGI::param('x_zip');}
if(CGI::param('x_country'))   {$x_country  = CGI::param('x_country');}
if(CGI::param('x_phone'))   {$x_phone  = CGI::param('x_phone');}
if(CGI::param('x_fax'))   {$x_fax  = CGI::param('x_fax');}
if(CGI::param('x_email'))   {$x_email  = CGI::param('x_email');}
if(CGI::param('x_tax'))   {$x_tax  = CGI::param('x_tax');}
if(CGI::param('x_md5_hash'))   {$x_md5_hash  = CGI::param('x_md5_hash');}

print "x_response_code= $x_response_code\n";
print "x_response_subcode= $x_response_subcode\n";
print "x_response_reason_code= $x_response_reason_code\n";
print "x_response_reason_text= $x_response_reason_text\n";
print "x_auth_code = $x_auth_code\n";
print "x_avs_code = $x_avs_code\n";
print "x_trans_id = $x_trans_id\n";
print "x_invoice_num = $x_invoice_num\n";
print "x_description = $x_description\n";
print "x_method = $x_method\n";
print "x_type = $x_type\n";
print "x_cust_id = $x_cust_id\n";
print "x_first_name = $x_first_name\n";
print "x_last_name = $x_last_name\n";
print "x_company = $x_company \n";
print "x_address = $x_address \n";
print "x_city = $x_city \n";
print "x_state = $x_state \n";
print "x_zip = $x_zip \n";
print "x_country = $x_country \n";
print "x_phone = $x_phone \n";
print "x_fax = $x_fax \n";
print "x_email = $x_email \n";
print "x_tax = $x_tax \n";
print "x_md5_hash = $x_md5_hash \n";

#$query = CGI::new();
#print CGI::$query->dump();
#my $buffer_size = $ENV{'CONTENT_LENGTH'};
#print "size = $buffer_size.\n";
#my $buffer;
#print "before read.\n";
#read($STDIN, $buffer, $buffer_size);
#print "after read\n";
#print "Read BUFFER $buffer\n";

print "Read CONTENT_LENGTH ($ENV{'CONTENT_LENGTH'})\n";
print "Read QUERY_STRING ($ENV{'QUERY_STRING'})\n";
print "Read REQUEST_METHOD ($ENV{'REQUEST_METHOD'})\n";

# declare global variables...
#End HTML...
print "</HTML>\n";
exit 0;

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
my $NotifySender   	= "Admin\@" . $Map{'WHICH_CONNECTIONS'} . ".com";
#my $NotifyReceiver 	= "baumbach\@bellatlantic.net";
my $NotifySubject	= "Hello $sent_to, you have new PersianConnections Mail.";
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
						print "\n<!-- SUCCESS:  $sent_to was notified by PC Mail that they need to add an email address. -->\n";
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
		&UtilityFunctions::Print_Framed_Error("ERROR: \"$cookie_name\" may need to re-login.<BR>(Note: You must be a premium member to send mail.)<BR>\n", $DebugUtilityFunctions, %Map);
	}

