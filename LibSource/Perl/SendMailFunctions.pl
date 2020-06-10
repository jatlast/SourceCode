#!/usr/local/bin/perl -w
#    SendMailFunctions.pl
#    created on 2-6-2001
#    Author: Jason Baumbach

#        This file contains subroutines for sending mail over the internet
#        Each subroutine can take 4 arguments and executes the passed in URL
#		 If the second argument = "1" debugging is "ON"

#        Example Code:
#        $ReturnValue = &Call_CGI_GET ("http://www.SomeAddress.com/cgi-bin/SomeScript.cgi?user_name=\'Joe\'\&password=\'pwd\'", "1");
#		 Returns the status of $response->is_success;

#=====================================================================
#
#            Sending mail with Blat (Win 95/NT)
#
# Blat home page: http://gepasi.dbs.aber.ac.uk/softw/Blat.html
#
# Can send file or text or file+text (if both $file and $body ne "")
#
# Call as:
# ($errcode,$output)=
# &mail_blat($blat_prog, $server, $from, $to,
# $subject, $file, $body, $temp_files_path);
#
# Returns error-code(correct in Blat 1.5 only) and Blat-output
#
# Author : Mike Blazer      blazer@mail.nevalink.ru
# Version: 1.4              Last Modified: Jan 7, 1998
# Tested : on ActiveWare's Perl port, build 110; Win'95, Win NT+IIS 3.0

package SendMailFunctions;


sub Mail_Blat 
{
	local ($blat_prog, $SMTP_host, $from, $to, $bcc, $subj, $file, $body, $temp_files_path, $log_file_path, $Debug) = @_;
			
	local ($temp_file, $out, $filebody);
			
	if (!$body)
	{
		return 4,"Both body/file sources are empty in ". __FILE__." at line ".__LINE__."\n" if !$file;
				
		$temp_file=$file;
	}
	else 
	{  
					
		# create temp-file's name
		BEGIN{ srand $$.time }
		do {$temp_file  = "$temp_files_path/". int (rand(1000000)).".file"} until (!-e $temp_file);
			
		# file+body request
		if ($file) 
			{
				open (IN,"$file") ||
				return 1,"Can not read file $file in " .
				__FILE__." at line ".__LINE__."\n";
				$filebody = join "",<IN>;
				close IN;
			}
		# write message's body to temp-file
		open (TEMP, ">$temp_file") || return 2,"Can not write temp-file $file in " .__FILE__." at line ".__LINE__."\n";
		print TEMP "$filebody\n$body";
		close TEMP;
	} # end of else
				
	if ($Debug eq "1")
	{## Note: Removed "-r" 12/16/2001
		if($bcc ne "")
			{
				#Use BCC format of Blat...
				# Print debug output...
				print "\n<!-- Debug Blat: ($blat_prog $temp_file -s \"$subj\" -f $from -t $to -bcc $bcc -server $SMTP_host -ti 10 -log $log_file_path) -->\n";
				# Use with Regular cgi scripts...
				$out=`$blat_prog $temp_file -s \"$subj\" -f $from -t $to -bcc $bcc -debug -server $SMTP_host -ti 10 -log $log_file_path`;
			}
		else
			{
				#Use non-BCC format of Blat...
				# Print debug output... 
				print "\n<!-- Debug Blat: ($blat_prog $temp_file -s \"$subj\" -f $from -t $to -server $SMTP_host -ti 10 -log $log_file_path) -->\n";
				# Use with Regular cgi scripts...
				$out=`$blat_prog $temp_file -s \"$subj\" -f $from -t $to -debug -server $SMTP_host -ti 10 -log $log_file_path`;
			}		
	}
	else
	{
		if($bcc ne "")
			{
				#Use BCC format of Blat...
				$out=`$blat_prog $temp_file -s \"$subj\" -f $from -t $to -bcc $bcc -server $SMTP_host -ti 10 -log $log_file_path`;
			}
		else
			{
			 	#Use non-BCC format of Blat...
				$out=`$blat_prog $temp_file -s \"$subj\" -f $from -t $to -server $SMTP_host -ti 10 -log $log_file_path`;
			}		
	}
	# remove temp-file
	unlink $temp_file if ($temp_file ne $file);
								
	# workaround syntax error that returns 0
	$? = 3 if(!$? && $out=~/\nsyntax:\n/);
		
	# return error-code and Blat-output
	return $?,$out;
} #END Sub


sub Mail_Blat_Extended
{
	my $blat_prog		= shift; # absolute path to the blat.exe (Ex: D:\Required\EXE\blat.exe)
	my $SMTP_host		= shift; # -server <addr>  : Specify SMTP server to be used. (optionally, addr:port)
	my $from			= shift; # -f <sender>     : overrides the default sender address (must be known to server)
	my $to				= shift; # -to <recipient> : recipient list (also -t) (comma separated)
	my $bcc				= shift; # -bcc <recipient>: blind carbon copy recipient list (also -bcc) (comma separated)
	my $subject			= shift; # -subject <subj> : subject line (also -s)
	my $file			= shift; # <filename>      : file with the message body ('-' for console input, end with ^Z)
	my $body			= shift; # -body <text>    : Message body
	my $Send_As_HTM		= shift; # -html           : Send an HTML message (Content-Type=text/html)
	my $attached_text	= shift; # -attacht <file> : attach text file to message (may be repeated)
	my $attached_binary	= shift; # -attach <file>  : attach binary file to message (may be repeated)
	my $temp_files_path	= shift; # Used to create a temp file...
	my $log_file_path	= shift; # -log <filename> : Log everything but usage to <filname> 
	my $Debug			= shift; # -debug          : Echoes server communications to screen (disables '-q').
	# Logging is always on :       -log <filename> : Log everything but usage to <filname>

	local ($temp_file, $out, $filebody);
	
	################ Unsupported Blat Functionality ...
	# 
	#  -tf <recipient> : recipient list filename
	#  -i <addr>       : a 'From:' address, not necessarily known to the SMTP server.  (NOTE:  I currently use the -f option instead of -i) Jason Baumbach 11/18/2002
	#  -cc <recipient> : carbon copy recipient list (also -c) (comma separated)
	#  -cf <file>      : cc recipient list filename
	#  -bf <file>      : bcc recipient list filename
	#  -organization <organization>: Organization field (also -o and -org)
	#  -p <profile>   : send with SMTP server, user and port defined in <profile>.
	#  -server <addr> : Specify SMTP server to be used. (optionally, addr:port)
	#  -port <port>   : port to be used on the server, defaults to SMTP (25)
	#  -hostname <hst>: select the hostname used to send the message
	#  -mime          : MIME Quoted-Printable Content-Transfer-Encoding.
	#  -enriched      : Send an enriched text message (Content-Type=text/enriched)
	#  -uuencode      : Send (binary) file UUEncoded
	#
	#  Easily added functionality...
	#
	#  -x <X-Header: detail>: Custom 'X-' header.  eg: -x "X-INFO: Blat is Great!"
	#  -r             : Request return receipt.
	#  -d             : Request disposition notification.
	#  -q             : supresses *all* output.
	#  -noh           : prevent X-Mailer header from showing homepage of blat
	#  -noh2          : prevent X-Mailer header entirely
	#  -base64        : Send (binary) file using base64 (binary Mime)
	#  -try <n times> : how many time blat should try to send. from '1' to 'INFINITE'
	#  -u <username>  : Username for AUTH LOGIN (use with -pw)
	#  -pw <password> : Password for AUTH LOGIN (use with -u)

	if (!$$body)
	{
		return 4,"Both body/file sources are empty in ". __FILE__." at line ".__LINE__."\n" if !$$file;
		$temp_file=$$file; # looks like this line is moot...
	}
	else 
	{  
		# create temp-file's name
		BEGIN{ srand $$.time }
		do {$temp_file  = "$$temp_files_path/". int (rand(1000000)).".file"} until (!-e $temp_file);
			
		# file+body request
		if ($$file) 
			{
				open (IN,"$$file") || return 1,"Can not read file $$file in " . __FILE__." at line ".__LINE__."\n";
				$filebody = join "",<IN>;
				close IN;
			}
		# write message's body to temp-file
		open (TEMP, ">$temp_file") || return 2,"Can not write temp-file $$file in " .__FILE__." at line ".__LINE__."\n";
		print TEMP "$filebody\n$$body";
		close TEMP;
	} # end of else
				
	##### Blat functionality always used ...
	#
	#  -ti <n>        : Set timeout to 'n' seconds.
	#  
	
	my $commandline = "";
	
	if ($$blat_prog ne "")		{$commandline .= "$$blat_prog ";}		else {return 4, "Blat Program Path is empty in "        . __FILE__." at line ".__LINE__."\n";}
	if ($$file ne "")			{$commandline .= "$$file ";}			# User passed in a file to use	
	else						{$commandline .= "$temp_file ";}		# User did not pass a file in to use
	if ($$subject ne "")		{$commandline .= "-s \"$$subject\" ";}
	if ($$to ne "")				{$commandline .= "-t \"$$to\" ";}		else {return 4,"To: field is empty in "					. __FILE__." at line ".__LINE__."\n";}
	if ($$from ne "")			{$commandline .= "-f \"$$from\" ";}		else {return 4,"From: field is empty in "				. __FILE__." at line ".__LINE__."\n";}
	if ($$bcc ne "")			{$commandline .= "-bcc \"$$bcc\" ";}
	if ($$Send_As_HTM eq "Y" 
		or $$Send_As_HTM eq "1"){$commandline .= "-html ";}
	if ($$attached_text ne "")	{$commandline .= "-attacht \"$$attached_text\" ";}
	if ($$attached_binary ne ""){$commandline .= "-attach \"$$attached_binary\" ";}
	if ($$Debug ne "Y" 
		or $$Debug ne "1")		{$commandline .= "-noh2 ";}						# -noh2          : prevent X-Mailer header entirely
	if ($$Debug ne "Y" 
		or $$Debug ne "1")		{$commandline .= "-q ";}						# -q             : supresses *all* output.
	if ($$Debug eq "Y" 
		or $$Debug eq "1")		{$commandline .= "-debug ";}					# -debug         : Echoes server communications to screen (disables '-q').
	if ($$SMTP_host ne "")		{$commandline .= "-server $$SMTP_host ";}
	if (1)						{$commandline .= "-ti 10 -u sam_p -pw smtp4spam ";}# -ti <n>        : Set timeout to 'n' seconds.
	if ($$log_file_path ne "")	{$commandline .= "-log \"$$log_file_path\" ";}	
	

	print "\n\n<!-- Debug Blat: ($commandline) -->\n\n" if $$Debug eq "Y" or $$Debug eq "1";
 
	# Execute blat.exe at the command line...
	$out=`$commandline`;
	
	# remove temp-file
	unlink $temp_file if ($temp_file ne $$file);
								
	# workaround syntax error that returns 0
	$? = 3 if(!$? && $out=~/\nsyntax:\n/);
		
	# return error-code and Blat-output
	return $?,$out;
} #END Sub



sub Email_The_Verification_Code_To_User
	{
		(my $UserName, my $Password, my $EmailAddress, my $VerificationCode, my $Debug, my %Map) = @_;

		# Build email to send as status report...
		my $BlatPath 		= "$Map{'BLAT_PATH'}/EXE/blat.exe";
		my $SMTP 			= "$Map{'SMTP_HOST'}";

		my $From   			= "$Map{'EMAIL'}";
#		my $From   			= "baumbach\@optonline.net";

		my $To 				= $EmailAddress;
#		my $To 				= "jatlast\@hotmail.com";

		my $Bcc				= "";
		my $Subject			= "Your Email Verification Code For $Map{'WHICH_CONNECTIONS'}.";
		my $TempFile		= "";
		my $TempFilePath 	= "C:\\Temp";
		my $BlatLogFilePath = "$Map{'BLAT_PATH'}/EXE/blat.log";
		my $return_value	= 0;
		my $output			= "";
		my $StatusMessage	= "";

# Initialize the Email Body by escaping the carriage return so it is easier to read...
		my $Body 			= "\
----------- Email Verification Code -----------\
   Code:     $VerificationCode\
   Login ID: $UserName\
   Password: $Password\
-----------------------------------------------\
\n\
----------- How To Verify Email ---------------------------\
There are 4 different ways for you to verify your email\
address using the Email Verification Code ($VerificationCode).\
  (1) Automatic\
  (2) Cut and Paste\
  (3) Manual\
  (4) Reply\
-----------------------------------------------------------\
\n\
--------------------------- (1) ---------------------------\
------------------------ Automatic ------------------------\
-----------------------------------------------------------\
Simply click on the link below to automatically verify your\
email address...\
$Map{'CGIBIN'}/ManageEmailVerification.cgi?submit=Verify_My_Email_Address&user_name=$UserName&password=$Password&email=$To&email_verification_code=$VerificationCode\
\
If this does not work try following the steps below under\
\"Cut and Paste\"...\
-----------------------------------------------------------\
\n\n\
--------------------------- (2) ---------------------------\
---------------------- Cut and Paste ----------------------\
-----------------------------------------------------------\
  (1) Copy the above link by highlighting it then holding\
      down the Control key then the C key. (Ctrl-C)\
\
  (2) Past the link into your favorite browser's Address\
      field by holding down the Control key then\
      the V key. (Ctrl-V)\
\
  (3) Press the Enter key to automatically verify your\
      email address.\
\
If this does not work try following the steps below\
under \"Manual\"...\
-----------------------------------------------------------\
\n\n\
--------------------------- (3) ---------------------------\
-------------------------- Manual -------------------------\
-----------------------------------------------------------\
  (1) Log in to $Map{'ROOT'}/index.html which\
      automatically takes you to the Member Home page.\
\
  (2) From the Member Home page click \"Update/Verify Email\"\
      under \"Update Profile...\" which takes you to the\
      Email Verification Form.\
\
  (3) Put the Email Verification Code ($VerificationCode)\
      into the \"Verification Code\" field under Option 2.\
\
  (4) Click the Verify_My_Email_Address button.\
\
If this does not work try following the steps below\
under \"Reply\"...\
--------------------------------------------------------\
\n\n\
--------------------------- (4) ---------------------------\
-------------------------- Reply --------------------------\
-----------------------------------------------------------\
  (1) Reply to this mail making sure it contains all the\
      above text\
\
  (2) Wait for a few hours for the site administrator to\
      verify your email address\
\
  (3) Log in to $Map{'ROOT'}/index.html to see if your\
      email address has been verified.\
---------------------------------------------------------------\
\n\
Thank you,\
\
$Map{'WHICH_CONNECTIONS'}\
$Map{'EMAIL'}";

		($return_value, $output)= &SendMailFunctions::Mail_Blat($BlatPath, $SMTP, $From, $To, $Bcc, $Subject, $TempFile, $Body, $TempFilePath, $BlatLogFilePath, $Debug);
		if($return_value < 1)
			{
				print "\n<!-- Email_The_Verification_Code_To_User Success return_value = $return_value \n output = $output\n-->\n";
				return (1);
			}
		else
			{
				print "\n<!-- Email_The_Verification_Code_To_User Error return_value = $return_value \n output = $output\n-->\n";
				return (-1);
			}
	}

sub Email_The_Host_Welcome_Message_To_User
	{
		(my $DefaultAdvertiserUniqueID, my $Password, my $AdvertiserUniqueID, my $EmailAddress, my $VerificationCode, my $Debug, my %Map) = @_;

		# Build email to send as status report...
		my $BlatPath 		= "$Map{'BLAT_PATH'}/EXE/blat.exe";
		my $SMTP 			= "$Map{'SMTP_HOST'}";

		my $From   			= "$Map{'EMAIL'}";
#		my $From   			= "baumbach\@optonline.net";

		my $To 				= $EmailAddress;
#		my $To 				= "jatlast\@hotmail.com";

		my $Bcc				= "";
		my $Subject			= "Thank you for hosting with One Monkey, Inc.";
		my $TempFile		= "";
		my $TempFilePath 	= "C:\\Temp";
		my $BlatLogFilePath = "$Map{'BLAT_PATH'}/EXE/blat.log";
		my $return_value	= 0;
		my $output			= "";
		my $StatusMessage	= "";

# Initialize the Email Body by escaping the carriage return so it is easier to read...
		my $Body 			= "\
Welcome to One Monkey, Inc.\
\
Thank you for choosing to host text ads using One Monkey, Inc.\
Our goal is to make your text ad hosting a success so please read\
this entire email carefully because it provides you with very\
important information regarding your new accounts.
\
Please note that when you created a hosting account an advertiser\
account was automatically created for you.  We provied you with this\
account so that you can create text ads (For Free), by using our\
advertiser interface, to run on your site the same way as your future\
advertisers will create their text ads.  The only difference is that\
when you use this advertising account to purchase text ads on your\
site you will not need to provide credit card information.  Dummy\
information should already be provided for you.  All you need to do\
is create all the campaigns, groups, and text ads you want and submit\
the credit card processing form with the dummy information provided.\
\
The first thing we suggest you do is verify your email address\
by using the information that was sent to\
$EmailAddress\
at the same time this mail was sent to you.  Just follow the\
directions in that mail or go to:\
$Map{'ROOT'}/index.html\
and log in, then go to:\
$Map{'CGIBIN'}/ManageEmailVerification.cgi\,
and enter the verification code listed below.\
\
--------------- Host Email Verification Code --------------\
   Code:     $VerificationCode\
   Login ID: $AdvertiserUniqueID\
   Password: $Password\
-----------------------------------------------------------\
\
\
--------------- Advertiser Email Verification Code --------\
   Code:     $VerificationCode\
   Login ID: $DefaultAdvertiserUniqueID\
   Password: $Password\
-----------------------------------------------------------\
\
After you are logged in and your email address has been\
verified you should visit the Advertising Settings link:\
$Map{'CGIBIN'}/Adv_HostCampaignSettings.cgi?menu_item=Advertising_Settings\
to provide your site specific information so when potential\
advertisers look at their current hosting options at:\
$Map{'CGIBIN'}/Adv_GenCurrentHostList.cgi\
they will see your website information as one of their\
advertising options.\
(Note: Hosts that do not fill in this information or do not\
have more than 100 page views per week will not be listed.)\
\
You will also need to allow cost-per-impression (CPM)\
and/or cost-per-click (CPC) campaigns in order to allow your\
advertisers a campaign option.  If you do not allow either\
type of advertising you will not be able to sell advertising\
on your site.\
\
Now that you have verified your email, entered your site\
spacific information, and allowed CPM and/or CPC campaigns\
you can add the code snippet to each page you would like\
your text ads to appear.  The code snippet you need to add\
can be found at:\
$Map{'CGIBIN'}/Adv_HostCodeSnippet.cgi?menu_item=View_Code_Snippet\
(Note: Search Engine Hosts and Dating Site Hosts will need\
to embed their dynamic query strings into the code snippet\
provided in order to take advantage of the dynamic delivery\
of text ads based on user\'s search options.)\
\
Now that you have added the code snippet you can adjust\
the way your text ads are delivered to you by going to:\
$Map{'CGIBIN'}/cgi-bin/Adv_HostAdFormat.cgi?menu_item=Change_Ad_Format\
and adjusting the parameters provided.\
(Note: Search Engine Hosts and Dating Site Hosts will be\
provided with extra fields that need to be adjusted to match\
their existing query string parameter names.)\
\
Once you finish all the above steps you are ready to start\
selling advertising on you sites.  From this point forward\
your advertisers will create their campaigns by using pages\
with the logo you provided but hosted by One Monkey.\
We handle the credit card payments, reporting, and text ad\
delivery.  The only thing you will be required to do is\
approve or disapprove each ad before it is added to your\
text ad rotation on your sites.  This can be done by going to:\
$Map{'CGIBIN'}/Adv_HostAdsPendingApproval.cgi?menu_item=Ads_Pending_Approval\
(Note: You will also receive mail informing you that you have\
ads pending approval.)\
\
Finally, make sure your Payment Information is correct so\
we know where to send your checks.\
$Map{'CGIBIN'}/Adv_AccountManagement.cgi?menu_item=Update_Billing_Address\
(Note: Checks are mailed monthly or delayed until you have\
revenue in excess of \$50 US Dollars.)\
\
We look forward to providing you with the most effective\
text ads available.  If you have questions or feedback you\
wish to share with us please contact $From.\
\
\
Thank you again for choosing One Monkey, Inc.
\n\
Sincerely,\
Jason Baumbach\
One Monkey Text Ads Team
$Map{'EMAIL'}";

		($return_value, $output)= &SendMailFunctions::Mail_Blat($BlatPath, $SMTP, $From, $To, $Bcc, $Subject, $TempFile, $Body, $TempFilePath, $BlatLogFilePath, $Debug);
		if($return_value < 1)
			{
				print "\n<!-- Email_The_Host_Welcome_Message_To_User Success return_value = $return_value \n output = $output\n-->\n";
				return (1);
			}
		else
			{
				print "\n<!-- Email_The_Host_Welcome_Message_To_User Error return_value = $return_value \n output = $output\n-->\n";
				return (-1);
			}
	}

sub Afl_Email_The_Publisher_Welcome_Message_To_User
	{
		(my $afl_unique_id, my $email, my $password, my $VerificationCode, my $Debug, my %Map) = @_;

		# Build email to send as status report...
		my $BlatPath 		= "$Map{'BLAT_PATH'}/EXE/blat.exe";
		my $SMTP 			= "$Map{'SMTP_HOST'}";

		my $From   			= "$Map{'EMAIL'}";
#		my $From   			= "baumbach\@optonline.net";

		my $To 				= $email;
#		my $To 				= "jatlast\@hotmail.com";

		my $Bcc				= "";
		my $Subject			= "Login Info for StrategicAffiliates.com";
		my $TempFile		= "";
		my $TempFilePath 	= "C:\\Temp";
		my $BlatLogFilePath = "$Map{'BLAT_PATH'}/EXE/blat.log";
		my $return_value	= 0;
		my $output			= "";
		my $StatusMessage	= "";

# Initialize the Email Body by escaping the carriage return so it is easier to read...
		my $Body 			= "\
Welcome to StrategicAffiliates.com\
\
Thank you for creating a new Affiliate account.\
Your account identification number is: $afl_unique_id
Your new account enables you to earn commissions through the\
placement of links and banners on your Web site or in your\
newsletter. Our goal is to help you achieve success with\
pay-for-performance marketing so please read this entire email\
carefully because it provides you with very important information\
regarding your new account.\
\
The first thing we suggest you do is verify your email address\
by using the information that was sent to\
$To\
at the same time this mail was sent to you.  Just follow the\
directions in that mail or go to:\
$Map{'ROOT'}/index.html\
and log in, then go to:\
$Map{'CGIBIN'}/ManageEmailVerification.cgi\,
and enter the verification code listed below.\
\
------------- Affiliate Email Verification Code ------------\
   Code:     $VerificationCode\
   Login ID: $To\
   Password: $password\
-----------------------------------------------------------\
\
After you are logged in and your email address has been\
verified you will need to choose which Advertisers you would\
like to work with.  To view the current list of Advertisers\
simply click the Partnerships link:\
$Map{'CGIBIN'}/Afl_GenAffiliateChoices.cgi\
Each Advertiser offers potential Affiliates (You) different\
Payment Programs.  Some even offer incentives.  You will\
be able to get a good idea of what each Advertiser offers \
simply by viewing this page and paying close attention to the\
\"Sale | Lead\"\ column.  For detailed information on individual\
Advertisers simply click the logo of that advertiser in the\
\"Advertiser\" column.\
Please Note:  Even though you can choose to work with as many\
different Advertisers as you want we suggest you limit your\
partnerships to only those Advertisers who most closely offer\
services you think your users will find most beneficial.  This\
will improve your commissions and make your pay-for-performance\
marketing more successful and more manageable.\

Now that you have picked out which Advertiser(s) you would like\
to work with you are ready to choose which advertisements you\
would like to display on your site or within your newsletter.\
To view the list of all the advertisement options offered by\
the Advertisers you have active relationships with simply click\
the \"Get Banner Ads\" link:\
$Map{'CGIBIN'}/Afl_GenBannerChoices.cgi\
The advertisements on this page are presented to you actual size\
to help you decide which Banner, Text Link, or Start Page is
right for your needs.  For detailed information on individual\
Ads simply click the Ad itself in the \"Link\" column.\

Once you decide on an ad the next step is to Get the HTML.\
There are two places to open the \"Get Link HTML\" window.\
From the \"Get Banner Ads\" page click the \"Get Html\" link in\
the appropriate row.  From the \"Ad Detail\" window click the\
\"Get Html\" button.  In the \"Get Link HTML\" window use the\
drop down menu to choose which site you will be running this\
particular ad.  Use the radio buttons and check boxes to choose\
the desired behavior of this ad.  Once you have the ad set up\
click the \"Highlight All\" button to copy the HTML code provided.\
Remember, you must include all the above html in your links. Any\
missing html will prevent the link from tracking properly and\
result in a loss of commissions.\
\
Once you have the code provided pasted into your pages you are\
finished.  Just open one of your pages to confirm the ad is\
being displayed properly.\
\
Finally, make sure your Payment Information is correct so\
we know where to send your checks.\
$Map{'CGIBIN'}/Afl_AccountDetails.cgi\
(Note: Checks are mailed monthly or delayed until you have\
revenue in excess of \$50 US Dollars.)\
\
We look forward to providing you with the most effective\
pay-for-performance marketing available.  If you have questions\
or feedback you wish to share with us please contact $From.\
\
\
Thank you again for choosing StrategicAffiliates.com\
\n\
Sincerely,\
Client Services\
StrategicAffiliates.com
$From";

		($return_value, $output)= &SendMailFunctions::Mail_Blat($BlatPath, $SMTP, $From, $To, $Bcc, $Subject, $TempFile, $Body, $TempFilePath, $BlatLogFilePath, $Debug);
		if($return_value < 1)
			{
				print "\n<!-- Afl_Email_The_Publisher_Welcome_Message_To_User Success return_value = $return_value \n output = $output\n-->\n";
				return (1);
			}
		else
			{
				print "\n<!-- Afl_Email_The_Publisher_Welcome_Message_To_User Error return_value = $return_value \n output = $output\n-->\n";
				return (-1);
			}
	}
1;
