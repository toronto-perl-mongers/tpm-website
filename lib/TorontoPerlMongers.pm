package TorontoPerlMongers;
use Dancer ':syntax';
use Dancer::Plugin::Feed;

our $VERSION = '0.1';

get qr{/feed/?} => sub {
    my $feed = create_feed(	
        format  => 'RSS',
        title   => 'Toronto Perl Mongers',
        entries => [],
    );
    return $feed;	
};

get '/meetings/:meeting' => sub {

};

get qr{/meetings/?} => sub {
	
};	

get '/' => sub {
    template 'index';
};

true;
