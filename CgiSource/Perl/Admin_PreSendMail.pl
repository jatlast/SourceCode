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
my $DebugCgiFunctions 	   = "1";
my $DebugDatabaseFunctions = "1";
my $DebugUtilityFunctions  = "1";

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

my $ProgramName  = "Admin_PreSendMail.cgi";

# declare global variables...
my $user_name 	 = "";
my $password 	 = "";
my $sql			 = "";

if(CGI::param('user_name'))   {$user_name 	 = CGI::param('user_name');}
if(CGI::param('password'))	  {$password 	 = CGI::param('password');}
if(CGI::param('sql'))	  	  {$sql 	 	 = CGI::param('sql');}

# Generate all dynamic HTML...
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

my $Temp	  	  = "";
my $Total	 	 = 0;
my $Count	 	 = 0;
	
print "Local Paramaters <!-- $Map{'WHICH_CONNECTIONS'}, $Map{'EMAIL'}, $Map{'ROOT'} -->\n";
print "Blat Paramaters <!-- $Map{'BLAT_PATH'}/EXE/blat.exe, $Map{'SMTP_HOST'}, $Map{'BLAT_PATH'}/LOG/blat.log -->\n";

my $SqlStatement = "$sql";
my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "$ProgramName");
$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
$status = $MSSQL::DBlib::dbh->dbsqlexec();
	
##########################
# Get FIRST result set...
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
						$Total = $$dataref{count};
							
						if($DebugThisAp eq "1")
							{
								print "<!-- total_found = ($Total) -->\n";
							}
					}
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "$ProgramName ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}

	
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
					$Count++;
						# Since there is no global DB error check get 
						# all database fields returned by the query...
							
						$UserName = $$dataref{user_name};
						# Remove trailing spaces from user_name...
						($UserName, $Temp) = split(/\s\s/, $UserName);
							
						$Password = $$dataref{password};
						# Remove trailing spaces from password...
						($Password, $Temp) = split(/\s\s/, $Password);
							
						$Sex = $$dataref{sex};
						# Remove trailing spaces from password...
						($Sex, $Temp) = split(/\s\s/, $Sex);
							
						$Email = $$dataref{email};
						# Remove trailing spaces from user_name...
						($Email, $Temp) = split(/\s\s/, $Email);
							
						$LastName = $$dataref{last_name};
						# Remove trailing spaces from password...
						($LastName, $Temp) = split(/\s\s/, $LastName);

						if($LastName eq " ")
							{
								$LastName = $UserName;
							}

						$StreetAddress = $$dataref{street_address};
						$City		   = $$dataref{city};
						$State		   = $$dataref{state};
						$Country	   = $$dataref{country};
						
						$Zip		   = $$dataref{zip};
						# Remove trailing spaces from user_name...
						($Zip, $Temp) = split(/\s\s/, $Zip);
						
						$Questionable  = $$dataref{questionable};
						$CreationDate  = $$dataref{creation_date};
						$LastLogin	   = $$dataref{last_login};
						 
						if($DebugThisAp eq "1")
							{
								print "($Count)<!-- $UserName|| $Password|| $Email|| $Sex|| $LastName|| $StreetAddress|| $City|| $State|| $Country|| $Zip|| $Questionable|| $CreationDate|| $LastLogin -->\n";
							}
					}
				print "<!-- returned_over_found " . $Count/$Total . " -->\n";
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "$ProgramName ERROR: $SqlStatement Failed for second result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}

#End HTML...
print "</HTML>\n";
exit 0;