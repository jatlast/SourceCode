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

my $ProgramName 	= "UK_NewsGroupPoster_Two.pl";

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
my $UniqueID = "UK_NewsGroupPoster_Two_"  . ($mon+1)  . "_" . $mday  . "_" . ($year+1900) . "_" . $hour  . "_" . $min . "_" . $sec;
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
############ Get All UK Groups ############
###############################################
my @news_groups;
my $group_name_count = 0;

# Get news group names based on whild_card...
(my @list_array) = $nntp->list("active", "uk.*");
	
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

$nntp->quit();
	
###############################################
############ END All UK Groups ############
###############################################

#######################################################
############ Limit Group Size <= 200 Per Post #########
#######################################################
my $ArraySize = 0;

# get the size of the array to see if it needs to be split...
$ArraySize = scalar $#news_groups + 1;

# If the array is greater than 200 it needs to be split...
if($ArraySize > 200)
	{
		print NEWS_FILE "Group must be split because there are $ArraySize groups.<BR>\n";
		#Use the mod function on the day of the month value to alternate which groups are spammed...
		#	Even days spam the First 200 groups
		#	Odd days spam the Remaining 200 groups
		if($mday % 2 eq 0)
			{
				print NEWS_FILE "Spamming first " . ($ArraySize/2) . " groups.<BR>\n";
			}
		else
			{
				print NEWS_FILE "Spamming remaining " . ($ArraySize/2) . " groups.<BR>\n";
				@news_groups = reverse(@news_groups);
			}
		# remove second half of the array...
#		splice(@news_groups, ($ArraySize/2));
	}
else
	{
		print NEWS_FILE "There are only $ArraySize groups.<BR>\n";
	}

# Print list of Highlighted news groups...
if(1)
	{
		# cycle through news group names...
		foreach my $news_groups (@news_groups) 
			{
				my $highlighted_news_groups = $news_groups;
				$highlighted_news_groups =~ s!uk\.!<FONT color="red">uk\.</FONT>!m;
				print NEWS_FILE "$highlighted_news_groups<BR>\n";
			}
	}

# Get new ArraySize...
$ArraySize = scalar $#news_groups + 1;
$group_name_count = $ArraySize;
print NEWS_FILE "News Groups Count: (" . $ArraySize . ")<BR>\n";

exit(0);

##########################################################
############ End Limit Group Size <= 200 Per Post ########
##########################################################
	
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