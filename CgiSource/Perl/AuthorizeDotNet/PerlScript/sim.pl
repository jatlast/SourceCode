#!/usr/local/bin/perl -w  
#
#
#  DISCLAIMER:
#     This code is distributed in the hope that it will be useful, but 
#	without any warranty; without even the implied warranty of 
#	merchantability or fitness for a particular purpose.
#
#   Main perl script that demonstrates how to use the SIM library to  
#	integrate with Authorize.net. 
#   Input (Form or QueryString):
#      x_Amount
#      x_Description
#
#   If you just want to calculate the Fingerprint without auto generating the
#    hidden fields, call:
#       &SimLib::GenerateInspFP($loginid, $txnkey, $amount, $sequence, $tstamp, $currency);
#


use strict;

# $Id: sim.pl,v 1.4 2002/11/21 23:31:53 adama Exp $

# Add directories to perl environment path...
# Smithers
unshift @INC, "D:/Required/INC/";
# Grimes
unshift @INC, "C:/Required/INC/";

#use SimLib;
require "SimLib.pm";

# You may want to store this more securely in a DB or Registry or a Encrypted File
# --------------------------------------------------------------------------------
my $loginid = "tgecko";
my $txnkey = "UH53QSBLJrFsvqFT"; # put this in linkmap
my $amount = "19.95";
my $sequence = int(rand 1000);
my $tstamp = time;
my $currency = "USD";

my %ENTRY = &SimLib::get_submission;

my $x_amount = $ENTRY{'x_amount'};

if (index($x_amount,'$') == 0){
	$x_amount = substr($x_amount,1);
}

my $x_description = $ENTRY{'x_description'};

# use the line below to get x_currency code out of the GET/POST or
#  set it yourself (my $x_currency_code = "USD";
my $x_currency_code = $ENTRY{'x_currency_code'};

print "content-type: text/html\n\n";
print "<HTML> <HEAD> <TITLE>Order Form</TITLE>\n";

print "</HEAD>\n";
print "<BODY>\n<H3>Final Order</H3>\n";

print "Description: ".$x_description."  <BR />\n";
print "Total Amount : ".$x_amount." <BR /><BR />\n";

print "<FORM action=\"https://certification.authorize.net/gateway/transact.dll\" method=\"POST\">\n";

# If you don't use a currency code variable, you can still use this call to InsertFP, 
#  it will use it if supplied but works without it.  If you do supply it, InsertFP will
#  also print out an html hidden field containing the x_currency_code you passed in.

my $FingerPrint = &SimLib::GenerateInspFP($loginid, $txnkey, $amount, $sequence, $tstamp, $currency);
print "<H1>$FingerPrint</H1>";
#&SimLib::InsertFP($loginid, $txnkey, $x_amount, $x_currency_code);

# Insert other form elements similiar to legacy weblink integration

print "<input type=\"hidden\" name=\"x_description\" value=\"" . $x_description . "\">\n";
print "<input type=\"hidden\" name=\"x_login\" value=\"" . $loginid . "\">\n";
print "<input type=\"hidden\" name=\"x_amount\" value=\"" . $x_amount . "\">\n";
print "<input type=\"hidden\" name=\"x_show_Form\" value=\"PAYMENT_FORM\">\n";
print "<input type=\"hidden\" name=\"x_test_request\" value=\"TRUE\">\n";
print "<input type=\"submit\" value=\"Accept Order\">\n";
print "</FORM> </BODY> </HTML>";

1;
