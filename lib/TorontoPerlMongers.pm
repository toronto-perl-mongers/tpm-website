package TorontoPerlMongers;
use Dancer ':syntax';
use Dancer::Plugin::Feed;

our $VERSION = '0.1';

use DateTime;
use TorontoPerlMongers::Model::Meetings;

my $meetings = TorontoPerlMongers::Model::Meetings->new();
$meetings->load("data/meetings");

get qr{/feed/?} => sub {

    # template('meeting', { meeting => $_ }, { layout  => undef } )
    # title, link, summary, content, author, issued and modified
    my $feed = create_feed(
        entries => [
            map {
                +{
                    link   => uri_for( '/meetings/' . $_->id() ),
                    issued => $_->details()->datetime
                    ? $_->details()->datetime
                    : '',
                    title   => $_->label(),
                    content => template(
                        'meeting', { meeting => $_, hide_layout => undef }
                    ),
                  }
              } @{ $meetings->ordered_meetings() }
        ]
    );
    return $feed;
};

get '/meetings/:meeting' => sub {
    my $id = params->{meeting};
    my ($meeting) = grep { $_->id() == $id } @{ $meetings->meetings() }
      or die("Can't find meeting: $id");
    template 'meeting', { meeting => $meeting };
};

get qr{/meetings/?} => sub {
    template 'meetings', { meetings => $meetings };
};

get '/' => sub {
    my $meeting = $meetings->ordered_meetings->[0];
    my $next_or_last =
      DateTime->compare( $meeting->details->datetime, DateTime->now ) <= 0
      ? 'Last'
      : 'Next';
    template 'index', { meeting => $meeting, next_or_last => $next_or_last };
};

true;
