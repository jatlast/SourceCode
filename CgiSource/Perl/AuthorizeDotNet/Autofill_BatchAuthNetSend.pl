#!/usr/local/bin/perl -w

# For CGI functionality
use CGI qw/:standard/;
# For database access
use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;
# For Automated web access
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;

use strict;

# Add directories to perl environment path...
unshift @INC, "D:\\Required\\INC\\";

require "CgiFunctions.pl";
require "DatabaseFunctions.pl";
require "UtilityFunctions.pl";

my $ProgramName = "Admin_BatchAuthNetSend.pl";

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "1";
my $DebugDatabaseFunctions = "1";
my $DebugUtilityFunctions  = "1";

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, 1); 
 
# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		print "\n\nLinkMap Error.\n\n";
		exit -1;
	}

# Parse the current date...
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
# use parsed date to create unique name for transaction_id and SSLOG_FILE...
# Unique Name has the folling format username_m[m]_d[d]_yyyy_h[h]_m[m]_s[s]
my $UniqueID = "AutomatedTransactions_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
# use parsed date to create unique file name for SSLog file...
my $UniqueSSLogFile = "$Map{'LOG_FOLDER'}/"  . $UniqueID . ".html";

my $batch_transaction_id = $UniqueID;

# Create and open the file that this program will populate...
open (SSLOG_FILE, "> $UniqueSSLogFile") || die "Can't open $UniqueSSLogFile: $!\n";

print SSLOG_FILE "<HTML>\n";
my $ClockStart = localtime();
print SSLOG_FILE "Start: ($ClockStart)<BR><BR>\n";

print SSLOG_FILE "<!-- $Map{'CONFIG'} --><BR>\n" if $DebugThisAp eq "1";
print SSLOG_FILE "<!-- $Map{'SYSTEM'} --><BR>\n" if $DebugThisAp eq "1";

my $ua = new LWP::UserAgent;

if($Map{'SYSTEM'} eq 'DevCgi')
	{
	 	$ua->proxy('http', 'http://10.10.10.11:8080/');
		#$ua->no_proxy('secapl.com');
	}

my $months_joined  		= "";
my $name_on_card   	 	= "";
my $card_type 	   	 	= "";
my $account_number 	 	= "";
my $exp_month 	   	 	= "";
my $exp_year 	   	 	= "";
my $x_method	        = "";
my $bank_ABA_code		= "";
my $bank_account_number = "";
my $transaction_type	= "";

my $months_joined_text  = "";

my $Count_TotalDollarSuccess  = 0;
my $Count_TotalDollarError	  = 0;
my $Count_ProcessingAttempts  = 0;
my $Count_AlreadyPayingMember = 0;
my $Count_UsersCharged		  = 0;
my $Count_UsersNotCharged	  = 0;
my $Count_ProcessingErrors	  = 0;


my @MonthsJoinedArray	= ("1", "3", "12");
my @CardTypeArray		= ("4", "5");
my @AccountNumberArray	= ("1234567890123456", "4465611600688869", "4430710085062624", "5262191004808142", "5081810004808146");
my @ExpMontArray		= ("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
my @ExpYearArray		= ("2001", "2002", "2003", "2004", "2005", "2006");
my @XMethodArray		= ("CC", "ECHECK");
my @TransactionTypeArray= ("AUTH_CAPTURE", "CREDIT");


my $SqlStatement = "SELECT TOP 50 user_name, password FROM login_info";
#my $SqlStatement = "SELECT TOP 20 user_name, password FROM login_info where user_name = \'Aligolfi\'";

my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "$ProgramName");
$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
$status = $MSSQL::DBlib::dbh->dbsqlexec();
	
##########################
# Get result set...
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
							
						my $user_name = $$dataref{user_name};
						$user_name =~ s/\s//g;
							
						my $password  = $$dataref{password};
						$password =~ s/\s//g;
							
						#Randomly Populate the fields for testing...
						$months_joined	  = $MonthsJoinedArray    [int(rand( 3))];
						$transaction_type = $TransactionTypeArray [int(rand( 2))];
						$x_method		  = $XMethodArray	      [int(rand( 2))];

						if($x_method eq "CC")
							{
        						$name_on_card	= "$user_name $password";
        						$card_type		= $CardTypeArray	 [int(rand( 2))];
        						$account_number	= $AccountNumberArray[int(rand( 5))];
        						$exp_month		= $ExpMontArray		 [int(rand(12))];
        						$exp_year		= $ExpYearArray		 [int(rand( 6))];
							}
						else
							{
                                $bank_ABA_code		 = "6010";
                                $bank_account_number = "8017671392";
							}
							
						#Determine the months joined dollar amount text..
						if($months_joined eq "1")
							{
								$months_joined_text = "9.99";		
							}
						elsif($months_joined eq "3")
							{
								$months_joined_text = "24.99";		
							}
						elsif($months_joined eq "12")
							{
								$months_joined_text = "49.99";		
							}
						if($DebugThisAp eq "1")
							{
								print "<!-- user_name = ($user_name) -->\n";
#								print "<!-- password  = ($password) -->\n";
							}
							
						my $AuthorizeNetSendSSLURL	= "$Map{'ROOT'}/cgi-bin/AuthorizeNetSendSSL.cgi?months_joined=$months_joined&name_on_card=$name_on_card&card_type=$card_type&account_number=$account_number&exp_month=$exp_month&exp_year=$exp_year&batch_transaction_id=$batch_transaction_id&x_method=$x_method&bank_ABA_code=$bank_ABA_code&bank_account_number=$bank_account_number&transaction_type=$transaction_type";
						my $request = new HTTP::Request('GET', $AuthorizeNetSendSSLURL);
						$request->header('Cookie' => "cookie_name=$user_name; cookie_password=$password");
						my $response = $ua->request($request);
						# URL...
						print SSLOG_FILE "<HR><BR><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">$AuthorizeNetSendSSLURL</FONT><BR>\n";
						if ($response->is_success) 
							{
        						my $TempResponseContent = $response->content;
								# Response HTML...
        						if ($response->content =~ m/thank you for becomming/) 
        							{
        								# SUCCESS Processed OK...
        								print SSLOG_FILE "<BR><STRONG>SUCCESS: credit card was charged \$$months_joined_text for user name (<FONT size=\"3\" color=\"#6666FF\">$user_name</FONT>).</STRONG><BR>\n";
        								$Count_TotalDollarSuccess += $months_joined_text;
        								$Count_UsersCharged++;
        							}
        						elsif ($TempResponseContent =~ m/Error Message:/) 
        							{
									  	$TempResponseContent =~ m%<FONT face="Arial, Helvetica, sans-serif" size="2"><FONT color="#FF0033">(.*)</FONT></FONT>%;
										print SSLOG_FILE "<BR><STRONG><FONT size=\"3\" color=\"#FF0033\">ERROR</FONT>: Unable to process credit card for user name (<FONT size=\"3\" color=\"#6666FF\">$user_name</FONT>).</STRONG><BR>\n";
										print SSLOG_FILE "<BR><STRONG>Error Message: <FONT size=\"3\" color=\"#FF0033\"> $1</FONT></STRONG><BR>\n";
        								$Count_ProcessingErrors++;
        								$Count_TotalDollarError += $months_joined_text;
        								$Count_UsersNotCharged++;
        							}
        						elsif ($TempResponseContent =~ m/already a paying member/) 
        							{
										print SSLOG_FILE "<BR><STRONG><FONT size=\"3\" color=\"#FF0033\">ERROR</FONT>: Unable to process credit card for user name (<FONT size=\"3\" color=\"#6666FF\">$user_name</FONT>).</STRONG><BR>\n";
										print SSLOG_FILE "<BR><STRONG><FONT size=\"3\" color=\"#6666FF\">Already a Paying Member</FONT></STRONG><BR>\n";
        								$Count_TotalDollarError += $months_joined_text;
        								$Count_AlreadyPayingMember++;
        								$Count_UsersNotCharged++;
        							}
        						else
        							{
        							 	print SSLOG_FILE $response->content;
        								$Count_TotalDollarError += $months_joined_text;
        								$Count_UsersNotCharged++;
        							}
							} 
						else 
							{
								# ERROR Unable to process...
								print SSLOG_FILE "<BR><STRONG><FONT size=\"3\" color=\"#FF0033\">ERROR</FONT>: Unable to process credit card for user name (<FONT size=\"3\" color=\"#6666FF\">$user_name</FONT>).</STRONG><BR>\n";
							 	print SSLOG_FILE $response->content;
   								$Count_TotalDollarError += $months_joined_text;
								$Count_UsersNotCharged++;
							}
						$Count_ProcessingAttempts++;					
						print SSLOG_FILE "<BR>---------------------------------------- # $Count_ProcessingAttempts ----------------------------------------<BR>\n";							
					}
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "ERROR: $SqlStatement Failed for first result set!\n";
		print SSLOG_FILE "ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}

my $ClockEnd = localtime();
print SSLOG_FILE "Total Attempts    : ($Count_ProcessingAttempts) Total Amount (\$" . ($Count_TotalDollarSuccess + $Count_TotalDollarError) . ")<BR>\n";
print SSLOG_FILE "Total Success     : ($Count_UsersCharged)  Total Charged (\$$Count_TotalDollarSuccess)<BR>\n";
print SSLOG_FILE "Total Error       : ($Count_UsersNotCharged)  Total Not Charged (\$$Count_TotalDollarError)<BR>\n";
print SSLOG_FILE "Processing Errors : ($Count_ProcessingErrors)<BR>\n";
print SSLOG_FILE "Already A Member  : ($Count_AlreadyPayingMember)<BR>\n";

print SSLOG_FILE "End: ($ClockEnd)<BR>\n";
#print SSLOG_FILE "Duration: ($ClockStart - $ClockEnd)\n";
print SSLOG_FILE "</HTML>\n";
close(SSLOG_FILE);

