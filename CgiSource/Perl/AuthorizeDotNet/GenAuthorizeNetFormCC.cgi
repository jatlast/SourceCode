#!/usr/local/bin/perl -w
use CGI qw/:standard/;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

use strict;

#Begin HTML so errors show up in browser...
print CGI::header('text/html');
print "<HTML>\n";

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "CgiFunctions.pl";
require "DatabaseFunctions.pl";
require "UtilityFunctions.pl";

my $ProgramName = "GenAuthorizeNetFormCC.cgi";

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "1";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";

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
		print "<!-- $Map{'SYSTEM'} -->\n";
		$Map{'PROGRAM_NAME'} = $ProgramName;
	}

# declare global variables...
my @QueryStringParams;
my %QueryStringHash;

my $cookie_name    = &CgiFunctions::Get_Cookie_Value("cookie_name", $DebugCgiFunctions);
my $cookie_password =  &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);

# Die if the user is not logged in...
&UtilityFunctions::Print_Framed_Error("You must be logged in for this script to work properly.", $DebugUtilityFunctions, %Map) if($cookie_password eq "");

# Load the values passed in into the QueryStringHash...
@QueryStringParams = CGI::param();
%QueryStringHash = &CgiFunctions::Load_Query_String_Hash(\@QueryStringParams, \$DebugCgiFunctions);

# Mail was sent internally...
&UtilityFunctions::Print_HTML_Top($ProgramName, $DebugUtilityFunctions, %Map);

# contact_info
my $first_name 		 = "Empty";
my $last_name 		 = "Empty";
my $street_address	 = "Empty";
my $city			 = "Empty";
my $state			 = "Empty";
my $state_code		 = "Empty";
my $country			 = "Empty";
my $country_code	 = "Empty";
my $zip				 = "Empty";
my $telephone		 = "Empty";
# billing_info
my $card_type 		= "Empty";
my $name_on_card 	= "Empty";
my $cvv2_code		= "Empty";
my $account_number	= "Empty";
my $expiration_month= "Empty";
my $expiration_year	= "Empty";
# membership_type
my $membership_type_id		= "Empty";
my $membership_type_name	= "Empty";
my $membership_description	= "Empty";
my $promotion_duration		= "Empty";
my $date_promotion_ended	= "Empty";
my $months_1			= "Empty";
my $months_3			= "Empty";
my $months_6			= "Empty";
my $months_12			= "Empty";
my $months_240			= "Empty";
my $rebilled_1			= "Empty";
my $rebilled_3			= "Empty";
my $rebilled_6			= "Empty";
my $rebilled_12			= "Empty";

my $plan_unique_id		= "Empty";
my $promo_code_status	= "Empty";

my $SqlStatement = "";

if($QueryStringHash{'promotion_code'})
	{
		print "<!-- Promotion Code ($QueryStringHash{'promotion_code'}) was entered. -->\n";
		$SqlStatement = "genAuthorizeNetFormCC \'$cookie_name\', \'$cookie_password\', \'$QueryStringHash{'promotion_code'}\'";
	}
else
	{
		print "<!-- No Promotion Code was entered.\n -->";
		$SqlStatement = "genAuthorizeNetFormCC \'$cookie_name\', \'$cookie_password\', \'\'";
	}


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
							
						# contact_info
						$first_name 	= $$dataref{first_name};
						$last_name 		= $$dataref{last_name};
						$street_address	= $$dataref{street_address};
						$city			= $$dataref{city};
						$state			= $$dataref{state};
						$state_code		= $$dataref{state_code};
						$country		= $$dataref{country};
						$country_code	= $$dataref{country_code};
						$zip			= $$dataref{zip};
						$telephone		= $$dataref{telephone};
						
						# billing_info
						$card_type 	      = $$dataref{card_type};
						$name_on_card 	  = $$dataref{name_on_card};
						$cvv2_code		  = $$dataref{cvv2_code};
						$account_number   = $$dataref{account_number};
						$expiration_month = $$dataref{expiration_month};
						$expiration_year  = $$dataref{expiration_year};

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
								print "<!-- first_name           = ($first_name) -->\n";
								print "<!-- last_name            = ($last_name) -->\n";
								print "<!-- street_address       = ($street_address) -->\n";
								print "<!-- city                 = ($city) -->\n";
								print "<!-- state                = ($state) -->\n";
								print "<!-- state_code           = ($state_code) -->\n";
								print "<!-- country              = ($country) -->\n";
								print "<!-- country_code         = ($country_code) -->\n";
								print "<!-- zip                  = ($zip) -->\n";
								print "<!-- telephone            = ($telephone) -->\n";
								print "<!-- card_type 	         = ($card_type) -->\n";
								print "<!-- name_on_card         = ($name_on_card) -->\n";
								print "<!-- cvv2_code            = ($cvv2_code) -->\n";
								print "<!-- account_number       = ($account_number) -->\n";
								print "<!-- expiration_month     = ($expiration_month) -->\n";
								print "<!-- expiration_year      = ($expiration_year) -->\n";
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


print "	  <TABLE width=\"100%\" border=\"0\" cellpadding=\"1\" cellspacing=\"1\">\n";
print "	    <tr>\n";
print "	     <TD width=\"60%\" class=\"AlignCenter\">\n";
print "	      <IMG src=\"$Map{'IMAGES'}/$Map{'PLEASE_CHOOSE_PLAN'}\" border=\"0\">\n";
print "	     </TD>\n";
print "	     <TD width=\"40%\" >\n";
if($promo_code_status eq "SUCCESS")
{
	print "	      <TABLE width=\"100%\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\" bordercolor=\"#3B5590\">\n";
	print "	       <TR valign=\"top\">\n";
	print "	        <TD class=\"AlignCenter\">\n";
	print "	          <b>Your promotional code has been successfully applied.</b><br>\n";
	print "	        </TD>\n";
	print "	       </tr>\n";
	print "	      </TABLE>\n";
}
elsif($promo_code_status eq "FAILURE")
{
	print "	      <TABLE width=\"100%\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\" bordercolor=\"#3B5590\">\n";
	print "	       <TR valign=\"top\">\n";
	print "	        <TD class=\"AlignCenter\">\n";
	print "	         <FORM name=\"update_payment_form\" method=\"POST\" action=\"GenAuthorizeNetFormCC.cgi\" onsubmit=\"return checkPromotionalCode(this)\">\n";
	print "	          <b><SPAN class=\"RedTextMedium\">Promotional code incorrect or expired.</SPAN></b><br>\n";
	print "	          Enter new code here:\n";
	print "	          <input type=\"text\" name=\"promotion_code\" size=\"20\">\n";
	print "	          <input type=\"image\" name=\"submit.promotion_code\" value=\"Update Payment Form\" border=\"0\" alt=\"Update Payment Form\" src=/images/promotion_code_apply.gif width=\"42\" height=\"14\" border=\"0\">\n";
	print "	         </FORM>\n";
	print "	        </TD>\n";
	print "	       </tr>\n";
	print "	      </TABLE>\n";
}
else
{
	print "	      <TABLE width=\"100%\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\" bordercolor=\"#3B5590\">\n";
	print "	       <TR valign=\"top\">\n";
	print "	        <TD class=\"AlignCenter\">\n";
	print "	         <FORM name=\"update_payment_form\" method=\"POST\" action=\"GenAuthorizeNetFormCC.cgi\" onsubmit=\"return checkPromotionalCode(this)\">\n";
	print "	          <b>Have a promotional code?&nbsp;</b><br>\n";
	print "	          Enter it here:\n";
	print "	          <input type=\"text\" name=\"promotion_code\" size=\"20\">\n";
	print "	          <input type=\"image\" name=\"submit.promotion_code\" value=\"Update Payment Form\" border=\"0\" alt=\"Update Payment Form\" src=/images/promotion_code_apply.gif width=\"42\" height=\"14\" border=\"0\">\n";
	print "	         </FORM>\n";
	print "	        </TD>\n";
	print "	       </tr>\n";
	print "	      </TABLE>\n";
}
print "	     </TD>\n";
print "	    </tr>\n";
print "	  </TABLE>\n";
print "		  <BR>\n";
if($promotion_duration eq "0")
	{
		print "          <TABLE width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#3B5590\">\n";
		print "            <TR valign=\"top\">\n";
		print "              <TD>\n";
		print "                <FORM method=\"POST\" action=\"AuthorizeNetSendSSL.cgi\" onsubmit=\"return checkForm(this)\">\n";
		print "                  <INPUT value=\"$ENV{REMOTE_ADDR}\" type=\"hidden\" name=\"x_customer_IP\">\n";
		print "                  <INPUT value=\"CC\" type=\"hidden\" name=\"x_method\"> \n";
		print "                  <INPUT value=\"$state_code\" type=\"hidden\" name=\"state_code\">\n";
		print "                  <INPUT value=\"$country_code\" type=\"hidden\" name=\"country_code\">\n";
		print "                  <INPUT value=\"$plan_unique_id\" type=\"hidden\" name=\"plan_unique_id\">\n";
		print "                  <TABLE border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"3\" class=\"BlackTextMedium\">\n";
		print "                        You are only a few easy steps away from connecting with other $Map{'WHICH_CONNECTIONS'}.com members. Please choose your membership plan and get ready to get the most from your $Map{'WHICH_CONNECTIONS'}.com experience.\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD height=\"25\" colspan=\"3\" class=\"BG1Text1\">\n";
		print "                        <IMG src=\"/images/upgrade_step1.gif\" border=\"0\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"25%\" class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"radio\" name=\"months_joined\" value=\"1\"> One Month\n";
		print "                      </TD>\n";
		print "                      <TD width=\"35%\" class=\"BlackTextMedium\">\n";
		printf ("                      $Map{'CURRENCY_SYMBOL'}%.2f\n", $months_1);
		print "                      </TD>\n";
		print "                      <TD rowspan=\"5\" width=\"40%\" class=\"BlackTextMedium\">\n";
		print "                      Plan Name:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$membership_type_name</SPAN><BR><BR>\n";
		print "                      <SPAN class=\"BlackTextMedium\">$membership_description</SPAN><BR><BR>\n";
		if($date_promotion_ended =~ m/2040/)
		{
			print "		                 Expires:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">Never</SPAN>\n";
		}
		else
		{
			print "		                 Expires:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$date_promotion_ended</SPAN>\n";
		}
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"122\" class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"radio\" name=\"months_joined\" value=\"3\"> Three Month\n";
		print "                      </TD>\n";
		print "                      <TD width=\"150\" nowrap class=\"paragraph_black_left_align\">\n";
		printf ("                      <SPAN class=\"BlackTextMedium\">$Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $months_3);
		printf (" Save %.0f", ( (1 - ($months_3 / ($months_1 * 3) ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"122\" class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"radio\" name=\"months_joined\" value=\"6\"> Six Month\n";
		print "                      </TD>\n";
		print "                      <TD width=\"150\" nowrap class=\"paragraph_black_left_align\">\n";
		printf ("                      <SPAN class=\"BlackTextMedium\">$Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $months_6);
		printf (" Save %.0f", ( (1 - ($months_6 / ($months_1 * 6) ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"122\" class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"radio\" name=\"months_joined\" value=\"12\"> One Year\n";
		print "                      </TD>\n";
		print "                      <TD width=\"150\" nowrap class=\"paragraph_black_left_align\">\n";
		printf ("                      <SPAN class=\"BlackTextMedium\">$Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $months_12);
		printf (" Save %.0f", ( (1 - ($months_12 / ($months_1 * 12) ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"radio\" name=\"months_joined\" value=\"240\"> Lifetime\n";
		print "                      </TD>\n";
		print "                      <TD width=\"150\" nowrap class=\"paragraph_black_left_align\">\n";
		printf ("                      <SPAN class=\"BlackTextMedium\">$Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $months_240);
		printf (" Save %.0f", ( (1 - ($months_240 / ($months_1 * 120) ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"3\">\n";
		print "                        <P class=\"BlackTextMedium\"> Your subscription will be \n";
		print "                      auto-renewed at the monthly rate listed below. You may cancel your \n";
		print "                      membership at anytime; simply logon to your account and click &quot;Cancel \n";
		print "                      Membership&quot; located beneath \"My Membership Type\" \n";
		print "                      on the bottom of the &quot;Member Home&quot; page. </P>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                  <TABLE border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"BG1Text1\">\n";
		print "                        <IMG src=\"/images/upgrade_step2.gif\" border=\"0\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                  <TD colspan=\"2\" class=\"RedTextLargeBold\"> Note: \n";
		print "                    Enter your name and address exactly as they appear on your \n";
		print "                    financial institution's account statement.</TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                  <TD>&nbsp;\n";
		print "                  </TD>\n";
		print "                  <TD class=\"BlackTextMedium\"> (all fields required)</TD>\n";
		print "                    </TR>\n";
		print "                    <!--  name_on_card -->\n";
		print "                    <TR>\n";
		print "	                  <TD class=\"AlignRight\">Name</TD>\n";
		print "                      <TD>\n";
		if($name_on_card eq "" or $name_on_card eq " ")
		{
			$name_on_card = $first_name . " " . $last_name
		}
		print "                        <INPUT name=\"name_on_card\" type=\"text\" id=\"name_on_card\" value=\"$name_on_card\" size=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "					<!--  street_address -->\n";
		print "                    <TR>\n";
		print "                  	<TD width=\"201\" class=\"AlignRight\">Address</TD>\n";
		print "                      <TD width=\"426\" >\n";
		print "                        <INPUT name=\"street_address\" type=\"text\" value=\"$street_address\" size=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <!--  city -->\n";
		print "                    <TR>\n";
		print "                      \n";
		print "                  <TD width=\"201\" class=\"AlignRight\">City</TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                        <INPUT name=\"city\" type=\"text\" value=\"$city\" size=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                   <!--  state -->\n";
		print "                    <TR>\n";
		print "                      \n";
		print "                  <TD width=\"201\" class=\"AlignRight\">State</TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                       <SELECT name=\"state\" size=\"1\">\n";
		# state ...
		&DatabaseFunctions::Print_Lookup_Table_Options('state', '', $state, '', '1', $DebugThisAp, %Map);
		print "                       </SELECT>\n";
		print "                     </TD>\n";
		print "                    </TR>\n";
		print "                    <!--  country -->\n";
		print "                    <TR>\n";
		print "                      \n";
		print "                  <TD width=\"201\" class=\"AlignRight\">Country</TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                       <SELECT name=\"country\" size=\"1\">\n";
		# state ...
		&DatabaseFunctions::Print_Lookup_Table_Options('country', '', $country, '', '1', $DebugThisAp, %Map);
		print "                       </SELECT>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <!--  zip -->\n";
		print "                    <TR>\n";
		print "                      \n";
		print "                  <TD width=\"201\" class=\"AlignRight\"> Postal Code</TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                        <INPUT name=\"zip\" type=\"text\" value=\"$zip\" size=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <!--  telephone  -->\n";
		print "                    <TR>\n";
		print "                      \n";
		print "                  <TD width=\"201\" class=\"AlignRight\"> Telephone</TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                        <INPUT name=\"telephone\" type=\"text\" value=\"$telephone\" size=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"201\">\n";
		print "                      </TD>\n";
		print "                      <TD width=\"426\">&nbsp;\n";
		print "                        \n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                  <TABLE border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" valign=\"middle\" class=\"BG1Text1\">\n";
		print "                        <IMG src=\"/images/upgrade_step3.gif\" border=\"0\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"201\" class=\"AlignRight\">\n";
		print "                        Card Type :\n";
		print "                      </TD>\n";
		print "                      <TD width=\"426\">\n";
		# card_type...
		print "                    <SELECT name=\"card_type\">\n";
		my %CardTypeHash;
		$CardTypeHash{''} = 'Choose Type';
		#$CardTypeHash{'3'} = 'American Express';
		$CardTypeHash{'4'} = 'Visa';
		$CardTypeHash{'5'} = 'Master Card';
		#$CardTypeHash{'6'} = 'Discover';
		while( (my $Key, my $Value) = each(%CardTypeHash) )
		{
				if ($card_type eq $Key) 
					{
						print "                     <OPTION value=\"$Key\" SELECTED>\n";
					}
				else
					{
						print "                     <OPTION value=\"$Key\">\n";
					}
				print "                     $Value\n";
				print "                     </OPTION>\n";
		}        

		print "                    </SELECT>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"201\" class=\"AlignRight\">\n";
		print "                        Card Account Number:\n";
		print "                      </TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                        <INPUT type=\"text\" name=\"account_number\" value=\"$account_number\" size=\"30\" maxlength=\"20\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"201\" class=\"AlignRight\">\n";
		print "                        Expiration Date :\n";
		print "                      </TD>\n";
		print "                      <TD width=\"426\">\n";
		print "                        <SELECT name=\"expiration_month\">\n";
		my @MonthArray	  = ("", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
		foreach my $CurrentMonth (@MonthArray) 
			{
				if ($expiration_month eq $CurrentMonth) 
					{
						print "                                        <OPTION value=\"$CurrentMonth\" SELECTED>\n";
					}
				else
					{
						print "                                        <OPTION value=\"$CurrentMonth\">\n";
					}
				print "                                          $CurrentMonth\n";
				print "                                        </OPTION>\n";
			}
		print "                    </SELECT> <SELECT name=\"expiration_year\">\n";
		my @YearArray	  = ("", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010");

		foreach my $CurrentYear (@YearArray) 
			{
				if ($expiration_year eq $CurrentYear) 
					{
						print "                                        <OPTION value=\"$CurrentYear\" SELECTED>\n";
					}
				else
					{
						print "                                        <OPTION value=\"$CurrentYear\">\n";
					}
				print "                                          $CurrentYear\n";
				print "                                        </OPTION>\n";
			}

		print "                    </SELECT>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"201\" class=\"AlignRight\">\n";
		print "                        <A href=\"javascript:newWindowGeneric('../WhatIsCVV2.html')\" title=\"What is CVV2?\">Verification Value (CVV2):</A>\n";
		print "                      </TD>\n";
		print "                      <TD class=\"BlackTextMedium\">\n";
		print "                        <INPUT type=\"text\" name=\"cvv2_code\" value=\"$cvv2_code\" size=\"8\" maxlength=\"4\"> <A href=\"javascript:newWindowGeneric('../WhatIsCVV2.html')\" title=\"What is CVV2?\"> Help...</A>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"BlackTextMedium\">\n";
		print "                        <SPAN class=\"BlackTextLargeBold\">Note:</SPAN> When you click on the \"I Authorize This Transaction\" button, your credit card will be charged Immediately.\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"paragraph_black_left_align\">\n";
		print "                        <SPAN class=\"BlackTextMedium\">You, the buyer, may cancel this agreement, without penalty or obligation, at any time prior to midnight of the 14th day following the date of this contract. To cancel this agreement, mail or deliver a signed and dated notice, or send a telegram which states that you, the buyer, are canceling this agreement, or words of similar effect. This notice shall be sent to: $Map{'WHICH_CONNECTIONS'}.com., Attn: Cancellations, 116 Willow Avenue Suite 4, Hoboken, NJ 07030.</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"BlackTextMedium\">\n";
		print "                        <SPAN class=\"BlackTextLargeBold\">Refund Policy:</SPAN>\n";
		print "                        <BR>\n";
		print "                         If you cancel your subscription within 14 days, we will refund the full amount of your subscription. Also, if you cancel your subscription within 14 days following any auto-renewal of your subscription, we will refund the full amount of your auto-renewal. In the event that you die before the end of your subscription period, your estate shall be entitled to a refund of that portion of any payment you have made for your subscription which is allocable to the period after your death. In the event that you become disabled (such that you are unable to use the services of $Map{'WHICH_CONNECTIONS'}.com) before the end of your subscription period, you shall be entitled to a refund of that portion of any payment you have made for your subscription which is allocable to the period after your disability.\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"paragraph_black_left_align\">&nbsp;\n";
		print "                        \n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"2\" class=\"AlignCenter\">\n";
		print "                        <FONT face=\"Arial, Helvetica, sans-serif\"> <INPUT name=\"CC_submit\" type=\"submit\" id=\"CC_submit\" value=\"&quot;I Authorize This Transaction&quot;\"></FONT>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                </FORM>\n";
		print "                <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
		print "                  <TR>\n";
		print "                    <TD width=\"6%\" align=\"left\" valign=\"top\">\n";
		print "                      <IMG src=\"/images/SmallPadlock_SSL.gif\" border=\"0\">\n";
		print "                    </TD>\n";
		print "                    <TD width=\"94%\" class=\"BlackTextMedium\">\n";
		print "                      Purchase with confidence. Our site uses SSL (Secure Sockets Layer) Technology to protect your transactions.\n";
		print "                    </TD>\n";
		print "                  </TR>\n";
		print "                  <TR>\n";
		print "                    <TD align=\"left\" valign=\"top\">&nbsp;\n";
		print "                      \n";
		print "                    </TD>\n";
		print "                    <TD class=\"paragraph_black_left_align\">&nbsp;\n";
		print "                      \n";
		print "                    </TD>\n";
		print "                  </TR>\n";
		print "                  <TR>\n";
		print "                    <TD colspan=\"2\" align=\"left\" valign=\"top\" class=\"paragraph_black_left_align\">\n";
		print "                      <SPAN class=\"BlackTextLargeBold\">Auto-renewal Rates</SPAN>\n";
		print "                      <BR>\n";
		print "                       <SPAN class=\"BlackTextMedium\">Auto-renewal rates apply to credit card payments only. Your subscription will be automatically renewed on 30-day intervals beginning no sooner than 2 days prior to your paid through date. This will ensure uninterrupted access to your subscription.</SPAN>\n";
		print "                    </TD>\n";
		print "                  </TR>\n";
		print "                  <TR>\n";
		print "                    <TD colspan=\"2\" align=\"left\" valign=\"top\" class=\"paragraph_black_left_align\">\n";
		print "                      <P class=\"BlackTextMedium\">&nbsp;\n";
		print "                        \n";
		print "                      </P>\n";
		print "                      <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"0\">\n";
		print "                        <TR>\n";
		print "                          <TD width=\"50%\" class=\"BlackTextMedium\">\n";
		print "                            Credit Card Renewal\n";
		print "                          </TD>\n";
		print "		                     <TD rowspan=\"5\" width=\"50%\" class=\"BlackTextMedium\">\n";
		print "		                     Plan Name:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$membership_type_name</SPAN><BR><BR>\n";
		print "		                     <SPAN class=\"BlackTextMedium\">$membership_description</SPAN><BR><BR>\n";
		if($date_promotion_ended =~ m/2040/)
		{
			print "		                     Expires:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">Never</SPAN>\n";
		}
		else
		{
			print "		                     Expires:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$date_promotion_ended</SPAN>\n";
		}
		print "							</TD>\n";
		print "                          \n";
		print "                        </TR>\n";
		print "                        <TR>\n";
		print "                          <TD>\n";
		printf ("                          <SPAN class=\"BlackTextMedium\">12 Month Renewal Rate $Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $rebilled_12);
		printf (" Save %.0f", ( (1 - ($rebilled_12 / $months_1 ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                          </TD>\n";
		print "                          \n";
		print "                        </TR>\n";
		print "                        <TR>\n";
		print "                          <TD>\n";
		printf ("                          <SPAN class=\"BlackTextMedium\">6 Month Renewal Rate $Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $rebilled_6);
		printf (" Save %.0f", ( (1 - ($rebilled_6 / $months_1 ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                          </TD>\n";
		print "                          \n";
		print "                        </TR>\n";
		print "                        <TR>\n";
		print "                          <TD>\n";
		printf ("                          <SPAN class=\"BlackTextMedium\">3 Month Renewal Rate $Map{'CURRENCY_SYMBOL'}%.2f</SPAN><SPAN class=\"RedTextMedium\">", $rebilled_3);
		printf (" Save %.0f", ( (1 - ($rebilled_3 / $months_1 ) ) * 100 ) );
		print "\%</SPAN>\n";
		print "                          </TD>\n";
		print "                          \n";
		print "                        </TR>\n";
		print "                        <TR>\n";
		print "                          <TD>\n";
		printf ("                          <SPAN class=\"BlackTextMedium\">Month to Month Renewal Rate $Map{'CURRENCY_SYMBOL'}%.2f</SPAN>", $rebilled_1);
		print "                          </TD>\n";
		print "                          \n";
		print "                        </TR>\n";
		print "                      </TABLE>\n";
		print "                    </TD>\n";
		print "                  </TR>\n";
		print "                </TABLE>\n";

	}
else
	{
		print "          <TABLE width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#3B5590\">\n";
		print "            <TR valign=\"top\">\n";
		print "              <TD>\n";
		print "                <FORM method=\"POST\" action=\"AuthorizeNetSendSSL.cgi\" onsubmit=\"return checkPromotionForm(this)\">\n";
		print "                  <INPUT value=\"$ENV{REMOTE_ADDR}\" type=\"hidden\" name=\"x_customer_IP\">\n";
		print "                  <INPUT value=\"BYPASS\" type=\"hidden\" name=\"x_method\"> \n";
		print "                  <INPUT value=\"$plan_unique_id\" type=\"hidden\" name=\"plan_unique_id\">\n";
		print "                  <TABLE border=\"0\" width=\"100%\" cellspacing=\"0\" cellpadding=\"3\">\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"3\" class=\"BlackTextMedium\">\n";
		print "                        You are only a few easy steps away from connecting with other $Map{'WHICH_CONNECTIONS'}.com members. Please choose your membership plan and get ready to get the most from your $Map{'WHICH_CONNECTIONS'}.com experience.\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD height=\"25\" colspan=\"3\" class=\"BG1Text1\">\n";
		print "                        <IMG src=\"/images/upgrade_step1.gif\" border=\"0\">\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD width=\"25%\" class=\"BlackTextMedium\">\n";
		print "                        <INPUT value=\"0\" type=\"hidden\" name=\"months_joined\">$membership_type_name\n";
		print "                      </TD>\n";
		print "                      <TD width=\"35%\" class=\"RedTextMedium\">\n";
		print "                      FREE\n";
		print "                      </TD>\n";
		print "                      <TD rowspan=\"1\" width=\"40%\" class=\"BlackTextMedium\">\n";
		print "                      Plan Name:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$membership_type_name</SPAN><BR><BR>\n";
		print "                      <SPAN class=\"BlackTextMedium\">$membership_description</SPAN><BR><BR>\n";
		print "		                 Expires:&nbsp;&nbsp;<SPAN class=\"RedTextMedium\">$date_promotion_ended</SPAN>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                    <TR>\n";
		print "                      <TD colspan=\"3\" class=\"AlignCenter\">\n";
		print "                        <FONT face=\"Arial, Helvetica, sans-serif\"> <INPUT name=\"CC_submit\" type=\"submit\" id=\"CC_submit\" value=\"&quot;I Authorize This Transaction&quot;\"></FONT>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                </FORM>\n";
	}
print "              </TD>\n";
print "            </TR>\n";
print "          </TABLE>\n";

&UtilityFunctions::Print_HTML_Bottom($ProgramName, $DebugUtilityFunctions, %Map);

print "<SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/GenAuthorizeNetFormCC.js\"></SCRIPT>\n";

#End BODY...
print "</BODY>\n";

#End HTML...
print "</HTML>\n";
exit 0;
