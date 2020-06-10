#!/usr/local/bin/perl -w
use CGI qw/:standard/;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

use strict;

# Add directories to perl environment path...
unshift @INC, "D:\\Required\\INC\\";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "1";
my $DebugDatabaseFunctions = "1";
my $DebugUtilityFunctions  = "1";

# Set autoflush to true in order to force flushing upon each print...
#$| = 1;
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
		print "<!-- Unable to open LinkMap.dat -->\n";
#		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
	}
else
	{
		print "<!-- $Map{'CONFIG'} -->\n";
	}

my $ProgramName 	= "DB_Test.pl";

my $user_name  	 = "persianconnections";
my $password  	 = "";
my $SqlStatement  = "select password from login_info where user_name = '$user_name'";

# Begin Debugging...	
if($DebugThisAp eq "1")
	{
		print "<!-- DBUSER 		 = ($Map{'DBUSER'}) -->\n";
		print "<!-- DBPWD  	 	 = ($Map{'DBPWD'}) -->\n";
		print "<!-- DBNAME 		 = ($Map{'DBNAME'}) -->\n";
		print "<!-- user_name 	 = ($user_name) -->\n";
		print "<!-- SqlStatement = ($SqlStatement) -->\n";
	}

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
						# Since there is no global DB error get 
						# all database fields returned by the query...
						$password = $$dataref{password};
							
						if($DebugThisAp eq "1")
							{
								print "<!-- password = ($password) -->\n";
							}
					}
			}# END else (No db error) 
	}# END if($status != FAIL)
else
	{
		print "ERROR: $SqlStatement Failed for first result set!\n";
		$status = $MSSQL::DBlib::dbh->dbcancel();
	}
	
if($password ne "")
{
	print "SUCCESS:  We have DB connectivity!\n";
}
else
{
	print "FAILURE:  No DB connectivity!\n";	
}
	

#End HTML...
print "</HTML>\n";

exit 0;
