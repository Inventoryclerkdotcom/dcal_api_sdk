#!/usr/bin/perl -w
no warnings 'once';

use strict;

# http://appppr.com/cgi-bin/ivc_api.pl
# https://server2.lukeburgess.com/~appppr/cgi-bin/ivc_api.pl

use WWW::InventoryClerk::API;

# todo: AuthId=apikey, AuthToken=secret

my $ivc = new WWW::InventoryClerk::API( AuthId => 'bla',
										AuthToken  => 'bla' );

# open LOG, ">>/home/appppr/public_html/cgi-bin/gco.txt";

# todo: namespace=booking, method=show

my $response = $ivc->GET('Booking');

# print qq~Content-type: text/html\r\n\r\n~;
# print qq~Content-type: text/plain\r\n\r\n~;
print $response->{content}; # json

# print LOG "";

# close LOG;
