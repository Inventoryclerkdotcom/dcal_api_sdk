#!/usr/bin/perl -w
no warnings 'once';

use strict;

# http://appppr.com/cgi-bin/ivc_api.pl
# https://server2.lukeburgess.com/~appppr/cgi-bin/ivc_api.pl

# open LOG, ">>/home/appppr/public_html/cgi-bin/gco.txt";

# todo: AuthId=apikey, AuthToken=secret

my $ivc = new WWW::InventoryClerk::API( AuthId => 'bla',
										AuthToken  => 'bla' );

# todo: namespace=booking, method=show

my $response = $ivc->GET('Booking');

print $response->{content}; # json

# print LOG "";

# close LOG;
