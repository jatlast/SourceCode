#!/usr/local/bin/perl -w
use strict;

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;

# DEFAULT SSL VERSION
$ENV{HTTPS_VERSION} = '3';

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "DatabaseFunctions.pl";
require "SendMailFunctions.pl";
require "UtilityFunctions.pl";

my $ProgramName = "AutherizeNetSSL.cgi";

my $DebugThisAp			   = "1";
my $DebugDatabaseFunctions = "1";
my $DebugMailSendFunctions = "1";
my $DebugUtilityFunctions  = "1";

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, 1); 
  
# Parse the current date...
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
# use parsed date to create unique file name for SSLog file...
my $UniqueSSLogFile = "$Map{'LOG_FOLDER'}admin/log/SSLog_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec . ".html";

# Create and open the file that this program will populate...
open (SSLOG_FILE, "> $UniqueSSLogFile") || die "Can't open $UniqueSSLogFile: $!\n";

my $ClockStart = localtime();
print SSLOG_FILE "Start: ($ClockStart)\n";

my $ua = new LWP::UserAgent;

# Proxy for testing on Burns
#$ua->proxy('http', 'http://10.10.10.11:8080/') if $Map{'CONFIG'} eq "DEV";
#$ua->no_proxy('secaple.com');

# Switches...
my $AuthorizeNetTestMode 				= "1"; # Sets up test defaults
my $AuthorizeNetADCDirectResponseMode   = "0"; # Currently not usable (9-1-2001)
my $AuthorizeNetADCRelayResponseMode   	= "1"; # Default
my $AuthorizeNeteCheckNetMode   		= "0"; # Only used for eCheck.Net transactions

if($AuthorizeNetTestMode eq "1")
	{
		print SSLOG_FILE "Authorize.Net Test Mode.\n";
	}
if($AuthorizeNetADCDirectResponseMode eq "1")
	{
		print SSLOG_FILE "ADC Direct Response Mode.\n";
	}
if($AuthorizeNetADCRelayResponseMode eq "1")
	{
		print SSLOG_FILE "ADC Relay Response Mode.\n";
	}
if($AuthorizeNeteCheckNetMode eq "1")
	{
		print SSLOG_FILE "eCheck.Net Transaction Mode.\n";
	}

# Autherize Net HTTPS Credit Card processor URL...
my $URL = "https://secure.authorize.net/gateway/transact.dll";
#my $URL = "http://138.89.13.95:1900/cgi-bin/AutherizeNetReceive.cgi";
#my $URL = "http://www.persianconnections.com/cgi-bin/AutherizeNetReceive.cgi";
#my $URL = "http://216.205.68.44/cgi-bin/AutherizeNetReceive.cgi";
#my $URL = "http://138.89.13.95:1900/cgi-bin/PrintEnv.cgi";

# Always use POST when connecting to Authorize Net...
my $request = new HTTP::Request('POST', $URL);
$request->content_type('application/x-www-form-urlencoded');
################################################
# REQUIRED Authorize Net fields for 
# ADC Direct Response...
################################################


############
# REQUIRED 
############
if($AuthorizeNetADCRelayResponseMode eq "1")
	{
		# x_ADC_Relay_Response (TRUE if ADC Relay Response Mode)
		$request->content('x_ADC_Relay_Response=TRUE&');
		# x_ADC_URL (URL for processing response from Authorize.Net)
		$request->add_content('x_ADC_URL=http://www.persianconnections.com/cgi-bin/AutherizeNetReceive.cgi&');
		# x_Show_Form (PAYMENT_FORM)
		#  Note: use this field if want to show the system's payment form.
#		$request->add_content('x_Show_Form=PAYMENT_FORM&');
	}
elsif($AuthorizeNetADCDirectResponseMode eq "1")
	{
		# x_ADC_Delim_Data (Always TRUE for ADC Direct)
		$request->content('x_ADC_Delim_Data=TRUE&');
		# x_ADC_URL (Always FALSE for ADC Direct Response)
		$request->add_content('x_ADC_URL=FALSE&');
	}


# x_Amount (any valid monitary amount)
#    Note: To cause the system to generate a specific error 
#    while in testing mode, send a transaction with the card number 
#    4222222222222 (x_Card_Num), and an amount (x_Amount) equal to 
#    the number of the error you want the system to return, as enumerated 
#    in Appendix C (https://secure.authorize.net/docs/response.pml)
$request->add_content('x_Amount=108&');

# x_Card_Num (any valid credit card number)
#    Note: Test # is (4222222222222)
if($AuthorizeNetTestMode eq "1")
	{
		$request->add_content('x_Card_Num=4222222222222&');
	}
else
	{ 
		$request->add_content('x_Card_Num=&');
	}

# x_Exp_Date (MMYY, MM/YY, MM/YYYY)
$request->add_content('x_Exp_Date=0303&');

# x_Login (any valid murchant login ID)
$request->add_content('x_Login=tgecko&');

# x_Password (valid password for x_Login)
#   Note: only REQUIRED for the follwoing 
#   x_Type values:
#	   			CREDIT
#				VOID
#		  	   	CAPTURE_ONLY
#		  	   	PRIOR_AUTH_CAPTURE
$request->add_content('x_Password=super8&');

##############
# RECOMMENDED
##############

# x_Version (2.5 or 3.0)
#   Recommended to be set to 3.0 to inform the 
#   system that you are passing 3.0 code.
$request->add_content('x_Version=3.0&');

if(1)
{
######################################
# REQUIRED for eCheck.Net transactions
######################################
if($AuthorizeNeteCheckNetMode eq "1")
	{
		# x_Method (CC or ECHECK)
		$request->add_content('x_Method=ECHECK&');
		# x_Bank_ABA_Code (any valid bank ABA code)
		$request->add_content('x_Bank_ABA_Code=&');
		# x_Bank_Acct_Num (any valid bank account number)
		$request->add_content('x_Bank_Acct_Num=&');
		##### OPTIONAL #####
		# x_Drivers_Liscense_Num (any string)
		$request->add_content('x_Drivers_Liscense_Num=Test x_Drivers_Liscense_Num&');
		# x_Drivers_Liscense_State (2-character state abbreviation)
		$request->add_content('x_Drivers_Liscense_State=NY&');
		# x_Drivers_Liscense_DOB (YYYMMDD)
		$request->add_content('x_Drivers_Liscense_DOB=19680726&');
	}


##############
# OPTIONAL
##############

####### START ###########
# Paper trail switches (Turn On/Off email)

# x_Email_Merchant (TRUE or FALSE)
$request->add_content('x_Email_Merchant=TRUE&');
# x_Merchant_Email (any valid email address)
$request->add_content('x_Merchant_Email=baumbach@bellatlantic.net&');

# x_Email_Customer (default=TRUE or FALSE)
$request->add_content('x_Email_Customer=TRUE&');
# x_Email (any valid email)
$request->add_content('x_Email=baumbach@bellatlantic.net&');

# Paper trail switches (Turn On/Off email)
####### END ###########

# x_Test_Request (TRUE or default=FALSE)
$request->add_content('x_Test_Request=TRUE&') if $AuthorizeNetTestMode eq "1";
 
# x_ADC_Delim_Character (any character default=,)
#$request->add_content('x_ADC_Delim_Character=,&');

# x_ADC_Encapsulate_Character (any character default=none)
#$request->add_content('x_ADC_Encapsulate_Character=none&');

# x_Auth_Code (any valid Authorization Code)
#$request->add_content('x_Auth_Code=&');

##### START ######### 
# Configuration Fields

# x_Background_URL (any valid URL)
#$request->add_content('x_Background_URL=&');

# x_Color_Background (any valid color or color hex code)
$request->add_content('x_Color_Background=#F5F5E3&');

# x_Color_Link (any valid color or color hex code)
$request->add_content('x_Color_Link=Red&');

# x_Color_Text (any valid color or color hex code)
$request->add_content('x_Color_Text=Brown&');


##### START ##############
# HEADER/FOOTER Fields

# x_Header_Email_Receipt (any valid text)
$request->add_content('x_Header_Email_Receipt=Test x_Header_Email_Receipt&');

# x_Header_Html_Payment_Form (any valid text or HTML)
$request->add_content('x_Header_Html_Payment_Form=Test x_Header_Html_Payment_Form&');

# x_Header_Html_Receipt (any valid text or HTML)
$request->add_content('x_Header_Html_Receipt=Test x_Header_Html_Receipt&');

# x_Footer_Email_Receipt (any valid text)
$request->add_content('x_Footer_Email_Receipt=Test x_Footer_Email_Receipt&');

# x_Footer_Html_Payment_Form (any valid text or HTML)
$request->add_content('x_Footer_Html_Payment_Form=Test x_Footer_Html_Payment_Form&');

# x_Footer_Html_Receipt (any valid text or HTML)
$request->add_content('x_Footer_Html_Receipt=Test x_Footer_Html_Receipt&');

# HEADER/FOOTER Fields
##### END ##############

# x_Logo_URL (any valid URL)
my $x_Logo_URL = "x_Logo_URL=" . $Map{'IMAGES'} . "/" . $Map{'LOGO'} . "&";
$request->add_content($x_Logo_URL);

# x_Receipt_Link_Method (default=LINK, POST, or GET)
$request->add_content("x_Receipt_Link_Method=Post&"); # note to self try with GET

# x_Receipt_Link_Text (any string default=Continue)
$request->add_content('x_Receipt_Link_Text=Test x_Receipt_Link_Text&');

my $x_Receipt_Link_URL = "x_Receipt_Link_URL=" . $Map{'ROOT'} . "&";
# x_Receipt_Link_URL (any string default=Continue)
$request->add_content($x_Receipt_Link_URL);

# Configuration Fields
##### END ######### 



##### START ##############
# Customer Info

# x_Cust_ID (any string)
$request->add_content('x_Cust_ID=Test x_Cust_ID&');

# x_First_Name (any string)
$request->add_content('x_First_Name=Test x_First_Name&');
# x_Last_Name (any string)
$request->add_content('x_Last_Name=Test x_Last_Name&');

# x_Company (any string)
$request->add_content('x_Company=Test x_Company&');
# x_Address (any string)
$request->add_content('x_Address=Test x_Address&');
# x_PO_Num (any string)
$request->add_content('x_PO_Num=Test x_PO_Num&');
# x_City (any string)
$request->add_content('x_City=Test x_City&');
# x_State (any string)
$request->add_content('x_State=Test x_State&');
# x_Zip (any string)
$request->add_content('x_Zip=Test x_Zip&');
# x_Country (any string)
$request->add_content('x_Country=Test x_Country&');

# x_Phone (any string)
$request->add_content('x_Phone=Test x_Phone&');
# x_Fax (any string)
$request->add_content('x_Fax=Test x_Fax&');

# Customer Info
##### END ################



##### START ######### 
# Customer Bank Info

# x_Bank_Account_Type (default=CHECKING, or SAVINGS)
$request->add_content('x_Bank_Account_Type=SAVINGS&');
# x_Bank_Name (any valid bank name)
$request->add_content('x_Bank_Name=Test x_Bank_Name&');
# x_Bank_Name (any valid bank name)
$request->add_content('x_Bank_Name=Test x_Bank_Name&');

# Customer Bank Info
##### END ################



##### START ######### 
# SHIP_TO

# x_Ship_To_First_Name (any string)
$request->add_content('x_Ship_To_First_Name=Test x_Ship_To_First_Name&');
# x_Ship_To_Last_Name (any string)
$request->add_content('x_Ship_To_Last_Name=Test x_Ship_To_Last_Name&');

# x_Ship_To_Company (any string)
$request->add_content('x_Ship_To_Company=Test x_Ship_To_Company&');

# x_Ship_To_Address (any string)
$request->add_content('x_Ship_To_Address=Test x_Ship_To_Address&');
# x_Ship_To_City (any string)
$request->add_content('x_Ship_To_City=Test x_Ship_To_City&');
# x_Ship_To_State (any string)
$request->add_content('x_Ship_To_State=Test x_Ship_To_State&');
# x_Ship_To_Zip (any string)
$request->add_content('x_Ship_To_Zip=Test x_Ship_To_Zip&');
# x_Ship_To_Country (any string)
$request->add_content('x_Ship_To_Country=Test x_Ship_To_Country&');

# SHIP_TO
##### END ######### 



##### START ######### 
# More Customer Info

# x_Description (any string)
$request->add_content('x_Description=Test x_Description&');
# x_Customer_IP (must be in the format 255.255.255.255)
# x_Tax_Exempt (TRUE or default=FALSE)
$request->add_content('x_Tax_Exempt=FALSE&');
$request->add_content('x_Customer_IP=216.205.68.44&');
# x_Customer_Organization_Type (default=I or B)
#    Note: I = Individual
#	 	   B = Business
$request->add_content('x_Customer_Organization_Type=I&');
# x_Customeer_Tax_ID (20 digits -- Numbers and Spaces only)
$request->add_content('x_Customeer_Tax_ID=12345123451234512345&');

# More Customer Info
##### END ######### 




##### START ######### 
# Transaction Info

# x_Trans_ID (any valid Transaction ID)
$request->add_content('x_Trans_ID=666&');
# x_Type (default=AUTH_CAPTURE)
# see Transaction Types - Appendex B 
# https://secure.authorize.net/docs/functions.pml
# The 6 Types:
# 	  	AUTH_CAPTURE
# 	  	AUTH_ONLY
# 	  	PRIOR_AUTH_CAPTURE
# 	  	CAPTURE_ONLY
# 	  	CREDIT
# 	  	VOID
$request->add_content('x_Type=AUTH_CAPTURE&');
# x_Tax (any valid currency amount)
$request->add_content('x_Tax=0.80&');
# x_Duty (any valid currency amount)
$request->add_content('x_Duty=22&');
# x_Freight (any valid currency amount)
$request->add_content('x_Freight=23.69&');
# x_Invoice_Num (any valid string)
$request->add_content('x_Invoice_Num=Test x_Invoice_Num');

# Transaction Info
##### END ######### 




##### START ######### 
# Unused Fields

# x_Rename ([OldVariableName],[NewVariableName])
#$request->add_content('x_Rename=&');

# x_Use_Fraudscreen (Reserved for future use)
#$request->add_content('x_Use_Fraudscreen=&');

# Unused Fields
##### END ######### 

}
	
# List all the field value pairs passed to Authorize.Net
my $ContentList = $request->content();
print SSLOG_FILE "<BR>\n<FONT COLOR=\"#0000FF\">Field<\/FONT> = <FONT COLOR=\"#8B0000\">Value:<\/FONT><BR>\n<FONT COLOR=\"#0000FF\">";
$ContentList =~ s/=/<\/FONT> = <FONT COLOR="#8B0000">/g;
$ContentList =~ s/&/<BR><\/FONT>\n<FONT COLOR="#0000FF">/g;
print SSLOG_FILE $ContentList . "<\/FONT>\n<BR>\n";


my $response = $ua->request($request);
if ($response->is_success) {
	print SSLOG_FILE "SUCCESS:\n";
	print SSLOG_FILE "Response Code: (" . $response->code . ").\n";
	print SSLOG_FILE $response->content . "\n";
	print $response->content . "\n";
} else {
	print SSLOG_FILE "ERROR:\n";
	print SSLOG_FILE "URL: $URL\n";
	print SSLOG_FILE "Response Code: (" . $response->code . ").\n";
	print SSLOG_FILE $response->content . "\n";
	print SSLOG_FILE $response->error_as_HTML . "\n";
	print $response->error_as_HTML . "\n";
}

my $ClockEnd = localtime();
print SSLOG_FILE "End: ($ClockEnd)\n";
#print SSLOG_FILE "Duration: ($ClockStart - $ClockEnd)\n";

close(SSLOG_FILE);
