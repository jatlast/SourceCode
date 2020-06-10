#!/usr/local/bin/perl -w
use CGI qw/:standard/;
use strict;

# Add directories to perl environment path...

#Home pc
unshift @INC, "D:/Required/INC";
#Work PC
#unshift @INC, "C:\\Jason\\MyData\\Personal\\Required\\INC\\";
##unshift @INC, "D:\\Data\\Personal\\LocalWebSites\\PersianConnections\\cgi-bin\\";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "UtilityFunctions.pl";

my $DebugThisAp			   = "1";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";

#Begin HTML so errors show up in browser...
print CGI::header('text/html');
print "<HTML>\n";

# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap(1); 

# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		#&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
	}
else
	{
		print "<!-- $Map{'CONFIG'} -->\n";
	}

# declare global variables...
my $db_name_delete 	  		 	      = "";
my $db_name_create 	  				  = "";
my $db_name 	 	  				  = "";
my $db_name_ignore	  				  = "";
my $required_tables_delete_add 		  = "";
my $required_tables_ignore 			  = "";
my $initialize_lookup_tables 		  = "";
my $initialize_lookup_tables_ignore   = "";
my $create_Administrator_profile	  = "";
my $create_Administrator_profile_ignore   = "";
my $user_stored_procedures_delete_add = "";
my $user_stored_procedures_ignore 	  = "";
my $admin_stored_procedures_delete_add= "";
my $admin_stored_procedures_ignore 	  = "";
my $user_name_delete 	  			  = "";
my $user_name_create 	  			  = "";
my $user_name 	 	  				  = "";
my $user_password 	 	  			  = "";
my $user_password_verify 	 	  	  = "";
my $user_default_db 	 	  		  = "";
my $user_name_ignore	  			  = "";
my $admin_name_delete 	  			  = "";
my $admin_name_create 	  			  = "";
my $admin_name 	 	 				  = "";
my $admin_password 	 	  			  = "";
my $admin_password_verify 	 	  	  = "";
my $admin_default_db 	 	  	  	  = "";
my $admin_name_ignore	  			  = "";
my $db_admin_name 	 	  			  = "";
my $db_admin_password 	 	  		  = "";

if(CGI::param('db_name_delete'))						{$db_name_delete 	  		 		= CGI::param('db_name_delete');}
if(CGI::param('db_name_create'))						{$db_name_create 	  				= CGI::param('db_name_create');}
if(CGI::param('db_name'))								{$db_name 	 	  					= CGI::param('db_name');}
if(CGI::param('db_name_ignore'))						{$db_name_ignore	  				= CGI::param('db_name_ignore');}
if(CGI::param('required_tables_delete_add'))			{$required_tables_delete_add 		= CGI::param('required_tables_delete_add');}
if(CGI::param('required_tables_ignore'))				{$required_tables_ignore 			= CGI::param('required_tables_ignore');}
if(CGI::param('initialize_lookup_tables'))				{$initialize_lookup_tables 			= CGI::param('initialize_lookup_tables');}
if(CGI::param('initialize_lookup_tables_ignore'))		{$initialize_lookup_tables_ignore	= CGI::param('initialize_lookup_tables_ignore');}
if(CGI::param('create_Administrator_profile'))			{$create_Administrator_profile 		= CGI::param('create_Administrator_profile');}
if(CGI::param('create_Administrator_profile_ignore'))	{$create_Administrator_profile_ignore = CGI::param('create_Administrator_profile_ignore');}
if(CGI::param('user_stored_procedures_delete_add'))		{$user_stored_procedures_delete_add	= CGI::param('user_stored_procedures_delete_add');}
if(CGI::param('user_stored_procedures_ignore'))			{$user_stored_procedures_ignore 	= CGI::param('user_stored_procedures_ignore');}
if(CGI::param('admin_stored_procedures_delete_add'))	{$admin_stored_procedures_delete_add= CGI::param('admin_stored_procedures_delete_add');}
if(CGI::param('admin_stored_procedures_ignore'))		{$admin_stored_procedures_ignore 	= CGI::param('admin_stored_procedures_ignore');}
if(CGI::param('user_name_delete'))						{$user_name_delete 	  				= CGI::param('user_name_delete');}
if(CGI::param('user_name_create'))						{$user_name_create 	  				= CGI::param('user_name_create');}
if(CGI::param('user_name'))								{$user_name 	 	  				= CGI::param('user_name');}
if(CGI::param('user_password'))							{$user_password 	 	  			= CGI::param('user_password');}
if(CGI::param('user_password_verify'))					{$user_password_verify 	 	  		= CGI::param('user_password_verify');}
if(CGI::param('user_default_db'))						{$user_default_db 	 	  			= CGI::param('user_default_db');}
if(CGI::param('user_name_ignore'))						{$user_name_ignore	  				= CGI::param('user_name_ignore');}
if(CGI::param('admin_name_delete'))						{$admin_name_delete 	  			= CGI::param('admin_name_delete');}
if(CGI::param('admin_name_create'))						{$admin_name_create 	  			= CGI::param('admin_name_create');}
if(CGI::param('admin_name'))							{$admin_name 	 	 				= CGI::param('admin_name');}
if(CGI::param('admin_password'))						{$admin_password 	 	  			= CGI::param('admin_password');}
if(CGI::param('admin_password_verify'))					{$admin_password_verify 	 	  	= CGI::param('admin_password_verify');}
if(CGI::param('admin_default_db'))						{$admin_default_db 	 	  			= CGI::param('admin_default_db');}
if(CGI::param('admin_name_ignore'))						{$admin_name_ignore	  				= CGI::param('admin_name_ignore');}
if(CGI::param('db_admin_name'))							{$db_admin_name 	 	  			= CGI::param('db_admin_name');}
if(CGI::param('db_admin_password'))						{$db_admin_password 	 	  		= CGI::param('db_admin_password');}

my $StoredProcDir = "D:/Required/SQL";

if ($DebugThisAp eq "1")
	{
		print "<!-- db_name_delete                      = ($db_name_delete) -->\n";
		print "<!-- db_name_create                      = ($db_name_create) -->\n";
		print "<!-- db_name                             = ($db_name) -->\n";
		print "<!-- db_name_ignore                      = ($db_name_ignore) -->\n";
		print "<!-- required_tables_delete_add          = ($required_tables_delete_add) -->\n";
		print "<!-- required_tables_ignore              = ($required_tables_ignore) -->\n";
		print "<!-- initialize_lookup_tables            = ($initialize_lookup_tables) -->\n";
		print "<!-- initialize_lookup_tables_ignore     = ($initialize_lookup_tables_ignore) -->\n";
		print "<!-- create_Administrator_profile     	= ($create_Administrator_profile) -->\n";
		print "<!-- create_Administrator_profile_ignore = ($create_Administrator_profile_ignore) -->\n";
		print "<!-- user_stored_procedures_delete_add   = ($user_stored_procedures_delete_add) -->\n";
		print "<!-- user_stored_procedures_ignore       = ($user_stored_procedures_ignore) -->\n";
		print "<!-- admin_stored_procedures_delete_add  = ($admin_stored_procedures_delete_add) -->\n";
		print "<!-- admin_stored_procedures_ignore      = ($admin_stored_procedures_ignore) -->\n";
		print "<!-- user_name_delete                    = ($user_name_delete) -->\n";
		print "<!-- user_name_create                    = ($user_name_create) -->\n";
		print "<!-- user_name                           = ($user_name) -->\n";
		print "<!-- user_password                       = ($user_password) -->\n";
		print "<!-- user_password_verify                = ($user_password_verify) -->\n";
		print "<!-- user_default_db                     = ($user_default_db) -->\n";
		print "<!-- user_name_ignore                   	= ($user_name_ignore) -->\n";
		print "<!-- admin_name_delete                   = ($admin_name_delete) -->\n";
		print "<!-- admin_name_create                   = ($admin_name_create) -->\n";
		print "<!-- admin_name                          = ($admin_name) -->\n";
		print "<!-- admin_password                      = ($admin_password) -->\n";
		print "<!-- admin_password_verify               = ($admin_password_verify) -->\n";
		print "<!-- admin_default_db                    = ($admin_default_db) -->\n";
		print "<!-- admin_name_ignore                   = ($admin_name_ignore) -->\n";
		print "<!-- db_admin_name                       = ($db_admin_name) -->\n";
		print "<!-- db_admin_password                   = ($db_admin_password) -->\n";
	}

# User Stored Procedure Name Array
# For use with:
# 	  sub User_Stored_Procedures_Create
# 	  sub User_Stored_Procedures_Grant_Permissions
my @UserStoredProcNameArray = ("admin_DeleteEntireProfileByUserName"# This will be removed as soon as I figure out a better way to delete bad profiles
, "admin_DeleteBadProfiles"# This will be removed as soon as I figure out a better way to delete bad profiles
, "mailSendNewUserWelcome"
, "verifyMembershipTypePermissions"
, "advancedSearch"
, "cancel_paying_membership"
, "createLoginInfo"
, "checkUsernamePassword"
, "deleteMail"
, "genBookMarks"
, "genInbox"
, "genMemberHome"
, "genOutbox"
, "genPicUpload"
, "genSendMail"
, "getLoginInfoByNamePassword"
, "getContactInfoByNamePassword"
, "getPersonalInfoByNamePassword"
, "getAboutInfoByNamePassword"
, "getBillingInfoByNamePassword"
, "getEmailByUserName"
, "hideUnhideProfile"
, "insert_membership_cancellation"
, "LogIn"
, "mailSend"
, "readReceivedMail"
, "readSentMail"
, "simpleSearch"
, "singleProfile"
, "transaction_credit_card_receive"
, "transaction_credit_card_send"
, "transaction_manual_check_post"
, "updateLoginInfo"
, "updateContactInfo"
, "updatePersonalInfo"
, "updateAboutInfo"
, "updateBillingInfo"
, "updateBookMarks"
, "updatePicture"
); # initialize array with user stored procedure names
 
# Admin Stored Procedure Name Array
# For use with:
# 	  sub Admin_Stored_Procedures_Create
# 	  sub Admin_Stored_Procedures_Grant_Permissions
my @AdminStoredProcNameArray = ("admin_BatchNightlyTransactionSend"
, "admin_DeleteAllDanglingUserNames"
, "admin_DeleteBadProfiles"
, "admin_DeleteEntireProfileByUserName"
, "admin_FindDuplicates"
, "admin_FreeFormAudit"
, "admin_GetDanglingUserNames"
, "admin_GetIndividualTableInfoByUserName"
, "admin_GetMembershipCancellations"
, "admin_GraphHourlyCreationDateStatsByDayMonthYear"
, "admin_GraphMonthlyCreationDateStatsByMonthYear"
, "admin_GraphMonthlyCreationDateStatsByYear"
, "admin_GraphYearlyCreationDateStats"
, "admin_TransactionsLogAudit"
); # initialize array with admin stored procedure names

# User Table Name Array
# For use with:
# 	  sub User_Tables_Grant_Permissions
# Note: This step is needed for all those stored procedures that contain "EXEC ('Some sql statement')"
#  Because when a stored procedure uses this syntax the system assumes the current user is
#  running a simple sql statement and not executing a stored procedure.
my @UserTableNameArray = ("login_info"
, "contact_info"
, "personal_info"
, "about_info"
, "billing_info"
, "pictures"
, "state"
, "country"
); # initialize array with all the tables the user needs access too
 
# Admin Table Name Array
# For use with:
# 	  sub Admin_Tables_Grant_Permissions
# Note: This step is needed for all those stored procedures that contain "EXEC ('Some sql statement')"
#  Because when a stored procedure uses this syntax the system assumes the current user is
#  running a simple sql statement and not executing a stored procedure.
my @AdminTableNameArray = ("about_info"
, "contact_info"
, "login_info"
, "billing_info"
, "pictures"
, "transactions_log"
, "membership_cancellation"
, "sex"
, "state"
, "country"
);  # initialize array with all the tables the admin needs access too
 
my $return_value = "";
my $fatal_error = 0;
###########################
# Create New DB
###########################
if($db_name ne "")
	{
		if($db_name_delete eq "on")
			{
				$return_value = &Delete_Database($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: The database named (<font color=\"blue\" size=\"2\">$db_name</FONT>) was deleted.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Delete_Database returned ($return_value): Database could not be deleted.<BR>\n";
						if($db_name_ignore eq "on")
							{
								print "IGNORE: The above deletion error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the existing database (<font color=\"blue\" size=\"2\">$db_name</FONT>) could not be deleted.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Delete_Database returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
			
		if($db_name_create eq "on" && $fatal_error != 1)
			{
				$return_value = &Create_New_Database($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: A new database named (<font color=\"blue\" size=\"2\">$db_name</FONT>) was created.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): Database could not be created.<BR>\n";
						if($db_name_ignore eq "on")
							{
								print "IGNORE: The above creation error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the new database (<font color=\"blue\" size=\"2\">$db_name</FONT>) could not be created.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
	} # End Create DB

if($required_tables_delete_add eq "on" && $fatal_error != 1)
	{
		####################################
		# Create All Needed Tables in New DB
		####################################
		$return_value = &Create_All_Tables($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
		if($return_value == 1)
			{
				print "SUCCESS: All Tables were added to Database (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_All_Tables returned ($return_value)<BR>\n";
				if($required_tables_ignore eq "on")
					{
						print "IGNORE: The above table initialization error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the table initialization on the database (<font color=\"blue\" size=\"2\">$db_name</FONT>) encountered errors.<BR>\n";
						$fatal_error = 1;
					}
			}
	}# End required table initialization
	
if($initialize_lookup_tables eq "on" && $fatal_error != 1)
	{
		####################################
		# Initialize all LookUp Tables
		####################################
		$return_value = &Initialize_All_Lookup_Tables($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
		if($return_value == 1)
			{
				print "SUCCESS: All Lookup Tables Have Been Initialized in Database (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Initialize_All_Lookup_Tables returned ($return_value)<BR>\n";
				if($initialize_lookup_tables_ignore eq "on")
					{
						print "IGNORE: The above table initialization error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the table initialization on the database (<font color=\"blue\" size=\"2\">$db_name</FONT>) encountered errors.<BR>\n";
						$fatal_error = 1;
					}
			}
	}# End required table initialization

if($create_Administrator_profile eq "on" && $fatal_error != 1)
	{
		####################################
		# Initialize Administrator Profile
		####################################
		$return_value = &Initialize_Administrator_Profile($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
		if($return_value == 1)
			{
				print "SUCCESS: User Administrator has Been Initialized in Database (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Initialize_Administrator_Profile returned ($return_value)<BR>\n";
				if($create_Administrator_profile_ignore eq "on")
					{
						print "IGNORE: The above Administrator initialization error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the Administrator initialization on the database (<font color=\"blue\" size=\"2\">$db_name</FONT>) encountered errors.<BR>\n";
						$fatal_error = 1;
					}
			}
	}# End required table initialization
	
if($user_stored_procedures_delete_add eq "on" && $fatal_error != 1)
	{
		####################################
		# Add user stored procedures
		####################################
		$return_value = &User_Stored_Procedures_Create($db_admin_name, $db_admin_password, $user_name, $db_name, $DebugThisAp);
		if($return_value == 1)
			{
				print "SUCCESS: All User stored procedures have been put in Database (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Stored_Procedures_Create returned ($return_value)<BR>\n";
				if($user_stored_procedures_ignore eq "on")
					{
						print "IGNORE: The above creation of user stored procedures error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the creation of user stored procedures on the database (<font color=\"blue\" size=\"2\">$db_name</FONT>) encountered errors.<BR>\n";
						$fatal_error = 1;
					}
			}
	}# End user_stored_procedures_delete_add
	
if($admin_stored_procedures_delete_add eq "on" && $fatal_error != 1)
	{
		####################################
		# Add admin stored procedures
		####################################
		$return_value = &Admin_Stored_Procedures_Create($db_admin_name, $db_admin_password, $admin_name, $db_name, $DebugThisAp);
		if($return_value == 1)
			{
				print "SUCCESS: All Admin stored procedures have been put in Database (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Stored_Procedures_Create returned ($return_value)<BR>\n";
				if($admin_stored_procedures_ignore eq "on")
					{
						print "IGNORE: The above creation of admin stored procedures error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the creation of admin stored procedures on the database (<font color=\"blue\" size=\"2\">$db_name</FONT>) encountered errors.<BR>\n";
						$fatal_error = 1;
					}
			}
	}# End admin_stored_procedures_delete_add
	
########################################################################################################
# Create new user login grant login permission and grant execute permission on needed stored procedures
########################################################################################################
if($user_name ne "" && $fatal_error != 1)
	{
		if($user_name_delete eq "on")
			{
				#############################
				# Delete existing User Login
				#############################
				$return_value = &User_Login_Delete($db_admin_name, $db_admin_password, $user_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: The new login user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was deleted.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Delete returned ($return_value): user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be deleted.<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above deletion error for the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be deleted.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Delete returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
			
		if($user_name_create eq "on" && $fatal_error != 1)
			{
				#######################
				# Create new User Login
				#######################
				$return_value = &User_Login_Create($db_admin_name, $db_admin_password, $user_name, $user_password, $user_default_db, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: A new user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was created.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Create returned ($return_value): user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be created.<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above creation error for the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the new user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be created.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Create returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
		if($fatal_error != 1)
			{
				#############################################
				# Grant User Login Access to the New Database
				#############################################
				$return_value = &User_Login_Grant_Access($db_admin_name, $db_admin_password, $user_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was granted login permission to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Grant_Access returned ($return_value): user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was not granted access to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above access error for the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) and database database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be granted access to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Grant_Access returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
		if($fatal_error != 1)
			{
				##################################################################
				# Grant User Execute Permissions on all needed Stored Procedures
				##################################################################
				$return_value = &User_Stored_Procedures_Grant_Permissions($db_admin_name, $db_admin_password, $user_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was granted execute permissions on all needed stored procedures.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Stored_Procedures_Grant_Permissions returned ($return_value): user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was not granted execute permission on all needed stored procedures.<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above permissions error for the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be granted execute permissions on all needed stored procedures.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Stored_Procedures_Grant_Permissions returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
		if($fatal_error != 1)
			{
				##################################################################
				# Grant User SELECT Permissions on all needed tables
				##################################################################
				$return_value = &User_Tables_Grant_Permissions($db_admin_name, $db_admin_password, $user_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was granted SELECT permissions on all needed tables.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Tables_Grant_Permissions returned ($return_value): user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) was not granted SELECT permission on all needed tables.<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above permissions error for the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the user named (<font color=\"blue\" size=\"2\">$user_name</FONT>) could not be granted SELECT permissions on all needed tables.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Tables_Grant_Permissions returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
	} # End Create User

########################################################################################################
# Create new admin login, grant login permission, and grant execute permission on needed stored procedures
########################################################################################################
if($admin_name ne "" && $fatal_error != 1)
	{
		if($admin_name_delete eq "on")
			{
				#############################
				# Delete existing Admin Login
				#############################
				$return_value = &Admin_Login_Delete($db_admin_name, $db_admin_password, $admin_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: The new login admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was deleted.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Login_Delete returned ($return_value): admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be deleted.<BR>\n";
						if($admin_name_ignore eq "on")
							{
								print "IGNORE: The above deletion error for the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be deleted.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Login_Delete returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
			
		if($admin_name_create eq "on" && $fatal_error != 1)
			{
				#######################
				# Create new Admin Login
				#######################
				$return_value = &Admin_Login_Create($db_admin_name, $db_admin_password, $admin_name, $admin_password, $admin_default_db, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: A new admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was created.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Login_Create returned ($return_value): admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be created.<BR>\n";
						if($admin_name_ignore eq "on")
							{
								print "IGNORE: The above creation error for the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the new admim named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be created.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Login_Create returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
		if($fatal_error != 1)
			{
				#############################################
				# Grant Admin Login Access to the New Database
				#############################################
				$return_value = &Admin_Login_Grant_Access($db_admin_name, $db_admin_password, $admin_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was granted login permission to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Login_Grant_Access returned ($return_value): admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was not granted access to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
						if($admin_name_ignore eq "on")
							{
								print "IGNORE: The above access error for the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) and database database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be granted access to database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Login_Grant_Access returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
		if($fatal_error != 1)
			{
				##################################################################
				# Grant Admin Execute Permissions on all needed Stored Procedures
				##################################################################
				$return_value = &Admin_Stored_Procedures_Grant_Permissions($db_admin_name, $db_admin_password, $admin_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was granted execute permissions on all needed stored procedures.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Stored_Procedures_Grant_Permissions returned ($return_value): admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was not granted execute permission on all needed stored procedures.<BR>\n";
						if($admin_name_ignore eq "on")
							{
								print "IGNORE: The above permissions error for the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be granted execute permissions on all needed stored procedures.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Stored_Procedures_Grant_Permissions returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}

		if($fatal_error != 1)
			{
				##################################################################
				# Grant Admin SELECT Permissions on all needed tables
				##################################################################
				$return_value = &Admin_Tables_Grant_Permissions($db_admin_name, $db_admin_password, $admin_name, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was granted SELECT permissions on all needed tables.<BR>\n";
					}
				elsif($return_value == -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> User_Tables_Grant_Permissions returned ($return_value): admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) was not granted SELECT permission on all needed tables.<BR>\n";
						if($user_name_ignore eq "on")
							{
								print "IGNORE: The above permissions error for the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>).<BR>\n";
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the admin named (<font color=\"blue\" size=\"2\">$admin_name</FONT>) could not be granted SELECT permissions on all needed tables.<BR>\n";
								$fatal_error = 1;
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Admin_Tables_Grant_Permissions returned ($return_value): This should never happen!<BR>\n";
						$fatal_error = 1;
					}
			}
		
	} # End Create Admin


#End HTML...
print "</HTML>\n";

sub Create_New_Database
	{
		my ($DBAdminName, $DBAdminPassword, $DBName, $Debug) = @_;
		my $output;
		###########################
		# Create New DB
		###########################
		my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -Q \"EXIT(CREATE DATABASE $DBName)\"";
		print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
		$output = `$cmd`;
			
		if($output =~ m/process is allocating/)
			{
				print "<!-- SUCCESS: Create_New_Database finished without errors -->\n";
				print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
				return 1;
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> A new database named (<font color=\"blue\" size=\"2\">$DBName</FONT>) could not be created.<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
	}# End sub Create_New_Database

sub Delete_Database
	{
		my ($DBAdminName, $DBAdminPassword, $DBName, $Debug) = @_;
		my $output;
		###########################
		# Delete DB
		###########################
		my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"MASTER\" -Q \"EXIT(DROP DATABASE $DBName)\"";
		print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
		$output = `$cmd`;
			
		if($output =~ m/Deleting database file/)
			{
				print "<!-- SUCCESS: Delete_Database finished without errors -->\n";
				print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
				return 1;
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The database named (<font color=\"blue\" size=\"2\">$DBName</FONT>) could not be deleted.<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
	}# End sub Delete_Database


sub Create_All_Tables
	{
		my ($DBAdminName, $DBAdminPassword, $DBName, $Debug) = @_;
		my $output;
		####################################
		# Create All Needed Tables in New DB
		####################################
		my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -i \"$StoredProcDir/DropAndCreateAllConnectionsTables.sql\" -n";
		print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
		$output = `$cmd`;
		#		if($output =~ m/\D/ && $output !~ m/>/ && $output !~ m/\s/)
		if($output !~ m/\w/)
			{
				print "<!-- SUCCESS: Create_All_Tables finished without errors. -->\n";
				print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
				return 1;
			}
		elsif($output =~ m/Msg/g)
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors running the stored procedure against Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
		elsif($output =~ m/permission denied/)
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) does not have CREATE TABLE permission in Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors adding tables to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -3;
			}
	}# End sub Create_All_Tables

sub Initialize_All_Lookup_Tables
	{
		my ($DBAdminName, $DBAdminPassword, $DBName, $Debug) = @_;
		my $output;
		####################################
		# Create All Needed Tables in New DB
		####################################
		my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -i \"$StoredProcDir/Initialize_All_Lookup_Tables.sql\" -n";
		print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
		$output = `$cmd`;
		#		if($output =~ m/\D/ && $output !~ m/>/ && $output !~ m/\s/)
		if($output =~ m/Populating(.*).../)
			{
				print "<!-- SUCCESS: Initialize_All_Lookup_Tables finished without errors. -->\n";
				print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
				return 1;
			}
		elsif($output =~ m/Msg/g)
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors running the stored procedure against Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
		elsif($output =~ m/permission denied/)
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) does not have CREATE TABLE permission in Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -1;
			}
		else
			{
				print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors adding tables to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
				print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
				print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
				return -3;
				}		
			}# End sub Initialize_All_Lookup_Tables
			
		sub Initialize_Administrator_Profile
			{
				my ($DBAdminName, $DBAdminPassword, $DBName, $Debug) = @_;
				my $output;
				########################################
				# Initialize Administrator Profile
				########################################
				my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -i \"$StoredProcDir/Initialize_Administrator_Profile.sql\" -n";
				print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
				$output = `$cmd`;
				if( $output =~ m/Populating(.*).../ && !($output =~ m/Msg/g) )
					{
						print "<!-- SUCCESS: Initialize_Administrator_Profile finished without errors. -->\n";
						print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
						return 1;
					}
				elsif($output =~ m/Msg/g)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors running the stored procedure against Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
						print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
						print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
						return -1;
					}
				elsif($output =~ m/permission denied/)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) does not have CREATE TABLE permission in Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
						print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
						print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
						return -1;
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$DBAdminName</FONT>) encountered errors adding Administrator profile to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
						print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
						print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
						return -3;
						}		
					}# End sub Initialize_Administrator_Profile
					
					
				sub User_Login_Delete
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $DBName, $Debug) = @_;
						my $output;
						#############################
						# Revoke User Access to New DB
						#############################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(EXEC sp_revokedbaccess \'$UserName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/dropped/)
							{
								print "<!-- SUCCESS: user $UserName has has been revolked access to database $DBName and is ready to be removed. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
        						#############################
        						# Delete New Login to New DB
        						#############################
        						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -Q \"EXIT(EXEC sp_droplogin \'$UserName\')\"";
        						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
        						$output = `$cmd`;
        						if($output =~ m/Login dropped/)
        							{
        								print "<!-- SUCCESS: User_Login_Delete finished without errors. -->\n";
        								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
        								return 1;
        							}
        						elsif($output =~ m/Msg/)
        							{
        								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be deleted.<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
        								return -1;
        							}
        						else
        							{
        								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The new login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be dropped.<BR>\n";
        								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
        								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
        								return -3;
        							}
							}
						elsif($output =~ m/Msg/g)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be revolked access to database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The user name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be revolked access to database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
							
					}# End sub User_Login_Delete
					
				sub User_Login_Create
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $UserPassword, $DBName, $Debug) = @_;
						my $output;
						#############################
						# Create New Login to New DB
						#############################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -Q \"EXIT(EXEC sp_addlogin \'$UserName\', \'$UserPassword\', \'$DBName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/New login created/)
							{
								print "<!-- SUCCESS: User_Login_Create finished without errors. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
								return 1;
							}
						elsif($output =~ m/already exists/)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) already exists.<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The new login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be created.<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
							
					}# End sub User_Login_Create
					
				sub User_Login_Grant_Access
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $DBName, $Debug) = @_;
						my $output;
						##################################
						# Grant New User Access to New DB
						##################################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(EXEC sp_grantdbaccess \'$UserName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/Granted database access/)
							{
								print "<!-- SUCCESS: User_Login_Grant_Access finished without errors. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
								return 1;
							}
						elsif($output =~ m/already exists/)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) already exists in Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be granted access to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
					}# End sub User_Login_Grant_Access			
					
				sub Admin_Login_Delete
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $DBName, $Debug) = @_;
						my $output;
						#############################
						# Revoke Admin Access to New DB
						#############################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(EXEC sp_revokedbaccess \'$AdminName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/dropped/)
							{
								print "<!-- SUCCESS: admin $AdminName has has been revolked access to database $DBName and is ready to be removed. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
        						#############################
        						# Delete Admin from New DB
        						#############################
        						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -Q \"EXIT(EXEC sp_droplogin \'$AdminName\')\"";
        						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
        						$output = `$cmd`;
        						if($output =~ m/Login dropped/)
        							{
        								print "<!-- SUCCESS: Admin_Login_Delete finished without errors. -->\n";
        								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
        								return 1;
        							}
        						elsif($output =~ m/Msg/)
        							{
        								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The admin name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be deleted.<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
        								return -1;
        							}
        						else
        							{
        								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The admin name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be dropped.<BR>\n";
        								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
        								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
        								return -3;
        							}
							}
						elsif($output =~ m/Msg/g)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The admin name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be revolked access to database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The admin name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be revolked access to database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
							
					}# End sub Admin_Login_Delete
					
				sub Admin_Login_Create
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $AdminPassword, $DBName, $Debug) = @_;
						my $output;
						#############################
						# Create New Admin Login to New DB
						#############################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -Q \"EXIT(EXEC sp_addlogin \'$AdminName\', \'$AdminPassword\', \'$DBName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/New login created/)
							{
								print "<!-- SUCCESS: Admin_Login_Create finished without errors. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
								return 1;
							}
						elsif($output =~ m/already exists/)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) already exists.<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The new login name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be created.<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
							
					}# End sub Admin_Login_Create
					
				sub Admin_Login_Grant_Access
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $DBName, $Debug) = @_;
						my $output;
						##################################
						# Grant New User Access to New DB
						##################################
						my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(EXEC sp_grantdbaccess \'$AdminName\')\"";
						print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
						$output = `$cmd`;
						if($output =~ m/Granted database access/)
							{
								print "<!-- SUCCESS: Admin_Login_Grant_Access finished without errors. -->\n";
								print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
								return 1;
							}
						elsif($output =~ m/already exists/)
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) already exists in Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\nThe following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -1;
							}
						else
							{
								print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be granted access to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
								print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
								print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
								return -3;
							}
					}# End sub Admin_Login_Grant_Access			
				
				
				sub User_Stored_Procedures_Create
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Create the User Stored Procedures
						#####################################################
						foreach my $ProcName (@UserStoredProcNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -i \"$StoredProcDir/" . "dbo." . $ProcName . ".PRC\" -n";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: stored procedure $ProcName was added to $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The stored procedure (<font color=\"blue\" size=\"2\">$ProcName</FONT>) could not be added to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub User_Stored_Procedures_Create
					
				sub User_Stored_Procedures_Grant_Permissions
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Grant New User Access to the User Stored Procedures
						#####################################################
						foreach my $ProcName (@UserStoredProcNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(GRANT EXECUTE ON $ProcName TO $UserName)\"";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: $UserName was granted EXECUTE Permissions to $ProcName on Database $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be granted Object Permissions on Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub User_Stored_Procedures_Grant_Permissions
					
				sub User_Tables_Grant_Permissions
					{
						my ($DBAdminName, $DBAdminPassword, $UserName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Grant User Access to the necessary tables
						#####################################################
						foreach my $TableName (@UserTableNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(GRANT SELECT ON $TableName TO $UserName)\"";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: $UserName was granted SELECT Permissions to $TableName on Database $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The user name (<font color=\"blue\" size=\"2\">$UserName</FONT>) could not be granted Object Permissions on Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub User_Tables_Grant_Permissions
					
				sub Admin_Stored_Procedures_Create
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Create the Admin Stored Procedures
						#####################################################
						foreach my $ProcName (@AdminStoredProcNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -i \"$StoredProcDir/" . "dbo." . $ProcName . ".PRC\" -n";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: stored procedure $ProcName was added to $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The stored procedure (<font color=\"blue\" size=\"2\">$ProcName</FONT>) could not be added to Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub Admin_Stored_Procedures_Create
					
				sub Admin_Stored_Procedures_Grant_Permissions
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Grant New Admin Access to the Admin Stored Procedures
						#####################################################
						foreach my $ProcName (@AdminStoredProcNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(GRANT EXECUTE ON $ProcName TO $AdminName)\"";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: $AdminName was granted EXECUTE Permissions to $ProcName on Database $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The login name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be granted Object Permissions on Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub Admin_Stored_Procedures_Grant_Permissions
					
				sub Admin_Tables_Grant_Permissions
					{
						my ($DBAdminName, $DBAdminPassword, $AdminName, $DBName, $Debug) = @_;
						my $output;
						my $return_value = 1;
						#####################################################
						# Grant Admin Access to the necessary tables
						#####################################################
						foreach my $TableName (@AdminTableNameArray)
							{
								my $cmd = "osql -U $DBAdminName -P $DBAdminPassword -d \"$DBName\" -Q \"EXIT(GRANT SELECT ON $TableName TO $AdminName)\"";
								print "<!-- cmd = ($cmd) -->\n\n" if $Debug eq "1";
								$output = `$cmd`;
								if($output !~ m/\w/)
									{
										print "<!-- SUCCESS: $AdminName was granted SELECT Permissions to $TableName on Database $DBName -->\n";
										print "<!-- The following message was returned by the system: ($output)\n -->" if $output ne "";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> The admin name (<font color=\"blue\" size=\"2\">$AdminName</FONT>) could not be granted Object Permissions on Database (<font color=\"blue\" size=\"2\">$DBName</FONT>).<BR>\n";
										print "The system failed to execute the following command:<BR> <font color=\"red\" size=\"2\">$cmd</FONT><BR>\n";
										print "The following message was returned by the system:<BR> <font color=\"red\" size=\"2\">$output</FONT><BR>\n";
										$return_value = -1;
									}
							}
						return ($return_value);
					}# End sub User_Tables_Grant_Permissions
					
					
					
				sub Create_And_Execute_Dynamic_ODBC_VBScript
					{
						my (%DBName, $UserName, $user_password) = @_;
						my $opened = open (NEWFILE, "> DynamicODBC.vbs");		
						if ($opened)
							{
								#			my $return_value = "";
								#'***************************************************************
								#'*****
								#'*****  This script creates a DSN for connecting to a
								#'*****  SQL Server database. To view errors comment out line 16
								#'*****
								#'*****  Script Name: AutoDSN.vbs
								#'*****  Author: Darron Nesbitt
								#'*****  Depends: VBScript, WScript Host
								#'*****  Created: 10/2/2001
								#'*****
								#'***************************************************************
									
								#'Values for variables on lines 25 - 29, 32, and 36
								#'must be set prior to running this script.
									
								print NEWFILE "        On Error Resume Next\n";
									
								print NEWFILE "        Dim RegObj\n";
								print NEWFILE "        Dim SysEnv\n";
									
								print NEWFILE "        Set RegObj = WScript.CreateObject(\"WScript.Shell\")\n";
								#        '***** Specify the DSN parameters *****
								print NEWFILE "    DataSourceName = \"$db_name\"\n";
								print NEWFILE "    DatabaseName   = \"$db_name\"\n";
								print NEWFILE "    Description    = \"$db_name\"\n";
								#				print NEWFILE "    LastUser       = \"$user_name:$user_password\"\n";
								print NEWFILE "    LastUser       = \"$user_name\"\n";
								print NEWFILE "    Server         = \"(local)\"\n";
								#         'if you use SQL Server the driver name would be \"SQL Server\"
								print NEWFILE "    DriverName = \"SQL Server\"\n";
								#         'Set this to True if Windows Authentication is used
								#         'else set to False or comment out
								print NEWFILE "    WindowsAuthentication = False\n";
								#        'point to DSN in registry\n";
								print NEWFILE "    REG_KEY_PATH = \"HKLM\\SOFTWARE\\ODBC\\ODBC.INI\\\" & DataSourceName\n";
								#   ' Open the DSN key and check for Server entry
								print NEWFILE "        lResult = RegObj.RegRead(REG_KEY_PATH & \"\\Server\")\n";
								#        'if lResult is nothing, DSN does not exist; create it
								print NEWFILE "        If lResult = \"\" Then\n";
								#                'get os version through WSCript Enviroment object
								print NEWFILE "                Set SysEnv = RegObj.Environment(\"SYSTEM\")\n";
								print NEWFILE "                OSVer = UCase(SysEnv(\"OS\"))\n";
								#                'check which os is running so correct driver path can be set
								print NEWFILE "                Select Case OSVer\n";
								print NEWFILE "                  Case \"WINDOWS_NT\"\n";
								print NEWFILE "                      DrvrPath = \"C:\\WinNT\\System32\"\n";
								print NEWFILE "                  Case Else\n";
								print NEWFILE "                      DrvrPath = \"C:\\Windows\\System\"\n";
								print NEWFILE "                End Select\n";
								#                'create entries in registry
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH & \"\\DataBase\", DatabaseName, \"REG_SZ\"\n";
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH & \"\\Description\", Description, \"REG_SZ\"\n";
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH & \"\\LastUser\", LastUser, \"REG_SZ\"\n";
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH & \"\\Server\", Server, \"REG_SZ\"\n";
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH & \"\\Driver\", DrvrPath, \"REG_SZ\"\n";
								#                'if WindowsAuthentication set to True, a trusted connection entry is added to registry
								#                'else, SQL Authentication is used.
								print NEWFILE "                If WindowsAuthentication = True Then\n";
								print NEWFILE "                        RegObj.RegWrite REG_KEY_PATH & \"\\Trusted_Connection\", \"Yes\", \"REG_SZ\"\n";
								print NEWFILE "                End If\n";
								#                'point to data sources key
								print NEWFILE "                REG_KEY_PATH = \"HKLM\\SOFTWARE\\ODBC\\ODBC.INI\\ODBC Data Sources\\\" & DataSourceName\n";
								#                'and add the name of the new dsn and the driver to use with it
								print NEWFILE "                RegObj.RegWrite REG_KEY_PATH, DriverName, \"REG_SZ\"\n";
								print NEWFILE "                MsgBox DataSourceName & \" DSN Created!\"\n";
									
								print NEWFILE "        Else\n";
								print NEWFILE "                MsgBox DataSourceName & \" DSN already exists!\"\n";
								print NEWFILE "        End If\n";
									
								print NEWFILE "        Set RegObj = Nothing\n";
								print NEWFILE "        Set SysEnv = Nothing\n";
									
								close (NEWFILE);
								#				`C:\\Jason\\MyData\\Projects\\Other\\CreateDatabase\\CreateODBC.bat`;
								return "1";
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("ERROR: Could not open the Dynamic vbs file.<BR>\n", $DebugUtilityFunctions, %Map);
								return "-1";
							}
					}# END sub Create_And_Execute_Dynamic_ODBC_VBScript
					
				exit 0;			
					
				$return_value = &Create_New_Database($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
				if($return_value == 1)
					{
						print "SUCCESS: A new database named (<font color=\"blue\" size=\"2\">$db_name</FONT>) was created.<BR>\n";
					}
				elsif($return_value <= -1)
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): Database could not be created.<BR>\n";
						if($db_name_delete eq "on")
							{
								$return_value = &Delete_Database($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
								if($return_value == 1)
									{
										print "SUCCESS: The database named (<font color=\"blue\" size=\"2\">$db_name</FONT>) was deleted.<BR>\n";
										$return_value = &Create_New_Database($db_admin_name, $db_admin_password, $db_name, $DebugThisAp);
										if($return_value == 1)
											{
												print "SUCCESS: A new database named (<font color=\"blue\" size=\"2\">$db_name</FONT>) was created.<BR>\n";
											}
										elsif($return_value <= -1)
											{
												print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): Database could not be created.<BR>\n";
												if($db_name_ignore eq "on")
													{
														print "IGNORE: The above creation error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
													}
												else
													{
														print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the existing database (<font color=\"blue\" size=\"2\">$db_name</FONT>) could not be created.<BR>\n";
														$fatal_error = 1;						
													}
											}
										else
											{
												print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): This should never happen!<BR>\n";
											}
									}
								elsif($return_value == -1)
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Delete_Database returned ($return_value): Database could not be deleted.<BR>\n";
										if($db_name_ignore eq "on")
											{
												print "IGNORE: The above deletion error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
											}
										else
											{
												print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the existing database (<font color=\"blue\" size=\"2\">$db_name</FONT>) could not be deleted.<BR>\n";
												$fatal_error = 1;
											}
									}
							}
						else
							{
								if($db_name_ignore eq "on")
									{
										print "IGNORE: The above creation error for the database named (<font color=\"blue\" size=\"2\">$db_name</FONT>).<BR>\n";
									}
								else
									{
										print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Exiting because the existing database (<font color=\"blue\" size=\"2\">$db_name</FONT>) could not be created.<BR>\n";
										$fatal_error = 1;						
									}
							}
					}
				else
					{
						print "<STRONT><font color=\"red\" size=\"2\">ERROR:</FONT></STRONT> Create_New_Database returned ($return_value): This should never happen!<BR>\n";
					}
