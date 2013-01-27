package WWW::InventoryClerk::API;

use strict;
use warnings;

use Crypt::SSLeay ();
use LWP::UserAgent ();
use URI::Escape 'uri_escape';

sub API_URL { 'https://www.inventoryclerk.com/dcal/api/v1' }

my %auth_id = ();
my %auth_token = ();

sub new {
	my $class = shift;
	my %args  = @_;
	
	my $self = bless \(my $ref), $class;
	
	$auth_id{$self} = $args{AuthId} || '';
	$auth_token{$self} = $args{AuthToken} || '';
	
	return $self;
}

sub GET {
	_do_request(shift, METHOD => 'GET', API => shift, @_);
}

sub _do_request {
	my $self = shift;
	my %args = @_;
	
	my $lwp = LWP::UserAgent->new;
	$lwp->agent("perl-WWW-InventoryClerk-API");
	
	my $api = delete $args{API} || '';
	my $method = delete $args{METHOD};
	my $url = API_URL();
	
	my $content = '';
	if (keys %args) {
		$content = _build_content(%args);
		$url = $url.'?'.$content if ($method eq 'GET');
	}
	
	my $req = HTTP::Request->new($method => $url);
	$req->authorization_basic($auth_id{$self}, $auth_token{$self});
	if( $content && $method ne 'GET' ) {
		$req->content_type( 'application/x-www-form-urlencoded' );
		$req->content($content);
	}
	
	my $res = $lwp->request($req);
	
	return { code	=> $res->code,
			 message => $res->message,
			 content => $res->content };
}

sub _build_content {
	my %args = @_;
	
	my @args = ();
	for my $key (keys %args) {
		$args{$key} = (defined $args{$key} ? $args{$key} : '');
		push @args, uri_escape($key).'='.uri_escape($args{$key});
	}
	
	return join('&', @args) || '';
}
