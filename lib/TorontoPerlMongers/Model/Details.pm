package TorontoPerlMongers::Model::Details;

use strict;
use warnings;

use Moose;

use DateTime::Format::ISO8601;

has 'topic'           => ( isa => 'Str',      is => 'rw' );
has 'datetime'        => ( isa => 'DateTime', is => 'rw' );
has 'posted_datetime' => ( isa => 'DateTime', is => 'rw' );
has 'venue'           => ( isa => 'Str',      is => 'rw' );
has 'synopsis'        => ( isa => 'Str',      is => 'rw' );
has 'moderator'       => ( isa => 'Str',      is => 'rw' );

sub load_data {
    my ( $self, $as_html_fn, $data ) = @_;

    $self->topic( &$as_html_fn( $data->{topic} ) );
    $self->venue( &$as_html_fn( $data->{venue} ) );
    $self->synopsis( &$as_html_fn( $data->{synopsis} ) );
    $self->moderator( &$as_html_fn( $data->{moderator} ) );

    my $dt
        = DateTime::Format::ISO8601->parse_datetime( $data->{datetime}->[0] );
    $self->datetime( $dt );

    if ( exists( $data->{posted} ) ) {
        my $posted_dt = DateTime::Format::ISO8601->parse_datetime(
            $data->{datetime}->[0] );
        $self->posted_datetime( $posted_dt );
    }
    else {
        $self->posted_datetime( $self->datetime() );
    }
}

1;
