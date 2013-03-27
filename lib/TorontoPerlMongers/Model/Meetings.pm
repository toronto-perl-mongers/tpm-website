package TorontoPerlMongers::Model::Meetings;

use strict;
use warnings;

use Moose;

use File::Find;
use XML::Simple;

use TorontoPerlMongers::Model::Meeting;

has 'meetings' =>
    ( isa => 'ArrayRef[TorontoPerlMongers::Model::Meeting]', is => 'rw' );

sub load {
    my ( $self, $directory ) = @_;
    find(
        {   wanted => sub {
                if ( -f $File::Find::name ) {
                    _wanted( $self, $File::Find::name );
                }
            },
            no_chdir => 1
        },
        $directory
    );
}

sub _wanted {
    my ( $self, $file ) = @_;

    my $meeting = TorontoPerlMongers::Model::Meeting->new();
    $meeting->load( $file );

    my $meetings = $self->meetings() // [];
    $self->meetings( [ @$meetings, $meeting ] );
}

sub ordered_meetings {
    my ( $self ) = @_;
    return [
        sort {
            $b->details()->datetime()->compare( $a->details()->datetime() )
        } @{ $self->meetings() }
    ];
}

1;
