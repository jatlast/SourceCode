#!/usr/local/bin/perl -w
use strict;

require "SendMailFunctions.pl";

package BatchFunctions;

sub RunBatchFile
{
my($batch_file_to_run, $debug_this_sub) = @_;
print "RunBatchFile(\"$batch_file_to_run\", \"$debug_this_sub\")\n" if $debug_this_sub eq "1";
# Get batch file start time...
my $StartTime = localtime();
# Start message body with a date stamp... 
my $output = "\n---------- FTP STARTED: $StartTime ----------\n";
# Run FTP batch file...
$output = $output . `$batch_file_to_run`;
# Get batch file finish time
my $EndTime = localtime();
$output = $output . "\n---------- FTP ENDED: $EndTime ----------\n";

#print "System Call: $BatchFileDir\n" if $DebugThisAp eq "1";
print "Batch file output: $output\n" if $debug_this_sub eq "1";

return $output;
}

sub EmailBatchInfo
{
my($ftp_info_message, $debug_this_sub) = @_;

print "EmailBatchInfo(\"$ftp_info_message\", \"$debug_this_sub\")\n" if $debug_this_sub eq "1";

my $output;		  # used with &Mail_Blat sub
my $return_value; # used with &Mail_Blat sub

# Build email to send to the person receiving the new PC Mail...
my $BlatPath 	= "C:\\WINNT\\system32\\blat.exe ";
my $MailServer 	= "mail.bellatlantic.net";
my $Sender   	= "FTP\@PC.com";
my $Receiver 	= "baumbach\@bellatlantic.net";
my $Pager		= "6467525973\@voicestream.net";
my $Subject		= "FTP Notice";
my $TempFile	= "";
my $PagerMessage		= "";
my $TempFilePath= "C:\\Temp";
my $exit_val = 0;

# Send mail to NotifyReceiver and NotifyPager...
		($return_value,$output)= &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $Sender, $Receiver, "", $Subject, $TempFile, $ftp_info_message, $TempFilePath);
		if($return_value < 1)
			{
				print "\nSUCCESS while sending to $Receiver: Mail_Blat return_value = $return_value \n output = $output\n" if $debug_this_sub eq "1";
				$PagerMessage = "Mail SUCCESS: Mail sent to $Receiver.";
				$exit_val = 0;
			}
		else
			{
				print "\nERROR while sending to $Receiver: Mail_Blat return_value = $return_value \n output = $output\n" if $debug_this_sub eq "1";
				$PagerMessage = "Mail ERROR: Mail could NOT be sent to $Receiver.";
				$exit_val = 1;
			}

		($return_value,$output)= &SendMailFunctions::Mail_Blat($BlatPath, $MailServer, $Sender, $Pager, "", $Subject, $TempFile, $PagerMessage, $TempFilePath);
		if($return_value < 1)
			{			 
				print "\nSUCCESS: Mail_Blat return_value = $return_value \n output = $output\n" if $debug_this_sub eq "1";
			}
		else
			{
				print "\nERROR: Mail_Blat return_value = $return_value \n output = $output\n" if $debug_this_sub eq "1";
			}			
return $exit_val;
}

# Scripts that are to be include with other scripts must end with "1;"
1;
