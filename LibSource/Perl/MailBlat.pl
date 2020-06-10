###############################################################
# This program uses blat.exe to send a to a list of addresses #
# And returns a confirmation HTML page                	      #
# Greg Elin 2.2.97					      #
#                                                             #
###############################################################

# Program variable explanation ################################

# $recipients = list of email address to send message;
# $ccaddress = carbon copy address;
# $knownsender = a 'From' address;
# $fromsender = from sender known to STMP server;
# $subject = subject line of message;
# $message = name of message file to send;
# $blatpath = full path name to execute blat;
# $server = server name if different than installed one;



# Define variables ###########################################

$recipients = "baumbach\@bellatlantic.net";
#$ccaddress = "jatlast\@hotmail.com";
$knownsender = "baumbach\@bellatlantic.net";
$fromsender = "Admin\@PersianConnections.Com";
$subject = "Still testing.";
$message = "D:\\Data\\Personal\\Projects\\JP\\ConnectionsCgiScripts\\PerlCode\\Utilities\\testblat.txt ";
$blatpath = "C:\\WINNT\\system32\\blat.exe ";
#$server = "138.89.13.95";

# print an html-complient execution confirmation page ########

print "Content-Type: text/html\n\n"; # add header for HTML document
print "<html>\n";
print "<head><title> $input{'type'} Search Results </title></head>\n";
print "<body BACKGROUND=\"images/tile.gif\">\n";	
print "<hr>\n";

print "An E-mail message is about to be sent by blat.exe\:\n";
print "<PRE><P>\n";
print "To\:      $recipients \n";
print "Subject\: $subject \n";
print "File\:    $message \n";
# print "Server\:  $server \n";
print "<P>\n";
print "</PRE><P>\n";


# Get message ready	###############################################

$commandline = $blatpath;
$commandline .= $message;
$commandline .= "-s \"$subject\" " if $subject;
$commandline .= "-t \"$recipients\" " if $recipients;
$commandline .= "-f \"$fromsender\" " if $fromsender;
$commandline .= "-c \"$ccaddress\" " if $ccaddress;
$commandline .= "-noh2 ";

#$commandline .= "-debug ";
#$commandline .= "-f \"$fromsender\" " if $fromsender;
#$commandline .= "-c \"$ccaddress\" " if $ccaddress;
# $commandline .= "-server $server " if $server;

print "\$commandline \= $commandline";
print "<P>\n";
print "<P>\n";
print "<P>\n";

# Send mail using blat and the system command ############

system($commandline);
print "<P>\n";
print "<P>\n";
print "Blat has been executed.  <P>\n";


# Finish printing html-complient execution confirmation page ######

print "<P>\n";
print "<P>\n";
print "<P>\n";
print "</body>\n";
print "</HTML>\n";


