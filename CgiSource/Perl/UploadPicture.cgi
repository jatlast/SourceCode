#!/usr/local/bin/perl -w
use CGI qw/:standard/;
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

my $ProgramName = "UploadPicture.cgi";

#Begin HTML so errors show up in browser...
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
		$Map{'PROGRAM_NAME'} = $ProgramName;
		print "<!-- $Map{'SYSTEM'} -->\n" if $DebugThisAp eq "1";
	}

$CGI::POST_MAX=1024 * 10000;  # max 250K posts

my $submit 	= CGI::param('submit');
# declare global variables...
my $file_name 	   = "";
my $picture_number = "";
my $type 		   = "";
my $picture_name   = "";
my $PhotoToDelete  = "";

if($submit eq "Replace Photo")
	{
		$file_name 	= CGI::param('picture');
		$picture_number = CGI::param('upload_picture_number');
		print "<!-- submit 			= ($submit) -->\n" if($DebugThisAp eq "1"); 
		print "<!-- file_name 		= ($file_name) -->\n" if($DebugThisAp eq "1"); 
		print "<!-- picture_number 	= ($picture_number) -->\n" if($DebugThisAp eq "1"); 
	}
elsif($submit eq "Delete Photo")
	{
		$picture_number = CGI::param('delete_picture_number');
		# See if the hidden photo variable exists...
		$PhotoToDelete 	= CGI::param("photo_" . $picture_number);
		print "<!-- submit 			= ($submit) -->\n" if($DebugThisAp eq "1"); 
		print "<!-- picture_number 	= ($picture_number) -->\n" if($DebugThisAp eq "1"); 
		print "<!-- PhotoToDelete 	= ($PhotoToDelete) -->\n" if($DebugThisAp eq "1"); 
	}
else
	{
		&UtilityFunctions::Print_Framed_Error("This page is not directly accessable.\n<!-- This should never happen.  submit=($submit) -->\n", $DebugUtilityFunctions, %Map);
	}

my $name_user = "";
my $password = "";
	
# Added param for Admin_FreeFormAudit.cgi access...
my $Admin_Field = CGI::param('admin_field');
#	print "<!-- Admin_Field = ($Admin_Field) -->\n";

if($Admin_Field eq "baumbach")
	{
		$name_user = CGI::param('user_name');
		$password = CGI::param('password');
    	print "<!-- This should only happen when accessing through the \"Delete\" functionality of Admin_FreeFormAudit.cgi -->\n" if $DebugThisAp eq "1";
    	print "<!-- user_name = ($name_user) -->\n" if $DebugThisAp eq "1";
    	print "<!-- password = ($password) -->\n" if $DebugThisAp eq "1";
	}
else
	{
		$name_user = &CgiFunctions::Get_Cookie_Value("cookie_name", $DebugCgiFunctions);
		$password = &CgiFunctions::Get_Cookie_Value("cookie_password", $DebugCgiFunctions);
	#print "<!-- user_name = ($name_user) -->\n";
#	print "<!-- password = ($password) -->\n";
	}


if($submit eq "Replace Photo")
	{
			# die if no file_name was supplied...
		  	&UtilityFunctions::Print_Framed_Error("Field 'File Name' must be filled in for this script to work properly.", $DebugUtilityFunctions, %Map) if($file_name eq "");
		
			# find the file extension...
		$file_name =~ m/(\.\w+)/;
		$type = $1;
			
		# check file type...
		&UtilityFunctions::Print_Framed_Error("We do not accept pictures of type <FONT color=red>\"$type\"</FONT> at this time.<BR>Please choose a new picture to upload.", $DebugUtilityFunctions, %Map) if(&Check_File_Type($type, $DebugThisAp) eq "-1");
			
		$picture_name = "$name_user"."_"."$picture_number"."$type";
			
		my $SqlStatement = "checkUsernamePassword \"$name_user\", \"$password\""; 
		my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'UploadPicture.cgi', $SqlStatement, $DebugDatabaseFunctions);
		if($return_value eq "1")
			{
				$return_value = &Save_Picture(%Map, $DebugThisAp);
				if($return_value == 1)
					{
							my $SqlStatement = "updatePicture \"$name_user\", \"$password\", \"$picture_number\", \"$picture_name\""; 
						$return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'UploadPicture.cgi', $SqlStatement, $DebugDatabaseFunctions);
						if($return_value eq "1")
							{
								&UtilityFunctions::Print_HTML("Your picture has been added to your profile.", $DebugUtilityFunctions, %Map);
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("Error updating the DB for \"$name_user\".<BR>\n", $DebugUtilityFunctions, %Map);
							}
					}
				else
					{
						&UtilityFunctions::Print_Framed_Error("Error handling the file \"$picture_number\".<BR>\n", $DebugUtilityFunctions, %Map);
					}
			}
		else
			{
				&UtilityFunctions::Print_Framed_Error("ERROR: Username and password did not match for \"$name_user\".<BR>You need to re-login.<BR>\n", $DebugUtilityFunctions, %Map);
			}
	}
elsif($submit eq "Delete Photo")
	{
		if($PhotoToDelete)
			{
				my $SqlStatement = "checkUsernamePassword \"$name_user\", \"$password\""; 
				my $return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'UploadPicture.cgi', $SqlStatement, $DebugDatabaseFunctions);
				if($return_value eq "1")
					{
						$return_value = &Delete_Picture(%Map, $DebugThisAp);
						if($return_value == 1)
							{
								my $SqlStatement = "updatePicture \"$name_user\", \"$password\", \"$picture_number\", \"Nothing\""; 
								$return_value = &DatabaseFunctions::Run_This_Sql_Statement($Map{'DBUSER'}, $Map{'DBPWD'}, $Map{'DBNAME'}, 'UploadPicture.cgi', $SqlStatement, $DebugDatabaseFunctions);
								if($return_value eq "1")
									{
										&UtilityFunctions::Print_HTML("Your picture has ben deleted from your profile.", $DebugUtilityFunctions, %Map);
									}
								else
									{
										&UtilityFunctions::Print_Framed_Error("Error updating the DB for \"$name_user\".<BR>\n", $DebugUtilityFunctions, %Map);
									}
							}
						else
							{
								&UtilityFunctions::Print_Framed_Error("Error deleting the file \"$picture_number\".<BR>\n", $DebugUtilityFunctions, %Map);
							}
					}
				else
					{
						&UtilityFunctions::Print_Framed_Error("ERROR: Username and password did not match for \"$name_user\".<BR>You need to re-login.<BR>\n", $DebugUtilityFunctions, %Map);
					}
			}
		else
			{
				&UtilityFunctions::Print_Framed_Error("Picture #$picture_number is an invalid choice.<BR>\nYou must pick a valid picture number from the drop down menu.\n<!-- Error: user chose a picture they do not have uploaded. -->\n", $DebugUtilityFunctions, %Map);
			}
	}
else
	{
		&UtilityFunctions::Print_Framed_Error("This page is not directly accessable.\n<!-- This should NEVER NEVER happen.  submit=($submit) -->\n", $DebugUtilityFunctions, %Map);
	}
	

#End HTML...
print "</HTML>\n";
exit 0;

sub Check_File_Type
	{
		my ($file_name, $DebugThisAp) = @_;
		if(
		   $file_name =~ m/\.jpg$/i
		|| $file_name =~ m/\.jpe$/i
		|| $file_name =~ m/\.jpeg$/i
		|| $file_name =~ m/\.gif$/i
#		|| $file_name =~ m/\.pcx$/ 
#		|| $file_name =~ m/\.dcx$/ 
#		|| $file_name =~ m/\.xif$/ 
#		|| $file_name =~ m/\.wif$/ 
#		|| $file_name =~ m/\.tif$/ 
#		|| $file_name =~ m/\.tiff$/ 
#		|| $file_name =~ m/\.jfx$/ 
#		|| $file_name =~ m/\.bmp$/ 
		)
			{
				return "1";
			}
		else
			{
				return "-1"
			}
	}

sub Save_Picture
	{
		use Image::Magick;
		my (%Map, $DebugThisAp) = @_;

		my $ImageName = $name_user . "_" . $picture_number . $type;
		my $opened = open (NEWFILE, "> $Map{'PICTURES_FOLDER'}"."$name_user"."_"."$picture_number"."$type");		
		if ($opened)
			{
				while(read($file_name,my $data,2048))
					{
						binmode NEWFILE;
						print NEWFILE $data;
					} 
				close (NEWFILE);

				# Make a 60x60 thumbnail using ImageMagick and PerlMagick
				#  download from http://www.dylanbeattie.net/magick/downloads.html
				my($image, $x);
				$image = Image::Magick->new;
				$x = $image->Read($Map{'PICTURES_FOLDER'} . $ImageName);
				warn "$x" if "$x";
				$x = $image->Scale(geometry=>'60x60');
				warn "$x" if "$x"; 			
				$x = $image->Write($Map{'PICTURES_FOLDER'} . '60x60_' . $ImageName);
				warn "$x" if "$x";
				@$image = ();

				# Make a 180x180 thumbnail using ImageMagick and PerlMagick
				$image = Image::Magick->new;
				$x = $image->Read($Map{'PICTURES_FOLDER'} . $ImageName);
				warn "$x" if "$x";
				$x = $image->Scale(geometry=>'180x180');
				warn "$x" if "$x"; 			
				$x = $image->Write($Map{'PICTURES_FOLDER'} . '180x180_' . $ImageName);
				warn "$x" if "$x";
				undef($image);

				return "1";
			}
		else
			{
				&UtilityFunctions::Print_Framed_Error("Error uploading your picture.\n <!-- Could not open ($Map{'PICTURES_FOLDER'}$picture_name) Error: ($!) -->\n<BR>\n", $DebugUtilityFunctions, %Map);
				return "-1";
			}
	} # End Save_Picture.

sub Delete_Picture
	{
		my (%Map, $Debug) = @_;
		
		my $FileToDelete = "$Map{'DOS_PICTURES_FOLDER'}"."$name_user"."_"."$picture_number".".*"; 
		my $FileToDeleteLarge = "$Map{'DOS_PICTURES_FOLDER'}"."180x180_"."$name_user"."_"."$picture_number".".*"; 
		my $FileToDeleteSmall = "$Map{'DOS_PICTURES_FOLDER'}"."60x60_"."$name_user"."_"."$picture_number".".*"; 
		my $SystemCall = "del $FileToDelete";
		my $SystemCallLagre = "del $FileToDeleteLarge";
		my $SystemCallSmall = "del $FileToDeleteSmall";
			
		my $output = `$SystemCall`; 
		if($output eq "")
			{
				# Delete 180x108 version...
				`$SystemCallLagre`; 
				# Delete 60x60 version...
				`$SystemCallSmall`; 

				return "1";
			}
		else
			{
				&UtilityFunctions::Print_Framed_Error("Error deleting your picture.\n <!-- FAILURE: DOS system call: ($SystemCall) failed with the following error: ($output) -->\n<BR>\n", $DebugUtilityFunctions, %Map);
				return "-1";
			}
	} # End Delete_Picture.
	