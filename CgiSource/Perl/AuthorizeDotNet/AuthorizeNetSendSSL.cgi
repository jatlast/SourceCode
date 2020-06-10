#!/usr/local/bin/perl -w
use CGI qw/:standard/;
use strict;

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

####### Gecko Technologies ####################################
# Merchant ID:  5431 3808 4400 1560 (with Charge.com)
#
# Merchant ID (MID):	532515	  	(with NOVA)
# Terminal ID (TID):	664045		(with NOVA)	
###############################################################

####### Authorize.Net #########################################
# 24/7 
# 1-877-447-3938 (press opt. #5 for tech support)
# support@authorizenet.com
# Transaction Key:  XgFKD77p3AiGRMdc
###############################################################

####### Charge.com ############################################
# 9am to 5pm M-F
# 1-954-584-2272  HQ (press opt. # 5 for tech support)
###############################################################

####### Processing Source International #######################
# 1-800-977-4770 Processor 		  7:30am to 4:30pm M-F
# 1-800-325-4021 Customer Care	  24/7 
###############################################################

####### First Data Resources (Nashville) ######################
# 24/7 
# 1-800-647-3722 (They do not troubleshoot) 
###############################################################


# DEFAULT SSL VERSION
$ENV{HTTPS_VERSION} = '3';

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "CgiFunctions.pl";
require "DatabaseFunctions.pl";
require "UtilityFunctions.pl";
# Authorize.net
require "SimLib.pm";

my $ProgramName = "AuthorizeNetSSL.cgi";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";

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
		print "<!-- $Map{'SYSTEM'} --><BR>\n" if $DebugThisAp eq "1";
		$Map{'PROGRAM_NAME'} = $ProgramName;
	}

# Added param for Admin_TransactionsLogAudit.cgi access...
my $Admin_Field = CGI::param('admin_field');
#	print "<!-- Admin_Field = ($Admin_Field) -->\n";
my $cookie_name = "";
my $cookie_password = "";

if($Admin_Field eq "baumbach")
	{
		$cookie_name = CGI::param('user_name');
		$cookie_password = CGI::param('password');
    	print "<!-- This should only happen when accessing through the \"Delete\" functionality of Admin_FreeFormAudit.cgi -->\n";
    	print "<!-- user_name = ($cookie_name) -->\n";
    	print "<!-- password = ($cookie_password) -->\n";
	}
else
	{
		$cookie_name = &CgiFunctions::Get_Cookie_Value("cookie_name", $DebugCgiFunctions);
		$cookie_password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);
	}

# Die if the user is not logged in...
&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map) if($cookie_password eq "");

# Parse the current date...
my $x_FP_Timestamp = time;
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime($x_FP_Timestamp);
# use parsed date to create unique name for transaction_id and SSLOG_FILE...
# Unique Name has the folling format username_m[m]_d[d]_yyyy_h[h]_m[m]_s[s]
my $UniqueID = $cookie_name . "_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
# use parsed date to create unique file name for SSLog file...
my $UniqueSSLogFile = "$Map{'LOG_FOLDER'}/"  . $UniqueID . ".html";
#print "Before opening the log file.<BR>\n";
# Create and open the file that this program will populate...
open (SSLOG_FILE, "> $UniqueSSLogFile") || die "Can't open $UniqueSSLogFile: $!\n";
#print "After opening the log file.<BR>\n";

my $ClockStart = localtime();
print SSLOG_FILE "Start: ($ClockStart)<BR><BR>\n";

my @QueryStringParams;
my %QueryStringHash;

# Load the values passed in into the QueryStringHash...
@QueryStringParams = CGI::param();
%QueryStringHash = &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

my $x_trans_id 	   		= "empty";
my $transaction_id 		= $UniqueID;
# only used when this program is called by Admin_BatchAuthNetSend.pl
my $batch_transaction_id = "";

# membership_type
my $membership_type_id		= "Empty";
my $membership_type_name	= "Empty";
my $membership_description	= "Empty";
my $promotion_duration		= "Empty";
my $date_promotion_ended	= "Empty";
my $months_1	= "Empty";
my $months_3	= "Empty";
my $months_6	= "Empty";
my $months_12	= "Empty";
my $months_240	= "Empty";
my $rebilled_1	= "Empty";
my $rebilled_3	= "Empty";
my $rebilled_6	= "Empty";
my $rebilled_12	= "Empty";

my $plan_unique_id		= "Empty";
my $promo_code_status	= "Empty";

my $is_this_batch = "0";
if($QueryStringHash{'batch_transaction_id'})
{
	$is_this_batch = "1";
}

my $SqlStatement = "genAuthorizeNetFormCC \'$cookie_name\', \'$cookie_password\', \'$QueryStringHash{'plan_unique_id'}\', \'$is_this_batch\'";

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
							
						# membership_type
						$membership_type_id		= $$dataref{membership_type_id};
						$membership_type_name	= $$dataref{membership_type_name};
						$membership_description	= $$dataref{membership_description};
						$promotion_duration		= $$dataref{promotion_duration};
						$date_promotion_ended	= $$dataref{date_promotion_ended};
						$months_1				= $$dataref{months_1};
						$months_3				= $$dataref{months_3};
						$months_6				= $$dataref{months_6};
						$months_12				= $$dataref{months_12};
						$months_240				= $$dataref{months_240};
						$rebilled_1				= $$dataref{rebilled_1};
						$rebilled_3				= $$dataref{rebilled_3};
						$rebilled_6				= $$dataref{rebilled_6};
						$rebilled_12			= $$dataref{rebilled_12};
							
						$plan_unique_id			= $$dataref{plan_unique_id};
						$promo_code_status		= $$dataref{promo_code_status};

						if($DebugThisAp eq "1")
							{
								print "<!-- membership_type_id   = ($membership_type_id) -->\n";
								print "<!-- membership_type_name = ($membership_type_name) -->\n";
								print "<!-- membership_description = ($membership_description) -->\n";
								print "<!-- promotion_duration	 = ($promotion_duration) -->\n";
								print "<!-- date_promotion_ended = ($date_promotion_ended) -->\n";
								print "<!-- months_1             = ($months_1) -->\n";
								print "<!-- months_3             = ($months_3) -->\n";
								print "<!-- months_6             = ($months_6) -->\n";
								print "<!-- months_12            = ($months_12) -->\n";
								print "<!-- months_240           = ($months_240) -->\n";
								print "<!-- rebilled_1           = ($rebilled_1) -->\n";
								print "<!-- rebilled_3           = ($rebilled_3) -->\n";
								print "<!-- rebilled_6           = ($rebilled_6) -->\n";
								print "<!-- rebilled_12          = ($rebilled_12) -->\n";
								print "<!-- plan_unique_id       = ($plan_unique_id) -->\n";
								print "<!-- promo_code_status    = ($promo_code_status) -->\n";
							}
					}
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}

my $ua = new LWP::UserAgent;

# Proxy for testing on Burns
#$ua->proxy('http', 'http://10.10.10.11:8080/') if $Map{'CONFIG'} eq "DEV";
#$ua->no_proxy('secaple.com');

# Switches...
my $AuthorizeNetTestMode 				= $Map{'AUTHORIZE_TEST_MODE'}; # Sets up test defaults
my $AuthorizeNetADCRelayResponseMode   	= "1"; # Default
my $AuthorizeNetADCDirectResponseMode   = "0"; # Currently not usable (9-1-2001)

if($AuthorizeNetTestMode eq "1")
	{
		print SSLOG_FILE "Authorize.Net <FONT color=\"red\">Test</FONT> Mode.<BR>\n";
	}
else
	{
		print SSLOG_FILE "Authorize.Net <FONT color=\"red\">LIVE</FONT> Mode.<BR>\n";
	}
	
if($AuthorizeNetADCRelayResponseMode eq "1")
	{
		print SSLOG_FILE "ADC Relay Response Mode.<BR>\n";
	}
if($AuthorizeNetADCDirectResponseMode eq "1")
	{
		print SSLOG_FILE "ADC Direct Response Mode.<BR>\n";
	}
if($QueryStringHash{'x_method'} eq "ECHECK")
	{
		print SSLOG_FILE "eCheck.Net Transaction Mode.<BR>\n";
	}

# Authorize Net HTTPS Credit Card processor URL...
my $URL = "";

# Always use POST when connecting to Authorize Net...
my $request;

if($promo_code_status eq "SUCCESS")
	{
		print SSLOG_FILE "Membership Type Name: <FONT color=\"red\">$membership_type_name</FONT> matches what the user entered.<BR>\n";
		print SSLOG_FILE " DB plan_unique_id:($plan_unique_id)<BR>\n";
		print SSLOG_FILE "CGI plan_unique_id:($QueryStringHash{'plan_unique_id'})<BR>\n";

		if($promotion_duration > 0 and $QueryStringHash{'months_joined'} eq "0" and $QueryStringHash{'x_method'} eq "BYPASS")
			{
				print SSLOG_FILE "Bypass Authorize.net<BR>\n";
				# Authorize Net HTTPS Credit Card processor URL...
				#my $URL = "https://secure.authorize.net/gateway/transact.dll";
				$URL = "$Map{'CGIBIN'}/AuthorizeNetReceive.cgi";

				# Always use POST when connecting to Authorize Net...
				$request = new HTTP::Request('POST', $URL);
#				$request->push_header(Referer => 'http://www.PersianConnections.com');
#				print SSLOG_FILE "Header Referer (" . $request->header('Referer') . ").<BR>\n";
				$request->content_type('application/x-www-form-urlencoded');
				################################################
				# REQUIRED Authorize Net fields for 
				# ADC Direct Response...
				################################################

				##########################################################
				########### Log the following ############################
				##########################################################

				# Initialize the sql statement and build it as you go...												   														  
				$SqlStatement = "transaction_credit_card_send ";

				# Stored Procedure transaction_credit_card_send -- Field = (transaction_id)
				# x_Ship_To_Address (any string) 60
				$request->add_content("x_ship_to_address=$transaction_id&");
				$SqlStatement = $SqlStatement . "\"$transaction_id\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (batch_transaction_id)
				# x_Ship_To_Country (any string)
				$request->add_content("x_ship_to_country=&");
				$SqlStatement = $SqlStatement . "\"\", ";
							
				# Stored Procedure transaction_credit_card_send -- Field = (user_name)
				# x_Ship_To_First_Name (any string) 50
				$request->add_content("x_ship_to_first_name=$cookie_name&");
				$SqlStatement = $SqlStatement . "\"$cookie_name\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (x_customer_IP)
				# x_Customer_IP (must be in the formate 255.255.255.255) {sent to authorize.net for display purposes}
				$request->add_content("x_customer_ip=$QueryStringHash{'x_customer_IP'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'x_customer_IP'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (months_joined)
				# x_Ship_To_City (any string) {sent to authorize.net for display purposes}
				$request->add_content("x_ship_to_city=$QueryStringHash{'months_joined'}&");
				# Stored Procedure transaction_credit_card_send -- Field = (amount)
				# x_Amount (any valid monitary amount) 8
				#    Note: To cause the system to generate a specific error 
				#    while in testing mode, send a transaction with the card number 
				#    4222222222222 (x_Card_Num), and an amount (x_Amount) equal to 
				#    the number of the error you want the system to return, as enumerated 
				#    in Appendix C (https://secure.authorize.net/docs/response.pml)
				my $dollar_amount = "";
				if($QueryStringHash{'months_joined'} eq "0")
					{
						$dollar_amount = 0;	
					}
				else
					{
						# Die if months_joined is not recognized
						&UtilityFunctions::Print_Framed_Error("Transaction not recognized.<BR><!-- months_joined ($QueryStringHash{'months_joined'}) not recognized -->", $DebugUtilityFunctions, %Map);
					}

				$request->add_content("x_amount=$dollar_amount&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'months_joined'}\", \"$dollar_amount\", \"0\", \"$plan_unique_id\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (name_on_card)
				# x_Ship_To_Last_Name (any string) 50
				$request->add_content("x_ship_to_last_name=$cookie_name&");
				$SqlStatement = $SqlStatement . "\"$cookie_name\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (card_type)
				# x_Ship_To_State (any string) {sent to authorize.net for display purposes}
				$SqlStatement = $SqlStatement . "\"0\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (cvv2_code)
				# x_Card_Code (any valid CVV2 or CVC2 value) 3
				#    Note: Test # is (???) for generating error codes based on dollar amounts
				$SqlStatement = $SqlStatement . "\"000\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (account_number)
				# x_Card_Num (any valid credit card number) 22
				#    Note: Test # is (4222222222222) for generating error codes based on dollar amounts
				#    Note: Test # is (4007000000027) for generating approvals
				if($AuthorizeNetTestMode eq "1")
					{
						# x_Test_Request ( TRUE or {False} )
						$request->add_content('x_test_request=TRUE&');
					}
				else
					{ 
						# x_Test_Request ( TRUE or {False} )
						# Note: Does NOT overide Test Mode in Merchant Setting
						$request->add_content('x_test_request=FALSE&');
					}
				$SqlStatement = $SqlStatement . "\"0000000000000000\", ";

				# Last 4 digits of the card number...
				# x_Ship_To_Zip (any string) {sent to authorize.net for display purposes}
				$request->add_content("x_ship_to_zip=0000&");

				# expiration date of the promotional membership...
				# x_Ship_To_Zip (any string) {sent to authorize.net for display purposes}
				$request->add_content("x_ship_to_company=$date_promotion_ended&");

				# name of promotional membership...
				# membership_type_name
				$request->add_content("membership_type_name=$membership_type_name&");

				# Stored Procedure transaction_credit_card_send -- Field = (expiration_date)
				# x_Exp_Date (MMYY, MM/YY, MM/YYYY) 6
				$SqlStatement = $SqlStatement . "\"00\", ";
				$SqlStatement = $SqlStatement . "\"0000\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (transaction_type)
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
				$request->add_content("x_type=BYPASS&");
				$SqlStatement = $SqlStatement . "\"BYPASS\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (x_trans_id)
				# generated by Authorize Net 
				# Only required for CREDIT transactions
				# Saved upon receipt by AuthorizeNetReceive.cgi
				$request->add_content("x_trans_id=000000000&");
				$SqlStatement = $SqlStatement . "\"000000000\", ";

				# x_Description (any string) 255
				my $Description;
				if($QueryStringHash{'batch_transaction_id'})
				{
					$Description = "BATCH -- BYPASS -- AuthorizeNet credit card transaction via the web interface -- Admin_BatchAuthNetSend.pl / Adv_AuthorizeNetSendSSL.cgi";
				}
				else
				{
					$Description = "BYPASS -- AuthorizeNet credit card transaction via the web interface -- GenAuthorizeNetSend.cgi / Adv_AuthorizeNetSendSSL.cgi";
				}

				$request->add_content("x_description=$Description&");
				$SqlStatement = $SqlStatement . "\"$Description\", ";

				# x_Method (CC or ECHECK)
				$request->add_content("x_method=$QueryStringHash{'x_method'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'x_method'}\", ";

				# x_Bank_ABA_Code (any valid bank ABA code)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Bank_Acct_Num (any valid bank account number)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Bank_Acct_Type (CHECKING or SAVINGS)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Bank_Name (valid bank name)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Bank_Acct_Name (Name on the Customer's bank account)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Echeck_Type (WEB)
				$SqlStatement = $SqlStatement . "\"\", ";

				##########################################################
				########### Address Verification Fields ##################
				##################### (AVS) ##############################
				##########################################################

				$SqlStatement = $SqlStatement . "\"\", ";

				# x_City (Any string 40)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_State (Any valid two-digit state code or full state name 40)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Zip (Any string 20)
				$SqlStatement = $SqlStatement . "\"\", ";

				# x_Country (Any valid two-digit country code or full country name (Spelled in English) 60)
				$SqlStatement = $SqlStatement . "\"\", ";

				##########################################################
				############ Mock Authorize Net Apporval #################
				##########################################################
				# x_response_code 1 = Approved
				$request->add_content("x_response_code=1&");
				# x_response_subcode 
				$request->add_content("x_response_subcode=BYPASS&");
				# x_response_reason_code 
				$request->add_content("x_response_reason_code=00&");
				# x_response_reason_text
				$request->add_content("x_response_reason_text=This transaction has been approved internally&");
				# x-cvv2_response_code
				$request->add_content("cvv2_response_code=BY&");
				# x_auth_code
				$request->add_content("x_auth_code=000000&");
				# x_avs_code
				$request->add_content("x_avs_code=0&");
				# x_trans_id
				$request->add_content("x_trans_id=000000000&");
				# x_md5_hash
				$request->add_content("x_md5_hash=0&");

				##########################################################
				############### Fingerpring Fields #######################
				##################### (SIM) ##############################
				##########################################################

				# x_FP_Hash 
				#  This is the fingerprint generated using the HMAC hashing algorithm
				#  on the merchant's transaction key and teh following fields:
				#	1. (x_Login)		Merchant Login ID
				#	2. (x_Amount)		Amount of the transaction
				#	3. (x_FP_Sequence)	The sequence number of the transaction (can be a random number) 
				#	4. (x_FP_Timestamp)	The time when the sequence number was generated
				#	5. (x_Currency_Code)The currency code field is required when generaing the SIM field (we use LinkMap.dat value for CURRENCY_CODE)
				$SqlStatement = $SqlStatement . "\"\"";
			}
		elsif($promotion_duration eq "0" and $QueryStringHash{'months_joined'} ne "0")
			{
				print SSLOG_FILE "Use Authorize.net.<BR>\n";
				# Authorize Net HTTPS Credit Card processor URL...

				# form to echo back what I sent in...
#				my $URL = "http://www.sluggis.com/cgi-bin/echo.cgi";
				# Actual processing form
				my $URL = "https://secure.authorize.net/gateway/transact.dll";
				# Form to test the finger print (not for use in this script)
#				my $URL = "http://www.sluggis.com/fptest.htm";

				# Always use POST when connecting to Authorize Net...
				$request = new HTTP::Request('POST', $URL);
#				$request->push_header(Referer => 'http://www.PersianConnections.com');
#				print SSLOG_FILE "Header Referer (" . $request->header('Referer') . ").<BR>\n";
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
						# x_Relay_Response (TRUE if ADC Relay Response Mode)
						$request->content('x_relay_response=TRUE&');
						# x_Relay_URL (URL for processing response from Authorize.Net)
						my $ResponseUrl = $Map{'CGIBIN'} . "/AuthorizeNetReceive.cgi";
						$request->add_content("x_relay_url=$ResponseUrl&");
						# x_Show_Form (PAYMENT_FORM)
						#  Note: use this field if want to show the system's payment form.
						#		$request->add_content('x_Show_Form=PAYMENT_FORM&');
					}
				elsif($AuthorizeNetADCDirectResponseMode eq "1")
					{
						# x_Delim_Data (Always TRUE for ADC Direct)
						$request->content('x_delim_data=TRUE&');
						# x_Relay_URL (Always FALSE for ADC Direct Response)
						$request->add_content('x_relay_url=FALSE&');
					}

#				$request->add_content("x_show_form=payment_form&");

				##########################################################
				########### Log the following ############################
				##########################################################

				# Initialize the sql statement and build it as you go...												   														  
				$SqlStatement = "transaction_credit_card_send ";

				# Stored Procedure transaction_credit_card_send -- Field = (transaction_id)
				# x_Ship_To_Address (any string) 60
				$request->add_content("x_ship_to_address=$transaction_id&");
				$SqlStatement = $SqlStatement . "\"$transaction_id\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (batch_transaction_id)
				# x_Ship_To_Country (any string)
				$request->add_content("x_ship_to_country=$QueryStringHash{'batch_transaction_id'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'batch_transaction_id'}\", ";
							
				# Stored Procedure transaction_credit_card_send -- Field = (user_name)
				# x_Ship_To_First_Name (any string) 50
				$request->add_content("x_ship_to_first_name=$cookie_name&");
				$SqlStatement = $SqlStatement . "\"$cookie_name\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (x_customer_IP)
				# x_Customer_IP (must be in the formate 255.255.255.255) {sent to authorize.net for display purposes}
				$request->add_content("x_customer_ip=$QueryStringHash{'x_customer_IP'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'x_customer_IP'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (months_joined)
				# x_Ship_To_City (any string) {sent to authorize.net for display purposes}
				$request->add_content("x_ship_to_city=$QueryStringHash{'months_joined'}&");
				# Stored Procedure transaction_credit_card_send -- Field = (amount)
				# x_Amount (any valid monitary amount) 8
				#    Note: To cause the system to generate a specific error 
				#    while in testing mode, send a transaction with the card number 
				#    4222222222222 (x_Card_Num), and an amount (x_Amount) equal to 
				#    the number of the error you want the system to return, as enumerated 
				#    in Appendix C (https://secure.authorize.net/docs/response.pml)
				my $dollar_amount = "";
				my $rebilling_amount = "";
				if($QueryStringHash{'months_joined'} eq "1")
					{
						$dollar_amount = $months_1;	
						$rebilling_amount = $rebilled_1;	
					}
				elsif($QueryStringHash{'months_joined'} eq "3")
					{
						$dollar_amount = $months_3;	
						$rebilling_amount = $rebilled_3;	
					}
				elsif($QueryStringHash{'months_joined'} eq "6")
					{
						$dollar_amount = $months_6;	
						$rebilling_amount = $rebilled_6;	
					}
				elsif($QueryStringHash{'months_joined'} eq "12")
					{
						$dollar_amount = $months_12;	
						$rebilling_amount = $rebilled_12;	
					}
				elsif($QueryStringHash{'months_joined'} eq "240")
					{
						$dollar_amount = $months_240;	
						$rebilling_amount = "0";	
					}
				else
					{
						# Die if months_joined is not recognized
						&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.<BR><!-- months_joined ($QueryStringHash{'months_joined'}) not recognized -->", $DebugUtilityFunctions, %Map);
					}

				if($QueryStringHash{'batch_transaction_id'} ne "")
					{
						$request->add_content("x_amount=$QueryStringHash{'rebilling_amount'}&");
						$SqlStatement = $SqlStatement . "\"$QueryStringHash{'months_joined'}\", \"$QueryStringHash{'rebilling_amount'}\", \"$QueryStringHash{'rebilling_amount'}\", \"$plan_unique_id\", ";
					}
				else
					{
						$request->add_content("x_amount=$dollar_amount&");
						$SqlStatement = $SqlStatement . "\"$QueryStringHash{'months_joined'}\", \"$dollar_amount\", \"$rebilling_amount\", \"$plan_unique_id\", ";
					}

				# Stored Procedure transaction_credit_card_send -- Field = (name_on_card)
				# x_Ship_To_Last_Name (any string) 50
				$request->add_content("x_ship_to_last_name=$QueryStringHash{'name_on_card'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'name_on_card'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (card_type)
				# x_Ship_To_State (any string) {sent to authorize.net for display purposes}
				$request->add_content("x_ship_to_state=$QueryStringHash{'card_type'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'card_type'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (cvv2_code)
				# x_Card_Code (any valid CVV2 or CVC2 value) 3
				#    Note: Test # is (???) for generating error codes based on dollar amounts
				$request->add_content("x_card_code=$QueryStringHash{'cvv2_code'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'cvv2_code'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (account_number)
				# x_Card_Num (any valid credit card number) 22
				#    Note: Test # is (4222222222222) for generating error codes based on dollar amounts
				#    Note: Test # is (4007000000027) for generating approvals
				if($AuthorizeNetTestMode eq "1")
					{
						# x_Test_Request ( TRUE or {False} )
						$request->add_content('x_test_request=TRUE&');
					}
				else
					{ 
						# x_Test_Request ( TRUE or {False} )
						# Note: Does NOT overide Test Mode in Merchant Setting
						$request->add_content('x_test_request=FALSE&');
					}
				$request->add_content("x_card_num=$QueryStringHash{'account_number'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'account_number'}\", ";

				# Last 4 digits of the card number...
				# x_Ship_To_Zip (any string) {sent to authorize.net for display purposes}
				my $LastFour = substr($QueryStringHash{'account_number'}, -4); 
				$request->add_content("x_ship_to_zip=$LastFour&");


				# Stored Procedure transaction_credit_card_send -- Field = (expiration_date)
				# x_Exp_Date (MMYY, MM/YY, MM/YYYY) 6
				$request->add_content("x_exp_date=$QueryStringHash{'expiration_month'}/$QueryStringHash{'expiration_year'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'expiration_month'}\", ";
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'expiration_year'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (transaction_type)
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
				if($QueryStringHash{'transaction_type'} eq "")
				{
					$QueryStringHash{'transaction_type'} = "AUTH_CAPTURE";
				}
				$request->add_content("x_type=$QueryStringHash{'transaction_type'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'transaction_type'}\", ";

				# Stored Procedure transaction_credit_card_send -- Field = (x_trans_id)
				# generated by Authorize Net 
				# Only required for CREDIT transactions
				# Saved upon receipt by AuthorizeNetReceive.cgi
				if(!$QueryStringHash{'x_trans_id'})
					{
						$QueryStringHash{'x_trans_id'} = "000000000";
					}
				else{
						print "<!-- REFUND x_trans_id = ($QueryStringHash{'x_trans_id'}) -->\n";
					}
				$request->add_content("x_trans_id=$QueryStringHash{'x_trans_id'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'x_trans_id'}\", ";

				# x_Description (any string) 255
				my $Description;
				if($QueryStringHash{'batch_transaction_id'} ne "")
				{
					if($AuthorizeNetTestMode eq "1")
						{
								$Description = "TEST MODE -- BATCH -- AuthorizeNet credit card transaction via the web interface -- Admin_BatchAuthNetSend.pl / AuthorizeNetSendSSL.cgi";
						}
					else
						{
								$Description = "BATCH -- AuthorizeNet credit card transaction via the web interface -- Admin_BatchAuthNetSend.pl / AuthorizeNetSendSSL.cgi";
						}
				}
				else
				{
					if($AuthorizeNetTestMode eq "1")
						{
							$Description = "TEST MODE -- AuthorizeNet credit card transaction via the web interface -- GenAuthorizeNetSend.cgi / AuthorizeNetSendSSL.cgi";
						}
					else
						{
							$Description = "AuthorizeNet credit card transaction via the web interface -- GenAuthorizeNetSend.cgi / AuthorizeNetSendSSL.cgi";
						}		
				}
				$request->add_content("x_description=$Description&");
				$SqlStatement = $SqlStatement . "\"$Description\", ";

				# x_Method (CC or ECHECK)
				$request->add_content("x_method=$QueryStringHash{'x_method'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'x_method'}\", ";

				# x_Bank_ABA_Code (any valid bank ABA code)
				$request->add_content("x_bank_aba_code=$QueryStringHash{'bank_ABA_code'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'bank_ABA_code'}\", ";

				# x_Bank_Acct_Num (any valid bank account number)
				$request->add_content("x_bank_acct_num=$QueryStringHash{'bank_account_number'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'bank_account_number'}\", ";

				# x_Bank_Acct_Type (CHECKING or SAVINGS)
				$request->add_content("x_bank_acct_type=$QueryStringHash{'bank_account_number'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'bank_account_number'}\", ";

				# x_Bank_Name (valid bank name)
				$request->add_content("x_bank_name=$QueryStringHash{'bank_name'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'bank_name'}\", ";

				# x_Bank_Acct_Name (Name on the Customer's bank account)
				$request->add_content("x_bank_acct_name=$QueryStringHash{'bank_account_name'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'bank_account_name'}\", ";

				# x_Echeck_Type (WEB)
				$request->add_content("x_echeck_type=WEB&");
				$SqlStatement = $SqlStatement . "\"WEB\", ";

				##########################################################
				########### Address Verification Fields ##################
				##################### (AVS) ##############################
				##########################################################

				(my $x_First_Name, my $x_Last_Name) = split(/\s+/, $QueryStringHash{'name_on_card'}, 2);
				# x_First_Name (any string 50)
				$request->add_content("x_first_name=$x_First_Name&");
				# x_Last_Name (any string 50)
				$request->add_content("x_last_name=$x_Last_Name&");

				# x_Company (any string 50) 
				# -- NOTE: used just for mail receipt ---
				$request->add_content("x_company=$Map{'DBUSER'}&");

				# x_Address (Any string 60)
				$request->add_content("x_address=$QueryStringHash{'street_address'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'street_address'}\", ";

				# x_City (Any string 40)
				$request->add_content("x_city=$QueryStringHash{'city'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'city'}\", ";

				# x_State (Any valid two-digit state code or full state name 40)
				$request->add_content("x_state=$QueryStringHash{'state_code'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'state_code'}\", ";

				# x_Zip (Any string 20)
				$request->add_content("x_zip=$QueryStringHash{'zip'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'zip'}\", ";

				# x_Country (Any valid two-digit country code or full country name (Spelled in English) 60)
				$request->add_content("x_country=$QueryStringHash{'country_code'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'country_code'}\", ";

				# x_phone (Any string [Recommended format (123)123-1234] 25)
				$request->add_content("x_phone=$QueryStringHash{'telephone'}&");
				$SqlStatement = $SqlStatement . "\"$QueryStringHash{'telephone'}\", ";

				##########################################################
				############### Fingerpring Fields #######################
				##################### (SIM) ##############################
				##########################################################

				# x_Login (any valid murchant login ID 20)
				$request->add_content('x_login=tgecko&');
							
				# x_currency_code (Valid currency code 3 -- LinkMap CURRENCY_CODE)
				my $currency_code = $Map{'CURRENCY_CODE'};
				$request->add_content("x_currency_code=$currency_code&");
							
				# x_FP_Sequence (This is a merchant-determined value that ensures the fingerprint is unique)
				#  Note: this field can be just a random number
				$request->add_content("x_fp_sequence=$UniqueID&");

				# x_FP_Timestamp (UTC time in seconds since Jan 1, 1970)
				#  Note: this field can be just a random number
				$request->add_content("x_fp_timestamp=$x_FP_Timestamp&");

				# x_FP_Hash 
				#  This is the fingerprint generated using the HMAC hashing algorithm
				#  on the merchant's transaction key and teh following fields:
				#	1. (x_Login)		Merchant Login ID
				#	2. (x_Amount)		Amount of the transaction
				#	3. (x_FP_Sequence)	The sequence number of the transaction (can be a random number) 
				#	4. (x_FP_Timestamp)	The time when the sequence number was generated
				#	5. (x_Currency_Code)The currency code field is optional (we use LinkMap CURRENCY_CODE)
				my $x_FP_Hash = "";
				if($QueryStringHash{'batch_transaction_id'} ne "")
					{
						$x_FP_Hash = &SimLib::GenerateInspFP("tgecko", "XgFKD77p3AiGRMdc", $QueryStringHash{'rebilling_amount'}, $UniqueID, $x_FP_Timestamp, $currency_code);
					}
				else
					{
						$x_FP_Hash = &SimLib::GenerateInspFP("tgecko", "XgFKD77p3AiGRMdc", $dollar_amount, $UniqueID, $x_FP_Timestamp, $currency_code);
					}
				$request->add_content("x_fp_hash=$x_FP_Hash&");
				$SqlStatement = $SqlStatement . "\"$x_FP_Hash\"";
			}
		else
			{
				print SSLOG_FILE "Suspicious Transaction -- ABORTING --<BR>\n";
				print SSLOG_FILE "promotion_duration =  ($promotion_duration)<BR>\n";
				print SSLOG_FILE "months_joined =  ($QueryStringHash{'months_joined'})<BR>\n";
				&UtilityFunctions::Print_Framed_Error("The transaction is not recognized.<BR>Please try again.", $DebugUtilityFunctions, %Map);
			}
	}
else
	{
		&UtilityFunctions::Print_Framed_Error("The membership plan is not recognized.<BR>Please try again.", $DebugUtilityFunctions, %Map);
	}



my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, $ProgramName, $SqlStatement, $DebugDatabaseFunctions);
print "\n<!-- Run_This_Sql_Statement return_value = $return_value-->\n" if $DebugThisAp eq "1";
if($return_value eq "1")
	{
		print "\n<!-- SUCCESS:  $transaction_id was successfully logged to the DB. -->\n";
		##########################################################
		########### End Logging       ############################
		##########################################################
			
		# x_Password (valid password for x_Login)
		#
		#   Note: NOT REQUIRED for the following 
		#
		#   x_Type values:
		#		CAPTURE_ONLY
		#		PRIOR_AUTH_CAPTURE
		#
		#   Note: IS REQUIRED for the following 
		#
		#   x_Type values:
		#	   	CREDIT
		#		VOID
		#
		# as of 10/21/02 the password cannot be submitted when using ADC Response...
		# as of 12/20/02 the password will not be submitted using ADC Response (SIM)...
#		if($transaction_type eq "CREDIT" or $transaction_type eq "VOID")
#		{
#			$request->add_content('x_Password=super8&');
#		}

			
		##############
		# RECOMMENDED
		##############
			
		# x_Version (2.5, 3.0, or 3.1)
		# Recommended to be set to 3.1 to inform the 
		# system that you are passing 3.1 code
		# so it can check the CVV2 number...
		$request->add_content('x_version=3.1&');
			
		# List all the field value pairs passed to Authorize.Net
		my $ContentList = $request->content();
		print SSLOG_FILE "<BR>\n<FONT COLOR=\"#0000FF\">Field<\/FONT> = <FONT COLOR=\"#8B0000\">Value:<\/FONT><BR>\n<FONT COLOR=\"#0000FF\">";
		$ContentList =~ s/=/<\/FONT> = <FONT COLOR="#8B0000">/g;
		$ContentList =~ s/&/<BR><\/FONT>\n<FONT COLOR="#0000FF">/g;
		print SSLOG_FILE $ContentList . "<\/FONT>\n<BR>\n";
			
			
		my $response = $ua->request($request);
		if ($response->is_success) {
			print SSLOG_FILE "SUCCESS:\n";
			print SSLOG_FILE "Response Code: (" . $response->code . ")<BR>\n";
			print SSLOG_FILE $response->content . "\n";
			print $response->content . "\n";
			} else {
				print SSLOG_FILE "ERROR:\n";
				print SSLOG_FILE "URL: $URL\n";
				print SSLOG_FILE "Response Code: (" . $response->code . ")<BR>\n";
				print SSLOG_FILE $response->content . "\n";
				print SSLOG_FILE $response->error_as_HTML . "\n";
				print $response->error_as_HTML . "\n";
			}
        my $ClockEnd = localtime();
        print SSLOG_FILE "End: ($ClockEnd)\n";
        #print SSLOG_FILE "Duration: ($ClockStart - $ClockEnd)\n";
        close(SSLOG_FILE);
	}
else
	{
	my $ErrorText = "";
		if($DatabaseFunctions::DatabaseError eq "1006")
			{
			 	$ErrorText = "<FONT COLOR=\"#8B0000\">ERROR: User \"$cookie_name\" is already a paying member.</FONT><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		elsif($DatabaseFunctions::DatabaseError eq "1011")
			{
			 	$ErrorText = "<FONT COLOR=\"#8B0000\">ERROR: User \"$cookie_name\" is restricted.</FONT><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		elsif($DatabaseFunctions::DatabaseError eq "1012")
			{
			 	$ErrorText = "<FONT COLOR=\"#8B0000\">You must first <A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">verify your email address</A> before becoming a premium member.</FONT><BR><A href=\"$Map{'CGIBIN'}/ManageEmailVerification.cgi\">click here to verify email...</A><BR><BR><FONT COLOR=\"#0000FF\">Note: If you think this is incorrect please contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		else
			{
			 	$ErrorText = "<FONT COLOR=\"#8B0000\">ERROR: The system is currently unable to process the credit card transaciton for \"$cookie_name\".</FONT><BR><FONT COLOR=\"#0000FF\">Note: If you continue to experience this problem contact $Map{'EMAIL'}.</FONT><BR>\n";
			}
		print SSLOG_FILE "<BR>Authorize.Net was not contacted because:\n<BR>$ErrorText<BR>\n";

        my $ClockEnd = localtime();
        print SSLOG_FILE "End: ($ClockEnd)<BR>\n";
        #print SSLOG_FILE "Duration: ($ClockStart - $ClockEnd)\n";
        close(SSLOG_FILE);

		&UtilityFunctions::Print_Framed_Error($ErrorText, $DebugUtilityFunctions, %Map);
	}

exit 0;
