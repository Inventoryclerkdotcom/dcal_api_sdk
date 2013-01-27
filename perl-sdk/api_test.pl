#!/usr/bin/perl -w
no warnings 'once';

use strict;

# http://appppr.com/cgi-bin/ivc_api.pl
# https://server2.lukeburgess.com/~appppr/cgi-bin/ivc_api.pl

# open LOG, ">>/home/appppr/public_html/cgi-bin/gco.txt";

my $ivc = new WWW::InventoryClerk::API( AccountSid => 'bla',
										AuthToken  => 'bla' );

my $response = $ivc->GET('Booking');

print $response->{content};

# print LOG "";

# close LOG;
