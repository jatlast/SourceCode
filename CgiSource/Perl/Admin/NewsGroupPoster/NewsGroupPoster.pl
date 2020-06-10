#!/usr/local/bin/perl -w
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use News::NNTPClient;

use strict;

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

require "DatabaseFunctions.pl";
require "CgiFunctions.pl";
require "UtilityFunctions.pl";
require "SendMailFunctions.pl";

my $DebugThisAp			   = "0";
my $DebugCgiFunctions 	   = "0";
my $DebugDatabaseFunctions = "0";
my $DebugUtilityFunctions  = "0";
my $DebugSendMailFunctions = "0";

my $ProgramName 	= "NewsGroupPoster.pl";

# Set autoflush to true in order to force flushing upon each print...
#$| = 1;

# Determine what libraries to use base on the execution dir...
my $CurrentFilePath = __FILE__;
# Initialize LinkMap Hash variable "Map"...
my %Map = &UtilityFunctions::Load_LinkMap($CurrentFilePath, 1); 

# Severe Error:  No LinkMap.dat file found -- EXIT --
if($Map{'CONFIG'} eq 'ERROR')
	{
		#Begin HTML so errors show up in browser...
		print CGI::header('text/html');
		print "<HTML>\n";
		&UtilityFunctions::Print_Error("LinkMap Error.<BR><BR>Contact Site Administrator.", $DebugUtilityFunctions, %Map);
		print "</HTML>\n";
	}
else
	{
		$Map{'PROGRAM_NAME'} = $ProgramName;
	}

# Parse the current date...
(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
# use parsed date to create unique name for transaction_id and SSLOG_FILE...
# Unique Name has the folling format username_m[m]_d[d]_yyyy_h[h]_m[m]_s[s]
my $UniqueID = "NewsGroupPoster_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
# use parsed date to create unique file name for SSLog file...
my $UniqueNewsLogFile = "$Map{'LOG_FOLDER'}/"  . $UniqueID . ".html";

my $batch_transaction_id = $UniqueID;

# Create and open the file that this program will populate...
open (NEWS_FILE, "> $UniqueNewsLogFile") || die "Can't open $UniqueNewsLogFile: $!\n";

print NEWS_FILE "<HTML>\n";
my $ClockStart = localtime();
print NEWS_FILE "Start: ($ClockStart)<BR>\n";

print NEWS_FILE "<!-- $Map{'CONFIG'} -->\n" if $DebugThisAp eq "1";
print NEWS_FILE "<!-- $Map{'SYSTEM'} -->\n" if $DebugThisAp eq "1";

my $EasyNews  = 1;
my $OptOnline = 0;

my $cookie_name 	= "administrator";
my $cookie_password = "janesays";

my $news_server   = "";
my $news_user 	  = "";
my $news_password = "";

my $news_group;
my $return_value  = "";
my $news_debug 	  = 1;

my $news_from = "$Map{'EMAIL'}";
my $news_organization = "$Map{'ROOT'}/CreateLogin.html";

if($EasyNews == 1 && $OptOnline == 0)
	{
		$news_server   = "news.easynews.com";
		$news_user 	   = "jatlast";
		$news_password = "9doublem";
	}
elsif($EasyNews == 0 && $OptOnline == 1)
	{
		$news_server   = "news.optonline.net";
		$news_user 	   = "baumbach";
		$news_password = "onetwo3";
	}
else
	{
		print "ERROR:  You must chose a news group to connect to.<BR>\n";
	}
print NEWS_FILE "News Server = ($news_server)<BR>\n";

#Initialize the news group connection...
my $nntp = new News::NNTPClient($news_server);
$nntp->authinfo($news_user, $news_password);
#set debug mode...
$return_value = $nntp->debug($news_debug);
	
###############################################
######### Get All NYC & Manhattan Grops #######
###############################################
my @news_groups;
my $group_name_count = 0;
# Get news group names based on whild_card...
#(my @list_array) = $nntp->list("active", "alt.imag.test*");
(my @list_array) = $nntp->list("active", "*nyc*");
	
# cycle through news group names...
foreach my $list_array (@list_array) 
	{
		# split the results into seperate variables...
		(my $list_group, my $list_last, my $list_first, my $list_post) = split( /\s/, $list_array);
		# make sure the group can be posted to...
		if($list_post eq 'y' or $list_post eq 'Y')
			{
				# Create the comma seperated news group list for the Newsgroups: header...
				push(@news_groups, "$list_group");
				$group_name_count++;
			}
	}

# Get news group names based on whild_card...
#(my @list_array_2) = $nntp->list("active", "ak.test*");
(my @list_array_2) = $nntp->list("active", "*manhattan*");
	
# cycle through news group names...
foreach my $list_array_2 (@list_array_2) 
	{
		# split the results into seperate variables...
		(my $list_group, my $list_last, my $list_first, my $list_post) = split( /\s/, $list_array_2);
		# make sure the group can be posted to...
		if($list_post eq 'y' or $list_post eq 'Y')
			{
				# Create the comma seperated news group list for the Newsgroups: header...
				push(@news_groups, "$list_group");
				$group_name_count++;
			}
	}
	
print NEWS_FILE "News Groups Count: ($group_name_count)<BR>\n";

###############################################
####### END Get All NYC & Manhattan Grops #####
###############################################
	
$nntp->quit();

&Put_All_Addresses_In_DB_From_NNTP_Groups(@news_groups);
exit 0;

# Variables for reporting stats on each program execution
my $number_of_successful_posts = 0;
my $number_of_failed_posts = 0;
my $total_groups_remaining = $group_name_count;

# Since the NNTP server will not allow one to post to more than 7 groups at once it is necessary to split it up...
while (@news_groups) 
	{
		my $count = 0;
		$news_group = pop(@news_groups);
		while($count < 6)
			{
				if(@news_groups)
					{
						$news_group .= ", " . pop(@news_groups);
					}
				$count++;
			}
		$total_groups_remaining = $total_groups_remaining - $count;
		print NEWS_FILE "Group String: ($news_group)<BR>\n";
		
		###################################################################################################
		############################## Start Males Seeking Females ########################################
		###################################################################################################
		my $ua = new LWP::UserAgent;
		# SimpleSearch.exe URL for males seeking females...
		my $URL = "$Map{'CGIBIN'}/SimpleSearch.exe?index=1&picture_only=1&i_am=1&seeking=2&city=&state=0&country=0&min_age_desired=18&max_age_desired=99&search_limit=5&sort_order=creation_date";
		print NEWS_FILE "<!-- URL = ($URL) --><BR>\n" if $DebugThisAp eq "1";
		
		my $request = new HTTP::Request('GET', $URL);
		$request->header('Cookie' => "cookie_name=$cookie_name; cookie_password=$cookie_password");
		my $response = $ua->request($request);
		if ($response->is_success) 
			{
				print NEWS_FILE "<!-- Received success from HTTP::Request --><BR>\n" if $DebugThisAp eq "1";
				my @user_names;
				# user the CGI results to initialize the article body...
				my @article_body = $response->content;
				my $result = "";
				# Post the message to the designated news groups...
				$result = &Post_NNTP_Message($Map{'EMAIL'}, "$Map{'WHICH_CONNECTIONS'} SimpleSearch Results for Single Females", $news_group, @article_body);
				if ($result =~ m/SUCCESS/) 
					{
						$number_of_successful_posts++;
						print NEWS_FILE "$result<BR>\n" if $DebugThisAp eq "1";
							
						# use the CGI results to initialize the article body parse and split it into a line by line array...
						my @article_body_parse = split(/\n/, $response->content);
							
						# cycle through CGI results to find the individual user names that came back from the search...
						foreach my $article_body_parse (@article_body_parse) 
							{
								# split the results into seperate variables...
								if($article_body_parse =~ m/Send (.*) email/g)
									{
										push(@user_names, "$1");
									}
							}
							
						foreach my $user_names (@user_names) 
							{
								# split the results into seperate variables...
								print NEWS_FILE "Female user_name = ($user_names)<BR>\n";
									
								my $ua = new LWP::UserAgent;
								# SingleProfile.exe URL for males seeking females...
								my $URL = "$Map{'CGIBIN'}/SingleProfile.exe?user_name=$user_names";
								print NEWS_FILE "<!-- URL = ($URL) -->\n" if $DebugThisAp eq "1";
									
								my $request = new HTTP::Request('GET', $URL);
								$request->header('Cookie' => "cookie_name=$cookie_name; cookie_password=$cookie_password");
								my $response = $ua->request($request);
								if ($response->is_success) 
									{
										print NEWS_FILE "<!-- Received success from HTTP::Request -->\n" if $DebugThisAp eq "1";
										# user the CGI results to initialize the article body...
										my @article_body = $response->content;
											
										$result = &Post_NNTP_Message($Map{'EMAIL'}, "$Map{'WHICH_CONNECTIONS'} Single Female: $user_names", $news_group, @article_body);
										if ($result =~ m/SUCCESS/) 
											{
												$number_of_successful_posts++;
												print NEWS_FILE "$result<BR>\n" if $DebugThisAp eq "1";
											} 
										elsif ($result =~ m/Sorry you are over the 24hr 200 post limit/) 
											{
												$number_of_failed_posts++;
												print NEWS_FILE "$result<BR>\n";
												goto OVER_24HR_POST_LIMIT_EXIT;
											}
										elsif ($result =~ m/ERROR/) 
											{
												$number_of_failed_posts++;
												print NEWS_FILE "$result<BR>\n";
											}
										else
											{
												$number_of_failed_posts++;
												print NEWS_FILE "Error not recognized ($result)<BR>\n";
											}
									} 
								else 
									{
										print NEWS_FILE $response->code."<BR>\n";
										print NEWS_FILE "ERROR:<BR>\n";
										print NEWS_FILE "URL: $URL<BR>\n";
										print NEWS_FILE $response->error_as_HTML;
									}
							}
							
					} 
				elsif ($result =~ m/Sorry you are over the 24hr 200 post limit/) 
					{
						$number_of_failed_posts++;
						print NEWS_FILE "$result<BR>\n";
						goto OVER_24HR_POST_LIMIT_EXIT;
					}
				elsif ($result =~ m/ERROR/) 
					{
						$number_of_failed_posts++;
						print NEWS_FILE "$result<BR>\n";
					}
				else
					{
						$number_of_failed_posts++;
						print NEWS_FILE "Error not recognized ($result)<BR>\n";
					}
			} 
		else 
			{
				print NEWS_FILE $response->code."<BR>\n";
				print NEWS_FILE "ERROR:<BR>\n";
				print NEWS_FILE "URL: $URL<BR>\n";
				print NEWS_FILE $response->error_as_HTML;
			}
			
		###################################################################################################
		############################## Start Females Seeking Males ########################################
		###################################################################################################
		my $ua_2 = new LWP::UserAgent;
		# SimpleSearch.exe URL for males seeking females...
		my $URL_2 = "$Map{'CGIBIN'}/SimpleSearch.exe?index=1&picture_only=1&i_am=2&seeking=1&city=&state=0&country=0&min_age_desired=18&max_age_desired=99&search_limit=5&sort_order=creation_date";
		print NEWS_FILE "<!-- URL_2 = ($URL_2) -->\n" if $DebugThisAp eq "1";
		
		my $request_2 = new HTTP::Request('GET', $URL_2);
		$request_2->header('Cookie' => "cookie_name=$cookie_name; cookie_password=$cookie_password");
		my $response_2 = $ua_2->request($request_2);
		if ($response_2->is_success) 
			{
				print NEWS_FILE "<!-- Received success from HTTP::Request --><BR>\n" if $DebugThisAp eq "1";
				my @user_names;
				# user the CGI results to initialize the article body...
				my @article_body = $response_2->content;
				my $result = "";
				# Post the message to the designated news groups...
				$result = &Post_NNTP_Message($Map{'EMAIL'}, "$Map{'WHICH_CONNECTIONS'} SimpleSearch Results for Single Males", $news_group, @article_body);
				if ($result =~ m/SUCCESS/) 
					{
						$number_of_successful_posts++;
						print NEWS_FILE "$result<BR>\n" if $DebugThisAp eq "1";
							
						# use the CGI results to initialize the article body parse and split it into a line by line array...
						my @article_body_parse = split(/\n/, $response_2->content);
							
						# cycle through CGI results to find the individual user names that came back from the search...
						foreach my $article_body_parse (@article_body_parse) 
							{
								# split the results into seperate variables...
								if($article_body_parse =~ m/Send (.*) email/g)
									{
										push(@user_names, "$1");
									}
							}
							
						foreach my $user_names (@user_names) 
							{
								# split the results into seperate variables...
								print NEWS_FILE "Male user_name = ($user_names)<BR>\n";
									
								my $ua_2 = new LWP::UserAgent;
								# SingleProfile.exe URL for males seeking females...
								my $URL_2 = "$Map{'CGIBIN'}/SingleProfile.exe?user_name=$user_names";
								print NEWS_FILE "<!-- URL_2 = ($URL_2) -->\n" if $DebugThisAp eq "1";
									
								my $request_2 = new HTTP::Request('GET', $URL_2);
								$request_2->header('Cookie' => "cookie_name=$cookie_name; cookie_password=$cookie_password");
								my $response_2 = $ua_2->request($request_2);
								if ($response_2->is_success) 
									{
										print NEWS_FILE "<!-- Received success from HTTP::Request --><BR>\n" if $DebugThisAp eq "1";
										# user the CGI results to initialize the article body...
										my @article_body = $response_2->content;
											
										$result = &Post_NNTP_Message($Map{'EMAIL'}, "$Map{'WHICH_CONNECTIONS'} Single Male: $user_names", $news_group, @article_body);
										if ($result =~ m/SUCCESS/) 
											{
												$number_of_successful_posts++;
												print NEWS_FILE "$result<BR>\n" if $DebugThisAp eq "1";
											} 
										elsif ($result =~ m/Sorry you are over the 24hr 200 post limit/) 
											{
												$number_of_failed_posts++;
												print NEWS_FILE "$result<BR>\n";
												goto OVER_24HR_POST_LIMIT_EXIT;
											}
										elsif ($result =~ m/ERROR/) 
											{
												$number_of_failed_posts++;
												print NEWS_FILE "$result<BR>\n";
											}
										else
											{
												$number_of_failed_posts++;
												print NEWS_FILE "Error not recognized ($result)<BR>\n";
											}
									} 
								else 
									{
										print NEWS_FILE $response_2->code."<BR>\n";
										print NEWS_FILE "ERROR:<BR>\n";
										print NEWS_FILE "URL: $URL_2<BR>\n";
										print NEWS_FILE $response_2->error_as_HTML;
									}
							}
							
					} 
				elsif ($result =~ m/Sorry you are over the 24hr 200 post limit/) 
					{
						$number_of_failed_posts++;
						print NEWS_FILE "$result<BR>\n";
						goto OVER_24HR_POST_LIMIT_EXIT;
					}
				elsif ($result =~ m/ERROR/) 
					{
						$number_of_failed_posts++;
						print NEWS_FILE "$result<BR>\n";
					}
				else
					{
						$number_of_failed_posts++;
						print NEWS_FILE "Error not recognized ($result)<BR>\n";
					}
			} 
		else 
			{
				print NEWS_FILE $response_2->code."<BR>\n";
				print NEWS_FILE "ERROR:<BR>\n";
				print NEWS_FILE "URL: $URL_2<BR>\n";
				print NEWS_FILE $response_2->error_as_HTML;
			}
	}

# GOTO for 24hr posting limit
#   Send mail detailing failure...
OVER_24HR_POST_LIMIT_EXIT:
	{
		print NEWS_FILE "Exiting Program because 24hr posting limit has been reached.<BR>\n";

		# Build email to send to the person receiving the new PC Mail...
		my $BlatPath 		= "$Map{'BLAT_PATH'}/EXE/blat.exe";
		my $MailServer 		= "$Map{'SMTP_HOST'}";
		my $From		   	= $Map{'EMAIL'};
		my $To			 	= "jatlast\@hotmail.com";
		my $Bcc			 	= "baumbach\@optonline.net";
		my $Subject			= "Newsgroup Posting problems for $Map{'WHICH_CONNECTIONS'}.";
		my $TempFile		= "";
		my $Body        	= "Exited $ProgramName because 24hr posting limit had been reached.\n\nTotal Number of Groups           = ($group_name_count)\nTotal Number of Groups Processed = (" . ($group_name_count - $total_groups_remaining) . ")\nTotal Number of Groups Remaining = (" . ($total_groups_remaining) . ")\nTotal Number of Successful Posts = (" . ($number_of_successful_posts) . ")\nTotal Number of Failed Posts     = (" . ($number_of_failed_posts) . ")\n";
		my $TempFilePath 	= "C:\\Temp";
		my $BlatLogFilePath = "$Map{'BLAT_PATH'}/EXE/blat.log";

		(my $return_value, my $output) = &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $From, $To, $Bcc, $Subject, $TempFile, $Body, $TempFilePath, $BlatLogFilePath, $DebugSendMailFunctions);
		if($return_value < 1)
			{
				print NEWS_FILE "\n<!-- Mail_Blat Success return_value = $return_value \n output = $output\n-->\n" if $DebugThisAp eq "1";
			}
		else
			{
				print NEWS_FILE "\n<!-- Mail_Blat Error return_value = $return_value \n output = $output\n-->\n" if $DebugThisAp eq "1";
			}
	}

print NEWS_FILE "<BR>Total Number of Groups           = ($group_name_count).<BR>\n";
print NEWS_FILE "Total Number of Groups Processed = (" . ($group_name_count - $total_groups_remaining) . ").<BR>\n";
print NEWS_FILE "Total Number of Groups Remaining = (" . ($total_groups_remaining) . ").<BR>\n";
print NEWS_FILE "Total Number of Successful Posts = (" . ($number_of_successful_posts) . ").<BR>\n";
print NEWS_FILE "Total Number of Failed Posts     = (" . ($number_of_failed_posts) . ").<BR>\n";

my $ClockEnd = localtime();
print NEWS_FILE "End: ($ClockEnd)<BR>\n";
print NEWS_FILE "</HTML>\n";
close(NEWS_FILE);


sub Post_NNTP_Message
	{
		(my $From, my $Subject, my $Newsgroups, my @body) = @_;
		#		print NEWS_FILE "Post_NNTP_Message ($From, $Subject, $Newsgroups, @body)<BR>\n" if $DebugThisAp eq "1";
		
		use LWP::UserAgent;
			
		#Initialize the news group connection...
		my $nntp = new News::NNTPClient($news_server);
		$nntp->authinfo($news_user, $news_password);
		#set debug mode...
		$return_value = $nntp->debug($news_debug);
			
		my @headers;
		# Create the header...
		push(@headers, "From: $From\n");
		push(@headers, "Newsgroups: $Newsgroups\n");
		push(@headers, "Subject: $Subject\n");
		#push(@headers, "Followup-To: $followup_to\n") 	if $followup_to;
		#push(@headers, "References: $msgid\n") 		if $msgid;
		#push(@headers, "Summary: $summary\n") 			if $summary;
		push(@headers, "Organization: $news_organization\n");
		#push(@headers, "Distribution: $distro\n") 		if $distro;
		#push(@headers, "Reply-To: $replyto\n") 		if $replyto;
		#push(@headers, "Cc: $cc\n") 					if $cc;
		#push(@headers, "User-Agent: $USER_AGENT\n");
		push(@headers, "Content-Type: text/html\n");
			
		my $result = "";
		# Post the message to the designated news groups...
		$result = $nntp->post(@headers, "\n", @body);
		if ($result) 
			{
				$result = $nntp->code . " " . $nntp->message;
				chomp $result;
				$nntp->quit();		
				print NEWS_FILE "@body\n" if $DebugThisAp eq "1";
				return "SUCCESS: message was posted. [$result]</P>\n";
			} 
		else 
			{
				$result = $nntp->code . " " . $nntp->message;
				chomp $result;
				$nntp->quit();		
				return "ERROR: message was not posted. [$result]</P>\n";
			}
	}

sub Put_All_Addresses_In_DB_From_NNTP_Groups
	{
		(my @NewsGroups) = @_;
		#print NEWS_FILE "Put_All_Addresses_In_DB_From_NNTP_Groups (@NewsGroups)<BR>\n" if $DebugThisAp eq "1";
		
		#Initialize the news group connection...
		my $nntp = new News::NNTPClient($news_server);
		$nntp->authinfo($news_user, $news_password);
		#set debug mode...
		$return_value = $nntp->debug($news_debug);

		my $size = 0;
		my $news_group = "";
		my @all_email_addresses;

		# Extract all email addresses for all passed in group names...
		while (@NewsGroups) 
			{
				my $count = 0;
				$news_group = pop(@NewsGroups);
				$count++;
		
				(my $first_article_number, my $last_article_number) = $nntp->group($news_group);
#				print NEWS_FILE "group = ($news_group)<BR>\n";
#				print NEWS_FILE "first = ($first_article_number)<BR>\n";
#				print NEWS_FILE "last  = ($last_article_number)<BR>\n";
				my @current_email_addresses = $nntp->xhdr("From", $first_article_number, $last_article_number);
#				print NEWS_FILE "xhdr  = (@current_email_addresses)<BR>\n";
				# cycle through news group email addresses...
				foreach my $current_email_addresses (@current_email_addresses) 
					{
						if($current_email_addresses =~ m/<(.*)>/)
							{
								# Create the comma seperated news group list for the Newsgroups: header...
								push(@all_email_addresses, "$1");
							}
					}
			}

		# Extract unique email addresses from the array containing duplicates...
		@all_email_addresses = sort(@all_email_addresses);

		$size = scalar $#all_email_addresses + 1;
		print NEWS_FILE "size(all)  = ($size)<BR>\n";
#		print NEWS_FILE "all_email_addresses  = (@all_email_addresses)<BR>\n";
		my $current_address = "";
		my $last_address	= "";
		my @unique_email_addresses;

		while(@all_email_addresses) 
			{
#					&& $current_address

				$current_address = pop(@all_email_addresses);
				$current_address = &CheckEmailAddress($current_address);
				if($current_address)
					{
					if($current_address ne $last_address 
						&& $current_address !~ m/spam/i
						&& $current_address !~ m/1234/
						&& $current_address !~ m/remove/i
						&& $current_address !~ m/junk/i
						&& $current_address !~ m/not/i
						&& $current_address !~ m/domain/i
						&& $current_address !~ m/www/i
						&& $current_address !~ m/http/i
						&& $current_address !~ m/delete/i
						&& $current_address !~ m/xxx/i
						&& $current_address !~ m/yyy/i
						&& $current_address !~ m/zzz/i
						&& $current_address !~ m/you/i
						&& $current_address !~ m/\'/
						&& $current_address !~ m/\"/
						&& $current_address !~ m/\*/
						&& $current_address !~ m/\</
						&& $current_address !~ m/\>/
						&& $current_address !~ m/\|/
						&& $current_address !~ m/\:/
						&& $current_address =~ m/\@/
						&& $current_address ne ""
						&& $current_address ne " "
						)
						{
							$current_address =~ s/you_know_what_to_cut_//;
							$current_address =~ s/-this-is-the-part-you-cut-out//;
							push(@unique_email_addresses, "$current_address");
							$last_address = $current_address;
							print NEWS_FILE "unique_email_address  = ($current_address)<BR>\n";
						}
					}
			}
		$size = scalar $#unique_email_addresses + 1;
		print NEWS_FILE "size(unique)  = ($size)<BR>\n";
		#print NEWS_FILE "unique_email_addresses  = (@unique_email_addresses)<BR>\n";
	}

sub CheckEmailAddress() 
	{ 
		# This regexp validates the format of an email address. It returns the cleaned 
		# version of the email address, or blank if the address was not valid. 
		# 
		# An email address must be of the form: 
		# 1) (trim any spaces or tabs or linefeeds or carriage returns) 
		# 2) (possibly one quotation mark) 
		# 3) (one or more characters for username, excepting a quotation mark) 
		# 4) (possibly one quotation mark) 
		# 5) @ 
		# 6) (one or more characters for hostname(s), excepting [ <>\t]) 
		# 7) . 
		# 8) (two or more characters for top-level-domain, excepting [ <>\t]) 
		# 9) (trim any spaces or tabs or linefeeds or carriage returns) 
		# 
		# 1 2 3 4 56 7 8 9 
		# .............'''.......'''.'''''''''..''''''''''''''''''............. 
		$_[0] =~ /[ |\t|\r|\n]*\"?([^\"]+\"?@[^ <>\t]+\.[^ <>\t][^ <>\t]+)[ |\t|\r|\n]*/; 
		return $1; 
	} 
