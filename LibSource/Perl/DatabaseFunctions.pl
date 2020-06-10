#    DatabaseFunctions.pl
#    created on 12-17-2000
#    Author: Jason Baumbach

#        This file contains subroutines for executing MSSQL Database calls
#        Each subroutine can take 2 arguments and executes the passed in SQL statement.
#		 If the second argument = "1" debugging is "ON"

#        Example Code:
#        $ReturnValue = &Run_This_Sql_Statement ("someProcName \'value1\', \'value2\'", "1");
#		 Returns the status of $MSSQL::DBlib::dbh->dbsqlexec;

# 		 http://www.algonet.se/~sommar/mssql/docs/mssql-dblib.html


package DatabaseFunctions;

use MSSQL::DBlib;
use MSSQL::DBlib::Const::General;
use MSSQL::DBlib::Const::Datatypes;

# Indicates the state of the sub that ran last.
$DatabaseError = "0";
# The debug switch set by the caller to each sub.
$DatabaseDebug = "0";


#        dberrhandle 
#
#            $old_handler = dberrhandle($err_handler)
#        
#        Installs an error handler and returns the previously installed handler. 
#		 This handler is called when an error occurs in DB-Library itself. 
#		 To handle errors from SQL Server, see dbmsghandle. 
#        
#        $err_handler should be a reference to a Perl sub, or a string 
#		 containing the name of a Perl sub. In the latter case, specify the 
#		 name with the package component, for instance main::my_error_handler. 
#		 If you specify an unqualified name, and warnings are activated, 
#		 dberrhandle will print a warning. Unqualified name are deceivable, 
#		 and does for instance not work when you are using the debugger. 
#        
#        Pass undef to only uninstall the current handler. 
#        
#        NOTE: MSSQL::DBlib provides a built-in default error handler which 
#		 applies if you have not called dberrhandle or uninstalled your own 
#		 handler by passing undef. 
#        
#        The error handler you specify should take six parameters: 
#        
#        $dbproc: This is a reference to a hash. The reference may or may not 
#		 be blessed. When $dbproc is blessed, it is the handle you used for 
#		 calling the routine that caused the error. When unblessed it is just a 
#		 temporary handle, containing nothing but a DBPROCESS reference. Thus, 
#		 if you want to retrieve any of the handle attributes, you first need 
#		 to examine ref $dbproc. Don't attempt to call any DB-Library routines 
#		 from the error handler, as they may lead to futher errors with new 
#		 calls to the error handler and... 
#        
#        $severity: the severity level of the error. Constants for DB-Library 
#		 severities are declared in MSSQL::DBlib::Const::Severity. 
#        
#        $dberr: a number identifying the error. Constants for DB-Library 
#		 errors are declared in MSSQL::DBlib::Const::Errors. 
#        
#        $oserr: a number identifying any error from the OS or network level 
#		 that may have occurred. When there is no such error, $oserr is DBNOERR, 
#		 which is declared in MSSQL::DBlib::Const::General. 
#        
#        $dberrstr: a string describing the DB-Library error. 
#        
#        $oserr: a string describing any OS or network error. 
#
#		 The error handler should return any of the values 
#		 INT_EXIT  	   (causes DB-Library to exit and return an error status to the OS), 
#		 INT_CANCEL	   (causes the current DB-Library call to return FAIL)
#		 INT_CONTINUE  (is only meaningful for timeout errors). 
#		 These constants are declared in MSSQL::DBlib::Const::General. 

# Taken from sybutil.pl 
sub error_handler {
#	print STDOUT ("<!-- Start error_handler DatabaseError: $DatabaseError -->", "\n");			
#	print STDOUT "\n<!-- Within error_handler\n";
    my ($db, $severity, $error, $os_error, $error_msg, $os_error_msg) = @_;
    # Check the error code to see if we should report this.
#    if ($error != 10007) 
    if ($error != SQLESMSG) 
	{
	print STDOUT ("<!-- Sybase error: ", $error_msg, "-->\n");
	print STDOUT ("<!-- OS Error: ", $os_error_msg, "-->\n") if defined ($os_error_msg);
	$DatabaseError = "1";
    }
#	print STDOUT "-->\n\n";
#    2;
    INT_CANCEL;
}

#    dbmsghandle 
#
#        $old_handler = dbmsghandle($msg_handler)
#    
#    Installs a message handler to take care of messages from SQL Server and 
#	 returns the old handler. These messages can arise from server errors, 
#	 RAISERROR or PRINT statements or be output caused by SET SHOWPLAN or SET 
#	 STATISTICS. 
#    
#    $msg_handler should be a reference to a Perl sub, or a string containing 
#	 the name of a Perl sub. In the latter case, specify the name with the 
#	 package component, for instance main::my_message_handler. If you specify 
#	 an unqualified name, and warnings are activated, dberrhandle will print a 
#	 warning. Unqualified name are deceivable, and does for instance not work 
#	 when you are running the debugger. 
#    
#    Pass undef to uninstall the current handler. 
#    
#    NOTE: MSSQL::DBlib provides a built-in default message handler which 
#	 applies if you have not called dbmsghandle or uninstalled your own handler 
#	 by passing undef. 
#    
#    The message handler you specify should take eight parameters: 
#    
#    $dbproc: This is a reference to a hash. The reference may or may not be 
#	 blessed. When $dbproc is blessed, it is the handle you used to call the 
#	 routine that caused the error. When unblessed it is just a temporary handle, 
#	 containing nothing but a DBPROCESS reference. Thus, if you want to retrieve 
#	 any of the handle attributes, you first need to examine ref $dbproc. Only 
#	 when $dbproc is blessed you can call other MSSQL::DBlib routines, however 
#	 you should be very restrictive with this, as stated in the DB-Library 
#	 documentation. 
#    
#    $msgno: the error number from SQL Server. 0 when the message comes from a 
#	 PRINT statement in Transact-SQL. 
#    
#    $msgstate: the state associated with the SQL Server message. 
#    
#    $severity: the severity level of the message. See the SQL Server 
#	 documentation for details. 
#    
#    $msgtext: the text of the message from SQL Server. 
#    
#    $server: the name of the server that sent the message. 
#    
#    $procname: the name of the stored procedure that generated the message. 
#	 undef if there was no procedure involved. 
#    
#    $line: the line number in the stored procedure or batch where the message 
#	 was generated. 
#    
#    The message handler should return 0.

# Taken from sybutil.pl 
sub message_handler
	{
		my ($db, $message, $state, $severity, $text, $server, $procedure, $line) = @_;
#		print STDOUT ("<!-- Start message_handler DatabaseError: $DatabaseError -->", "\n");			
		# Don't display 'informational' messages:
		if ($severity > 10 || $DatabaseDebug eq "1") 
			{
#				print STDOUT "\n<!-- Within message_handler\n";
				
				print STDOUT ("<!-- Sybase message ", $message, ", Severity ", $severity, ", state ", $state, "-->");
				print STDOUT ("\n<!--Server `", $server, "'-->") if defined ($server);
				print STDOUT ("\n<!--Procedure `", $procedure, "'-->") if defined ($procedure);
				print STDOUT ("\n<!--Line ", $line, "-->") if defined ($line);
				print STDOUT ("\n<!--    ", $text, "-->\n\n");
					
				# &dbstrcpy returns the command buffer.
					
				if(defined($db))
					{
						my ($lineno, $cmdbuff) = (1, undef);
						my $row;
							
						$cmdbuff = &MSSQL::DBlib::dbstrcpy($db);

						 if($cmdbuff)
							{
							foreach $row (split (/\n/, $cmdbuff))
								{
									print STDOUT (sprintf ("<!-- %5d", $lineno ++), "> ", $row, "-->\n");
								}
							}
					}
				if($severity > 10) 
					{
						$DatabaseError = "1"
					}
				else
					{
						# check if the user_name and password match..
						if($text =~ m/unique_id and password did not match/)
							{
								$DatabaseError = "1000";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name and password match..
						elsif($text =~ m/user_name and password did not match/)
							{
								$DatabaseError = "1001";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is unique..
						elsif($text =~ m/user_name is not unique/)
							{
								$DatabaseError = "1002";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission to send mail..
						elsif($text =~ m/membership_type does not permit mail/)
							{
								$DatabaseError = "1003";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the email is unique in the mailing_list table..
						elsif($text =~ m/email is not unique in mailing_list/)
							{
								$DatabaseError = "1004";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is missing from any of the required tables
						# during a delete from Admin_DeleteUser.cgi..
						elsif($text =~ m/user_name does not exist/)
							{
								$DatabaseError = "1005";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is already a paying member..
						elsif($text =~ m/ERROR:  User is already a paying member/)
							{
								$DatabaseError = "1006";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is currently a paying member..
						elsif($text =~ m/ERROR:  User is not currently a paying member/)
							{
								$DatabaseError = "1007";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission..
						elsif($text =~ m/You must upgrade your membership/)
							{
								$DatabaseError = "1008";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the email is unique in the mailing_list table..
						elsif($text =~ m/email does not exist in mailing_list/)
							{
								$DatabaseError = "1009";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the the valid field could be updated in mailing_list table..
						elsif($text =~ m/Unable to update/)
							{
								$DatabaseError = "1010";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the the x_customer_IP field exists in the restricted_IP table..
						elsif($text =~ m/ERROR:  Restricted IP address/)
							{
								$DatabaseError = "1011";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the the email address has been verified..
						elsif($text =~ m/email address has not been verified/)
							{
								$DatabaseError = "1012";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for log file errors
						elsif($text =~ m/The log file for database/)
							{
								$DatabaseError = "1013";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Advertiser User Creation Error
						elsif($text =~ m/host unique_id does not exist/)
							{
								$DatabaseError = "1014";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Advertiser User Creation Error
						elsif($text =~ m/email is not unique/)
							{
								$DatabaseError = "1015";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for ROLLBACK Error
						elsif($text =~ m/ROLLBACK/)
							{
								$DatabaseError = "1016";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for minimum impressions error...
						elsif($text =~ m/ERROR: Impressions selected for purchase does not meet the minimum/)
							{
								$DatabaseError = "1017";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for attempts to edit active campaings...
						elsif($text =~ m/ERROR: Active campaigns cannot be edited/)
							{
								$DatabaseError = "1018";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Max CPC errors...
						elsif($text =~ m/ERROR: Maximum CPC selected does not meet the minimum CPC requirement/)
							{
								$DatabaseError = "1019";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Conversion errors...
						elsif($text =~ m/ERROR: Character value entered where numeric value required/)
							{
								$DatabaseError = "1020";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for ProcessAdClick errors...
						elsif($text =~ m/unable to process click/)
							{
								$DatabaseError = "1021";
								# Printing interrupts process.  DO NOT PRINT
#								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: access denied/)
							{
								$DatabaseError = "1022";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: incorrect email or password/)
							{
								$DatabaseError = "1023";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: an affiliate program already exists/)
							{
								$DatabaseError = "1024";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for general ERROR message
						elsif($text =~ m/ERROR:/)
							{
								$DatabaseError = "1025";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission..
						elsif($text =~ m/You must upload a photo to use this feature/)
							{
								$DatabaseError = "1026";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						else
							{
								$DatabaseError = "0";														
								#print STDOUT ("<!----- Reset DatabaseError: $DatabaseError ----->", "\n");
							}
						}				
							
#						print STDOUT "-->\n\n";
					}
				elsif ($message == 0)
					{
#						print STDOUT "\n<!-- Within message_handler looking for Error Messages\n";
						# check if the user_name and password match..
						# check if the user_name and password match..
						if($text =~ m/unique_id and password did not match/)
							{
								$DatabaseError = "1000";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name and password match..
						elsif($text =~ m/user_name and password did not match/)
							{
								$DatabaseError = "1001";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is unique..
						elsif($text =~ m/user_name is not unique/)
							{
								$DatabaseError = "1002";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission to send mail..
						elsif($text =~ m/membership_type does not permit mail/)
							{
								$DatabaseError = "1003";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the email is unique in the mailing_list table..
						elsif($text =~ m/email is not unique in mailing_list/)
							{
								$DatabaseError = "1004";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is missing from any of the required tables
						# during a delete from Admin_DeleteUser.cgi..
						elsif($text =~ m/user_name does not exist/)
							{
								$DatabaseError = "1005";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is already a paying member..
						elsif($text =~ m/ERROR:  User is already a paying member/)
							{
								$DatabaseError = "1006";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name is currently a paying member..
						elsif($text =~ m/ERROR:  User is not currently a paying member/)
							{
								$DatabaseError = "1007";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission..
						elsif($text =~ m/You must upgrade your membership/)
							{
								$DatabaseError = "1008";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the the email address has been verified..
						elsif($text =~ m/email address has not been verified/)
							{
								$DatabaseError = "1012";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for log file errors
						elsif($text =~ m/The log file for database/)
							{
								$DatabaseError = "1013";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Advertiser User Creation Error
						elsif($text =~ m/host unique_id does not exist/)
							{
								$DatabaseError = "1014";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Advertiser User Creation Error
						elsif($text =~ m/email is not unique/)
							{
								$DatabaseError = "1015";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for ROLLBACK Error
						elsif($text =~ m/ROLLBACK/)
							{
								$DatabaseError = "1016";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for minimum impressions error...
						elsif($text =~ m/ERROR: Impressions selected for purchase does not meet the minimum/)
							{
								$DatabaseError = "1017";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for attempts to edit active campaings...
						elsif($text =~ m/ERROR: Active campaigns cannot be edited/)
							{
								$DatabaseError = "1018";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Max CPC errors...
						elsif($text =~ m/ERROR: Maximum CPC selected does not meet the minimum CPC requirement/)
							{
								$DatabaseError = "1019";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Conversion errors...
						elsif($text =~ m/ERROR: Character value entered where numeric value required/)
							{
								$DatabaseError = "1020";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for ProcessAdClick errors...
						elsif($text =~ m/unable to process click/)
							{
								$DatabaseError = "1021";
								# Printing interrupts process.  DO NOT PRINT
#								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: access denied/)
							{
								$DatabaseError = "1022";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: incorrect email or password/)
							{
								$DatabaseError = "1023";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for Affiliate Stored Procedure errors...
						elsif($text =~ m/ERROR: an affiliate program already exists/)
							{
								$DatabaseError = "1024";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check for general ERROR message
						elsif($text =~ m/ERROR:/)
							{
								$DatabaseError = "1025";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						# check if the user_name has permission..
						elsif($text =~ m/You must upload a photo to use this feature/)
							{
								$DatabaseError = "1026";
								print STDOUT ("<!----- Cought Error: $text ----->", "\n");
							}
						else
							{
								$DatabaseError = "0";														
								#print STDOUT ("<!----- Reset DatabaseError: $DatabaseError ----->", "\n");
							}
#						print STDOUT "-->\n\n";
					}
				return 0;
			}

#  &Get_Email_By_UserName ()
#  This subroutine calls the sql procedure getEmailByUserName which
#  gets the user's current email address from the login_info table.
sub Get_Email_By_UserName()
	{
		(my $db_user, my $db_password, my $db_database, my $db_apname, my $UserName, my $Debug) = @_;	
			
		# Reset DatabaseError...	
		$DatabaseError = "0";
		my $SqlStatement = "getEmailByUserName \"$UserName\"";
		$DatabaseDebug = $Debug;
		#		my $dataref;
		 
		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		$status = $MSSQL::DBlib::dbh->dbresults();
			
		if($status == 1)
			{
					# Get results...
#				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) == -2) 
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) == NO_MORE_ROWS) 
					{
						print "email = $$dataref{email}\n" if $Debug eq "1";
					}
				# If in debug mode, print information...
				if($Debug == 1)
					{
						print "<!-- SQL: $SqlStatement -->\n";
					}
				# Check for global DB error...
				if($DatabaseError ne "0")
					{
						print "<!-- ERROR: Get_Email_By_UserName(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
						return "-1";				
					}
				else
				{
				# Since there is no global DB error check if email address is valid
				if($$dataref{email} =~ m/test\@email.com/ || $$dataref{email} eq "")
					{
						return "-2";
					}
				else
					{
						return $$dataref{email};
					}
			}
	}
else
	{
		print "<!-- ERROR: Get_Email_By_UserName(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
		return "-1";				
	}
}
		
#  &Get_Host_Settings ()
#  This subroutine calls the sql procedure adv_GetHostSettings which
#  gets the advertiser's host settings
sub Get_Host_Settings
	{
		(my $db_user, my $db_password, my $db_database, my $db_apname, my $UniqueId, my $Debug) = @_;	
		my %ReturnHash;

		# Reset DatabaseError...	
		$DatabaseError = "0";
		my $SqlStatement = "adv_GetHostSettings \'$UniqueId\'";
		$DatabaseDebug = $Debug;
		#		my $dataref;
		 
		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		$status = $MSSQL::DBlib::dbh->dbresults();
			
		if($status == 1)
			{
					# Get results...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
					{
						$ReturnHash{'host_unique_id'}	= $$dataref{advertiser_unique_id};
						$ReturnHash{'site_name'}		= $$dataref{site_name};
						$ReturnHash{'email'}			= $$dataref{email};
						$ReturnHash{'site_url'}			= $$dataref{site_url};
						$ReturnHash{'logo_url'}			= $$dataref{logo_url};
						$ReturnHash{'logo_width'}		= $$dataref{logo_width};
						$ReturnHash{'logo_height'}		= $$dataref{logo_height};
						$ReturnHash{'advertiser_type'}	= $$dataref{advertiser_type};
					}
				# If in debug mode, print information...
				if($Debug eq "1")
					{
						print "<!-- SQL: $SqlStatement -->\n";
						print "<!-- host_unique_id       = ($ReturnHash{'host_unique_id'}) -->\n";
						print "<!-- site_name            = ($ReturnHash{'site_name'}) -->\n";
						print "<!-- email                = ($ReturnHash{'email'}) -->\n";
						print "<!-- site_url             = ($ReturnHash{'site_url'}) -->\n";
						print "<!-- logo_url             = ($ReturnHash{'logo_url'}) -->\n";
						print "<!-- logo_width           = ($ReturnHash{'logo_width'}) -->\n";
						print "<!-- logo_height          = ($ReturnHash{'logo_height'}) -->\n";
						print "<!-- advertiser_type      = ($ReturnHash{'advertiser_type'}) -->\n";
					}
				# Check for global DB error...
				if($DatabaseError ne "0")
					{
						print "<!-- ERROR: Get_Host_Settings(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
						$ReturnHash{'status'} = "ERROR";
						return %ReturnHash;				
					}
				else
					{
						$ReturnHash{'status'} = "SUCCESS";
						return %ReturnHash;				
					}
			}
		else
			{
				print "<!-- ERROR: Get_Host_Settings(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
				$ReturnHash{'status'} = "ERROR";
				return %ReturnHash;				
			}
}
		
#  &Get_Current_DB_Name ()
#  This subroutine calls the sql procedure getEmailByUserNamePassword which
#  gets the user's current email address from the login_info table.
sub Get_Current_DB_Name()
	{
		(my $db_user, my $db_password, my $db_database, my $db_apname, my $Debug) = @_;	
			
		print "<!-- DEBUG: Get_Current_DB_Name($db_user, $db_password, $db_database, $db_apname, $Debug) -->\n" if $Debug eq "1";
		# Reset DatabaseError...	
		$DatabaseError = "0";
		my $SqlStatement = "SELECT DB_NAME()";
		$DatabaseDebug = $Debug;
	 
		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		$status = $MSSQL::DBlib::dbh->dbresults();
			
		if($status == 1)
			{
				# Get results...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 0) == NO_MORE_ROWS) 
					{
						print "db_name = $$dataref[0]\n" if $Debug eq 1;
					}
				# If in debug mode, print information...
				if($Debug == 1)
					{
						print "<!-- SQL: $SqlStatement -->\n";
					}
				# Check for global DB error...
				if($DatabaseError ne "0")
					{
						print "<!-- ERROR: Get_Current_DB_Name(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
						return "-1";				
					}
				else
				{
				# Since there is no global DB error check if email address is valid
				if($dataref eq "")
					{
						return "-2";
					}
				else
					{
						return $$dataref[0];
					}
			}
	}
else
	{
		print "<!-- ERROR: Get_Current_DB_Name(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
		return "-1";				
	}
}
		
				
#  &Get_Advertiser_Type ("adv_cookie_user_id", "adv_cookie_user_password", "1")
#  This subroutine retreives the advertiser_type from the advertiser_login_info table...
sub Get_Advertiser_Type()
	{
		(my $db_user, my $db_password, my $db_database, my $db_apname, my $UserId, my $Password, my $Debug) = @_;	

		# Reset DatabaseError...	
		$DatabaseError = "0";
		my $advertiser_type = '-1';
		my $SqlStatement = "adv_GetAdvertiserType \'$UserId\', \'$Password\'";
		$DatabaseDebug = $Debug;

		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		$status = $MSSQL::DBlib::dbh->dbresults();
			
		if($status == 1)
			{
				# Get results...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
					{
						$advertiser_type = $$dataref{advertiser_type};
					}
				# If in debug mode, print information...
				if($Debug eq "1")
					{
						print "<!-- SQL: $SqlStatement -->\n";
						print "<!-- advertiser_type = ($advertiser_type) -->\n";
					}
				# Check for global DB error...
				if($DatabaseError ne "0")
					{
						print "<!-- ERROR: Get_Advertiser_Type(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
						return $advertiser_type;				
					}
				else
					{
						return $advertiser_type;				
					}
			}
		else
			{
				print "<!-- ERROR: Get_Advertiser_Type(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
				return $advertiser_type;				
			}
	} # Get_Advertiser_Type
		
				
#  &Get_Host_Default_Advertiser ("adv_cookie_user_id", "adv_cookie_user_password", "1")
#  This subroutine retreives the Host Default Advertiser from the advertiser_login_info table...
sub Get_Host_Default_Advertiser()
	{
		(my $db_user, my $db_password, my $db_database, my $db_apname, my $UserId, my $Password, my $Debug) = @_;	
		my %ReturnHash;

		# Reset DatabaseError...	
		$DatabaseError = "0";
		my $SqlStatement = "adv_GetHostDefaultAdvertiser \'$UserId\', \'$Password\'";
		$DatabaseDebug = $Debug;

		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec();
		$status = $MSSQL::DBlib::dbh->dbresults();
			
		if($status == 1)
			{
				# Get results...
				while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
					{
						$ReturnHash{'host_default_advertiser_id'}		= $$dataref{unique_id};
						$ReturnHash{'host_default_advertiser_password'}	= $$dataref{password};
					}
				# If in debug mode, print information...
				if($Debug eq "1")
					{
						print "<!-- SQL: $SqlStatement -->\n";
						print "<!-- host_default_advertiser_id       = ($ReturnHash{'host_default_advertiser_id'}) -->\n";
						print "<!-- host_default_advertiser_password = ($ReturnHash{'host_default_advertiser_password'}) -->\n";
					}
				# Check for global DB error...
				if($DatabaseError ne "0")
					{
						print "<!-- ERROR: Get_Host_Default_Advertiser(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
						$ReturnHash{'status'} = "ERROR";
						return %ReturnHash;				
					}
				else
					{
						$ReturnHash{'status'} = "SUCCESS";
						return %ReturnHash;				
					}
			}
		else
			{
				print "<!-- ERROR: Get_Host_Default_Advertiser(\"$SqlStatement\") Failed! -->\n" if $Debug eq "1";
				$ReturnHash{'status'} = "ERROR";
				return %ReturnHash;				
			}
	} # Get_Host_Default_Advertiser
		
				
				
#  &Run_This_Sql_Statement ("someProcName \'value1\', \'value2\'", "1")
#  This subroutine calls the sql procedure automatedFixLoginInfo which
#  sets the sex field equal to $Sex in the login_info table for the given $UserName
sub Run_This_Sql_Statement(\$,\$)
	{
		(my $db_user, my $db_password, $db_database, my $db_apname, my $SqlStatement, my $Debug) = @_;	
		 
		# Reset DatabaseError...	
		$DatabaseError = "0";

		$DatabaseDebug = $Debug;
		 
		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
		$status = $MSSQL::DBlib::dbh->dbsqlexec;
		
		if($status == 1 and $DatabaseError eq "0")
			{
				print "<!-- SQL: $SqlStatement -->\n" if $Debug eq "1";
				return $status;
			}
		else
			{
				print "<!-- ERROR: Run_This_Sql_Statement($SqlStatement) Failed! DatabaseError ($DatabaseError)-->\n" if $Debug eq "1";
				return "-1";
			}
	}

	
# this sub is not at all done...
sub Remove_Special_Characters(\$)
	{
		(my $temp, my $Debug) = @_;	
		my $new_value = $temp;
		
		$new_value =~ s|'|\'\'|g;				
		$new_value =~ s|'|\'\'|g;				
		$new_value =~ s|'|\'\'|g;				
		$new_value =~ s|'|\'\'|g;				
		$new_value =~ s|'|\'\'|g;				
		$new_value =~ s|'|\'\'|g;				
		
		print "<!-- Remove_Special_Characters(\"$temp\") returned \"$new_value\" -->\n" if $Debug eq "1";
			
		return $new_value;
	}

	
sub Print_Run_This_Sql_Statement
{
print "------------- Print out of Run_This_Sql_Statement sub -------------------------\n";
print "\n";
print "#  \&Run_This_Sql_Statement (\"someProcName \\'value1\\', \\'value2\\'\", 1)\n";
print "#  This subroutine calls the sql procedure automatedFixLoginInfo which\n";
print "#  sets the sex field equal to \$Sex in the login_info table for the given $UserName\n";
print "sub Run_This_Sql_Statement(\\\$,\\\$)\n";
print "	{\n";
print "		(my \$SqlStatement, my \$Debug) = \@_;\n";	
print "		 \n";
print "		my $status = \$MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin(\$user, \$passwd, \$database, \'DBTest.cgi\');\n";
print "		\$status = \$MSSQL::DBlib::dbh->dbcmd(\$SqlStatement);\n";
print "		\$status = \$MSSQL::DBlib::dbh->dbsqlexec;\n";
print "		\n";
print "		if(\$status == 1)\n";
print "			{\n";
print "				if(\$Debug == 1)\n";
print "					{\n";
print "						print \"<!-- SQL: \$SqlStatement -->\\n\";\n";
print "					}\n";
print "			}\n";
print "		else\n";
print "			{\n";
print "				print \"ERROR: Run_This_Sql_Statement(\\\"\$SqlStatement\\\") Failed!\\n\";\n";
print "			}\n";
print "		return \$status;\n";		
print "	}\n";
print "\n";
print "----------------------------------------------------------------------------------\n";
}

sub Print_Example_Run_This_Sql_Statement
{
print "------------- Print out of Run_This_Sql_Statement Example -------------------------\n";
print "\n";
print "my \$SqlStatement = \"someStoredProc \\'Joe\\', \\'pwd\\'\";\n";
print "my \$returnValue = \&Run_This_Sql_Statement(\$SqlStatement, 0);\n";
print "if(\$returnValue == 1)\n";
print "	{\n";
print "		print \"SUCCESS!\\n\";\n";
print "	}\n";
print "else\n";
print "	{\n";
print "		print \"ERROR!\\n\";\n";
print "	}\n";
print "\n";
print "----------------------------------------------------------------------------------\n";
}

#  &automatedFixLoginInfo ("UserName", "Sex")
#  This subroutine calls the sql procedure automatedFixLoginInfo which
#  sets the sex field equal to $Sex in the login_info table for the given $UserName
sub automatedFixLoginInfo(\$,\$)
	{
	print "Within: automatedFixLoginInfo\n";
		(my $db_user, my $db_password, $db_database, my $db_apname, my $UserName, my $Sex) = @_;	
        
		# Reset DatabaseError...	
		$DatabaseError = "0";

        my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
        $status = $MSSQL::DBlib::dbh->dbcmd("automatedFixLoginInfo \'$UserName\', \'$Sex\'");
        $status = $MSSQL::DBlib::dbh->dbsqlexec;
        
        print "<!-- SQL: automatedFixLoginInfo \'$UserName\', \'$Sex\' -->\n";
		if($status == 1)
			{
				print "$UserName ---------- login_info table\n";
				$AddedCount++;
			}
		else
			{
				print "ERROR: could not update login_info for $UserName\n";
				print "ERROR: could not update login_info for $UserName\n";
			}
	}


sub updatePictue
	{
		(my $db_user, my $db_password, $db_database, my $db_apname, my $name_user, my $password, my $picture_number, my $picture_name) = @_;
			
		# Reset DatabaseError...	
		$DatabaseError = "0";

		my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($db_user, $db_password, $db_database, $db_apname);
		$status = $MSSQL::DBlib::dbh->dbcmd("updatePicture \"$name_user\", \"$password\", \"1\", \"$picture_name\"");
		$status = $MSSQL::DBlib::dbh->dbsqlexec;
			
#		print "<!-- SQL: updatePicture \"$name_user\", \"$password\", \"$picture_number\", \"$picture_name\" -->\n";
			
		return $status;
	}


sub Print_Lookup_Table
{
	(my $TableName, my $DislayText, my $CommaSeperatedList, my $Multiple, my $MultipleNumber, my $Debug, my %Map) = @_;

	my $choice = "";
	my $value  = "";
	my @SplitArray;
	my $index = 0;
	my $ArraySize = 0;

	if($CommaSeperatedList =~ m/,/g)
		{
			(@SplitArray) = split (/,/, $CommaSeperatedList );
		}
	else
		{
			push(@SplitArray, $CommaSeperatedList);
		}

	$ArraySize = scalar $#SplitArray + 1;

	print "<!-- CommaSeperatedList = ($CommaSeperatedList) -->\n" if $Debug eq '1';
	print "<!-- SplitArray         = (@SplitArray) -->\n" if $Debug eq '1';
	print "<!-- ArraySize          = ($ArraySize) -->\n" if $Debug eq '1';


	my $SqlStatement = "SELECT * FROM $TableName ORDER BY value ASC";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL)
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $Debug eq '1';
			print "              <!--  $TableName -->\n";
			print "              <TR>\n";
			print "                <TD width=\"181\" height=\"22\" align=\"right\">\n";
			print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">$DislayText</FONT>\n";
			print "                </TD>\n";
			print "                <TD width=\"371\" height=\"22\" align=\"left\">\n";
			print "                  <SELECT $Multiple size=\"$MultipleNumber\" name=\"$TableName\">\n";
			# Prevent infinite loop...
			while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
				{
					# Since there is no global DB error check get 
					# all database fields returned by the query...
					
					$choice	= $$dataref{choice};
					$value	= $$dataref{value};
					$value =~ s/\s//g;

					$index = 0;
					my $found = 0;
					while($index < $ArraySize)
					{
						$SplitArray[$index] =~ s/^\s//g;
						if ($SplitArray[$index++] eq $value) 
							{
								$found = 1;
							}
					}

					if ($found == 1) 
						{
							print "                    <OPTION selected value=\"$value\">\n";
						}
					else
						{
							print "                    <OPTION value=\"$value\">\n";
						}

					if ($value eq "0") 
						{
							print "                      All\n";
						}
					else
						{
							print "                      $choice\n";
						}
					print "                    </OPTION>\n";
				}
			print "                  </SELECT>\n";
			print "                </TD>\n";
			print "              </TR>\n";
				}# END else (No db error) 
			else
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set!\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
}


sub Print_Lookup_Table_Expects
{
	(my $TableName, my $Debug, my %Map) = @_;

	my $choice	= "";
	my $value	= "";
	my $iso_name= "";

	my $SqlStatement = "SELECT RTRIM(choice) AS \'choice\', RTRIM(iso_name) AS \'iso_name\', RTRIM(value) AS \'value\' FROM $TableName ORDER BY choice ASC";
#	my $SqlStatement = "SELECT * FROM $TableName ORDER BY choice ASC";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL)
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $Debug eq '1';
			print "              <!--  " . $TableName . "_expected -->\n";
			print "                <TD>\n";
			print "                  <SELECT name=\"" . $TableName . "_expected\">\n";
			# Prevent infinite loop...
			while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
				{
					# Since there is no global DB error check get 
					# all database fields returned by the query...
					
					$iso_name	= $$dataref{iso_name};
					$choice		= $$dataref{choice};
					$value		= $$dataref{value};

					print "                    <OPTION>\n";
					print "                      ($choice) or ($iso_name) or ($value)\n";
					print "                    </OPTION>\n";
				}
			print "                  </SELECT>\n";
			print "                </TD>\n";
				}# END else (No db error) 
			else
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set!\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
}


sub Print_Lookup_Table_Options
{
	(my $TableName, my $DislayText, my $CommaSeperatedList, my $Multiple, my $MultipleNumber, my $Debug, my %Map) = @_;

	my $choice = "";
	my $value  = "";
	my @SplitArray;
	my $index = 0;
	my $ArraySize = 0;

	if($CommaSeperatedList =~ m/,/g)
		{
			(@SplitArray) = split (/,/, $CommaSeperatedList );
		}
	else
		{
			push(@SplitArray, $CommaSeperatedList);
		}


	$ArraySize = scalar $#SplitArray + 1;

	print "<!-- CommaSeperatedList = ($CommaSeperatedList) -->\n" if $Debug eq '1';
	print "<!-- SplitArray         = (@SplitArray) -->\n" if $Debug eq '1';
	print "<!-- ArraySize          = ($ArraySize) -->\n" if $Debug eq '1';


	my $SqlStatement = "SELECT * FROM $TableName ORDER BY value ASC";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL)
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $Debug eq '1';
			# Prevent infinite loop...
			while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
				{
					# Since there is no global DB error check get 
					# all database fields returned by the query...
					
					$choice	= $$dataref{choice};
					$value	= $$dataref{value};
					$value =~ s/\s//g;

					$index = 0;
					my $found = 0;
					while($index < $ArraySize)
					{
						$SplitArray[$index] =~ s/^\s//g;
						if ($SplitArray[$index++] eq $value) 
							{
								$found = 1;
							}
					}

					if ($found == 1) 
						{
							print "                    <OPTION selected value=\"$value\">\n";
						}
					else
						{
							print "                    <OPTION value=\"$value\">\n";
						}

					if ($value eq "0") 
						{
							print "                      All\n";
						}
					else
						{
							print "                      $choice\n";
						}
					print "                    </OPTION>\n";
				}
				}# END else (No db error) 
			else
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set!\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
}


sub Print_TextAds_By_Group
{
	my $CgiParamHash	= shift;
	my $DeleteStatus	= shift;
	my $CurrentAd		= shift;
	my $Debug			= shift;
	my $MapHash			= shift;

	my $SqlStatement = "adv_GetTextAdsByGroup \'$$CgiParamHash{'advertiser_unique_id'}\', \'$$CgiParamHash{'campaign_unique_id'}\', \'$$CgiParamHash{'group_unique_id'}\'";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$MapHash{'DBUSER'}, $$MapHash{'DBPWD'}, $$MapHash{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $$Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $$Debug eq '1';
			# Check for global DB error...
			if($DatabaseFunctions::DatabaseError eq "1")
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): ($SqlStatement) Failed!<BR>\n";
				}
			else
				{
					# Prevent infinite loop...
					while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
						{
							# Since there is no global DB error check get 
							# all database fields returned by the query...
							
							if($$dataref{is_ad_deleted} eq $$DeleteStatus) 
								{
									print "            <CENTER>\n";
									if($$dataref{ad_unique_id} eq $$CurrentAd) 
										{
											print "              <TABLE cellspacing=\"1\" border=\"0\" bgcolor=\"red\" width=\"150\">\n";
										}
									else
										{
#											print "<!-- ad_unique_id = ($$dataref{ad_unique_id}) -->\n";
#											print "<!-- CurrentAd    = ($CurrentAd) -->\n";
											print "              <TABLE cellspacing=\"0\" border=\"1\" bgcolor=\"#cccccc\" width=\"150\">\n";
										}
									print "				  <TD valign=\"bottom\" align=\"center\" bgcolor=\"#ffffff\">\n";
									if($$dataref{is_ad_deleted} eq "0") 
										{
											if($$dataref{is_ad_approved} eq "1") 
												{
													print "				   <FONT color=\"green\" size=\"-1\">Approved By Host</FONT>\n";
												}
											elsif($$dataref{is_ad_approved} eq "9") 
												{
													print "				   <FONT color=\"red\" size=\"-1\">Declined By Host</FONT>\n";
												}
											else
												{
													print "				   <FONT color=\"gray\" size=\"-1\">Awaiting Host Approval</FONT>\n";
												}
										}
									print "				  </TD>\n";
									print "                <TR>\n";
									print "                  <TD>\n";
									print "                    <TABLE border=\"0\" cellspacing=\"0\" width=\"100%\" cellpadding=\"3\">\n";
									print "                      <TR>\n";
									print "                        <TD nowrap bgcolor=\"#dddddd\">\n";
									print "                          <FONT size=\"-1\"> <A href=\"$$dataref{link_url}\">$$dataref{headline}</A>\n";
									print "                          <BR>\n";
									print "                           <SMALL> <FONT color=\"#6f6f6f\">$$dataref{text_1}\n";
									print "                          <BR>\n";
									print "                           $$dataref{text_2}\n";
									print "                          <BR>\n";
									print "                          </FONT></SMALL> <FONT title=\"http://checking.com\" color=\"green\">$$dataref{display_url}</FONT>\n";
									print "                          </SMALL></FONT>\n";
									print "                        </TD>\n";
									print "                      </TR>\n";
									print "                    </TABLE>\n";
									print "                  </TD>\n";
									print "                </TR>\n";
									print "                <TR>\n";
									print "				     <TD valign=\"top\" align=\"center\" bgcolor=\"#ffffff\">\n";
									print "						 <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Impressions: <FONT color=\"red\">$$dataref{times_displayed}</FONT></FONT>\n";
									print "						<BR>\n";
									print "						 <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Clicks: <FONT color=\"red\">$$dataref{times_clicked}</FONT></FONT>\n";
									print "						<BR>\n";
									print "						 <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Clickthrough Rate: <FONT color=\"red\">";
									if($$dataref{times_displayed} > 0)
										{
											printf("%.4f</FONT>", ( $$dataref{times_clicked} / $$dataref{times_displayed} * 100 ));
											print "\%";
										}
									else
										{
											print "N/A</FONT>";
										}
									print "</FONT>\n";
									print "						<BR>\n";
									print "						 <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Average CPC: \$<FONT color=\"red\">$$dataref{total_cost_for_clicks}</FONT></FONT>\n";
									print "						<BR>\n";

									if($$dataref{is_ad_deleted} eq "0" and $$dataref{ad_unique_id} ne $$CurrentAd) 
										{
											my $UrlParams = "Adv_AdText.cgi?submit=EditAd";
											$UrlParams .= '&' . "ad_unique_id=$$dataref{ad_unique_id}";
											$UrlParams .= '&' . "advertiser_unique_id=$$dataref{advertiser_unique_id}";
											$UrlParams .= '&' . "campaign_unique_id=$$dataref{campaign_unique_id}";
											$UrlParams .= '&' . "campaign_name=$$CgiParamHash{'campaign_name'}";
											$UrlParams .= '&' . "campaign_type=$$CgiParamHash{'campaign_type'}";
											$UrlParams .= '&' . "is_campaign_active=$$CgiParamHash{'is_campaign_active'}";
											$UrlParams .= '&' . "group_unique_id=$$dataref{group_unique_id}";
											$UrlParams .= '&' . "group_name=$$CgiParamHash{'group_name'}";
											$UrlParams .= '&' . "ad_unique_id=$$dataref{ad_unique_id}";
											$UrlParams .= '&' . "headline=$$dataref{headline}";
											$UrlParams .= '&' . "text_1=$$dataref{text_1}";
											$UrlParams .= '&' . "text_2=$$dataref{text_2}";
											$UrlParams .= '&' . "display_url=$$dataref{display_url}";
											$UrlParams .= '&' . "link_url=$$dataref{link_url}";
											$UrlParams .= '&' . "creation_date=$$dataref{creation_date}";
											$UrlParams .= '&' . "is_ad_approved=$$dataref{is_ad_approved}";
											$UrlParams .= '&' . "is_ad_deleted=$$dataref{is_ad_deleted}";
											$UrlParams =~ s/ /\%20/g;
											print "				        <A href=\"$UrlParams\"><FONT color=\"gray\" size=\"-1\">Edit</FONT></A> <FONT color=\"gray\" size=\"-1\">--</FONT>\n";

											$UrlParams = "Adv_AdText.cgi?submit=DeleteAd";
											$UrlParams .= '&' . "ad_unique_id=$$dataref{ad_unique_id}";
											$UrlParams .= '&' . "advertiser_unique_id=$$dataref{advertiser_unique_id}";
											$UrlParams .= '&' . "campaign_unique_id=$$dataref{campaign_unique_id}";
											$UrlParams .= '&' . "campaign_name=$$CgiParamHash{'campaign_name'}";
											$UrlParams .= '&' . "campaign_type=$$CgiParamHash{'campaign_type'}";
											$UrlParams .= '&' . "is_campaign_active=$$CgiParamHash{'is_campaign_active'}";
											$UrlParams .= '&' . "group_unique_id=$$dataref{group_unique_id}";
											$UrlParams .= '&' . "group_name=$$CgiParamHash{'group_name'}";
											$UrlParams =~ s/ /\%20/g;
											print "						<A href=\"$UrlParams\"><FONT color=\"gray\" size=\"-1\">Delete</FONT></A>\n";

										}
									print "				     </TD>\n";
									print "                </TR>\n";
									print "              </TABLE>\n";
									print "            </CENTER>\n";
									print "            <BR>\n";
								}
						}
					}# END else (No db error) 
				}
			else
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set!\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
}


sub Print_TextAds_By_Host
{
	my $UserId			= shift;
	my $Password		= shift;
	my $ApprovedStatus	= shift;
	my $CurrentAd		= shift;
	my $Debug			= shift;
	my $MapHash			= shift;

	my%ReturnAdHash;

	my $SqlStatement = "adv_GetTextAdsByHost \'$$UserId\', \'$$Password\'";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$MapHash{'DBUSER'}, $$MapHash{'DBPWD'}, $$MapHash{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
		{
			$ReturnAdHash{status} = "";
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $$Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $$Debug eq '1';
			# Check for global DB error...
			if($DatabaseFunctions::DatabaseError eq "1")
				{
					print "ERROR ($DatabaseFunctions::DatabaseError): ($SqlStatement) Failed!<BR>\n";
					$ReturnAdHash{status} = "FAILURE";
				}
			else
				{
					my $previous_advertiser_unique_id	= "0";
					my $current_advertiser_unique_id	= "0";
					my $previous_campaign_unique_id		= "0";
					my $current_campaign_unique_id		= "0";
					my $previous_group_unique_id		= "0";
					my $current_group_unique_id			= "0";

					my $advertiser_count				= 0;
					my $campaign_count					= 0;
					my $group_count						= 0;
					my $show_summary_info				= "false";
					my $while_count						= 0;

					# Prevent infinite loop...
					while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
						{
							$current_advertiser_unique_id	= $$dataref{advertiser_unique_id};
							$current_campaign_unique_id		= $$dataref{campaign_unique_id};
							$current_group_unique_id		= $$dataref{group_unique_id};

							if ($$Debug eq "1")
								{
									print "<!-- Previous       : ($previous_advertiser_unique_id) -->\n";
									print "<!-- Current	       : ($current_advertiser_unique_id) -->\n";
									print "<!-- is_ad_approved : ($$dataref{is_ad_approved}) -->\n";
									print "<!-- is_ad_approved : ($$dataref{is_ad_deleted}) -->\n";
								}

							if ($current_advertiser_unique_id ne $previous_advertiser_unique_id)
								{
									$advertiser_count++;
									$campaign_count = 1;
									$group_count    = 1;
									$show_summary_info = "true";
								}
							elsif ($current_campaign_unique_id ne $previous_campaign_unique_id) 
								{
									$campaign_count++;
									$group_count    = 1;
									$show_summary_info = "true";
								}
							elsif ($current_group_unique_id ne $previous_group_unique_id) 
								{
									$group_count++;
									$show_summary_info = "false";
								}
							else
								{
									$show_summary_info = "false";
								}

							# Since there is no global DB error check get 
							# all database fields returned by the query...
							
							if($$dataref{is_ad_approved} =~ m/$$ApprovedStatus/) 
								{
									print "            <CENTER>\n";
									if($while_count == 0 and $$dataref{is_ad_approved} =~ m/0/) 
										{
											$ReturnAdHash{status}				= "SUCCESS";
											$ReturnAdHash{ad_unique_id}			= $$dataref{ad_unique_id};
											$ReturnAdHash{headline}				= $$dataref{headline};
											$ReturnAdHash{text_1}				= $$dataref{text_1};
											$ReturnAdHash{text_2}				= $$dataref{text_2};
											$ReturnAdHash{display_url}			= $$dataref{display_url};
											$ReturnAdHash{link_url}				= $$dataref{link_url};
											$ReturnAdHash{email}				= $$dataref{email};
											$ReturnAdHash{campaign_type}		= $$dataref{campaign_type};
											print "              <TABLE cellspacing=\"1\" border=\"0\" bgcolor=\"red\" width=\"150\">\n";
										}
									else
										{
											print "              <TABLE cellspacing=\"0\" border=\"1\" bgcolor=\"#cccccc\" width=\"150\">\n";
										}
									print "				  <TD nowrap valign=\"bottom\" align=\"center\" bgcolor=\"#ffffff\">\n";
									print "				   <FONT color=\"gray\" size=\"-3\">Advertiser ($advertiser_count) Campaign ($campaign_count) Group ($group_count) </FONT>\n";
									print "				  </TD>\n";
									print "                <TR>\n";
									print "                  <TD>\n";
									print "                    <TABLE border=\"0\" cellspacing=\"0\" width=\"100%\" cellpadding=\"3\">\n";
									print "                      <TR>\n";
									print "                        <TD nowrap bgcolor=\"#dddddd\">\n";
									print "                          <FONT size=\"-1\"> <A href=\"$$dataref{link_url}\">$$dataref{headline}</A>\n";
									print "                          <BR>\n";
									print "                           <SMALL> <FONT color=\"#6f6f6f\">$$dataref{text_1}\n";
									print "                          <BR>\n";
									print "                           $$dataref{text_2}\n";
									print "                          <BR>\n";
									print "                          </FONT></SMALL> <FONT title=\"http://checking.com\" color=\"green\">$$dataref{display_url}</FONT>\n";
									print "                          </SMALL></FONT>\n";
									print "                        </TD>\n";
									print "                      </TR>\n";
									print "                    </TABLE>\n";
									print "                  </TD>\n";
									print "                </TR>\n";
									print "                <TR>\n";

									if($show_summary_info eq "true") 
										{
											print "                <TD valign=\"top\" align=\"center\" bgcolor=\"#ffffff\">\n";
											if($$dataref{campaign_type} =~ m/1/) 
												{
													# CPM
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Impressions: <FONT color=\"red\">$$dataref{base_impressions}</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Bonus: <FONT color=\"red\">$$dataref{bonus_impressions}</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Price Per 1000: \$<FONT color=\"red\">$$dataref{price_per_thousand}</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Total: \$<FONT color=\"red\">";
													printf("%.4f", ( ( ($$dataref{base_impressions} + $$dataref{bonus_impressions} ) /1000 ) * $$dataref{price_per_thousand} ) );
													print "</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <A href=\"mailto:$$dataref{email}\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">$$dataref{email}</FONT></A>\n";
												}
											else
												{
													# CPC
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Max cost-per-click: \$<FONT color=\"red\">$$dataref{max_cost_per_click}</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Daily Budget: \$<FONT color=\"red\">$$dataref{daily_budget}</FONT></FONT>\n";
													print "                  <BR>\n";
													print "                  <A href=\"mailto:$$dataref{email}\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">$$dataref{email}</FONT></A>\n";
												}
											print "                </TD>\n";
										}
                                    
									print "				     </TD>\n";
									print "                </TR>\n";
									print "              </TABLE>\n";
									print "            </CENTER>\n";
									print "\n";
									print "            <BR>\n";
									print "\n";
								}
							$previous_advertiser_unique_id	= $current_advertiser_unique_id;
							$previous_campaign_unique_id	= $current_campaign_unique_id;
							$previous_group_unique_id		= $current_group_unique_id;
							$while_count++;
						}
					}# END else (No db error) 
				return %ReturnAdHash;
				}
			else
				{
					$ReturnAdHash{status} = "FAILURE";
					print "ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set!\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
}# End Print_TextAds_By_Host


sub Print_Lookup_Choice_By_Value
{
	my $LookupTableName	= shift;
	my $Value			= shift;
	my $Debug			= shift;
	my $Map				= shift;

	my $ReturnText = "";
	print "<!-- sub Print_Lookup_Choice_By_Value($$LookupTableName, $$Value, $$Debug, %$Map) -->\n" if $$Debug eq "1";

	my $SqlStatement = "SELECT choice FROM $$LookupTableName WHERE value = \'$$Value\'";
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$Map{'DBUSER'}, $$Map{'DBPWD'}, $$Map{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL)
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $$Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $$Debug eq '1';
			# Prevent infinite loop...
			while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
				{
					# Since there is no global DB error check get 
					# all database fields returned by the query...
					
					$ReturnText = $$dataref{choice} 
				}
			return $ReturnText;
		}# END else (No db error) 
	else
		{
			print "<!-- ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set! -->\n";
			$status = $MSSQL::DBlib::dbh->dbcancel();
			return "N/A";
		}
}

sub Print_Only_Selected_Lookup_Table_Options
{
	my $TableName			= shift;
	my $CommaSeperatedList	= shift;
	my $Debug				= shift;
	my $Map					= shift;

	# Put a quote at the beginning and end of the list...
	$$CommaSeperatedList = "\'" . $$CommaSeperatedList . "\'";

	# Since this sub will only receive CSVs of numbers it is ok to remove all white space...
	$$CommaSeperatedList =~ s/\s//g;

	# Put quotes in the middle of the list...
	$$CommaSeperatedList =~ s/,/\',\'/g;
	print "<!-- Quoted List: ($$CommaSeperatedList) -->\n" if $$Debug eq '1';

	my $choice	= "";
	my $value	= "";

	my $SqlStatement = "";

	if ($$TableName ne "membership_type") 
		{
			$SqlStatement = "SELECT * FROM $$TableName WHERE value IN ($$CommaSeperatedList)";
		}
	else
		{
			$SqlStatement = "SELECT * FROM $$TableName WHERE membership_type_id IN ($$CommaSeperatedList)";
		}

	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$Map{'DBUSER'}, $$Map{'DBPWD'}, $$Map{'DBNAME'}, "DatabaseFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	##########################
	# Get ONLY result set...
	##########################
	# dbresults() must be called for each result set...
	$status = $MSSQL::DBlib::dbh->dbresults();
	if($status != FAIL)
		{
			print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n" if $$Debug eq '1';
			my %dataref = ("jason" => "baumbach");
			my $dataref = \%dataref;
			# If in debug mode, print information...
			print "<!-- SQL: $SqlStatement -->\n" if $$Debug eq '1';

			# Prevent infinite loop...
			while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
				{
					# Since there is no global DB error check get 
					# all database fields returned by the query...
					
					if ($$TableName ne "membership_type") 
						{
							$choice	= $$dataref{choice};
							$value	= $$dataref{value};
						}
					else
						{
							$choice	= $$dataref{membership_type_name};
							$value	= $$dataref{membership_type_id};
						}

					$value =~ s/\s//g;

					print "                    <OPTION value=\"$value\">\n";
					if ($value eq "0" and $$TableName ne "membership_type") 
						{
							print "                      All\n";
						}
					else
						{
							if ($choice eq "") 
								{
									print "                      OOB Error\n";
								}
							else
								{
									print "                      $choice\n";
								}
						}
					print "                    </OPTION>\n";
				}
			}# END else (No db error) 
		else
			{
				print "<!-- ERROR ($DatabaseFunctions::DatabaseError): $SqlStatement Failed for first result set! -->\n";
				$status = $MSSQL::DBlib::dbh->dbcancel();
			}
}


# Install the error and message handlers...
&MSSQL::DBlib::dbmsghandle (\&message_handler);
&MSSQL::DBlib::dberrhandle (\&error_handler);
	
# Scripts that are to be include with other scripts must end with "1;"
1;
