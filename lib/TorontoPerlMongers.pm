package TorontoPerlMongers;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/meetings/:meeting' {
}

get qr{/meetings/?} => sub {
	
};	

get '/' => sub {
    template 'index';
};

true;
