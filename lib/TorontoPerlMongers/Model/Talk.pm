package TorontoPerlMongers::Model::Talk;

use strict;
use warnings;

use Moose;

has 'speaker' => ( isa => 'Str', is => 'rw' );
has 'title' => ( isa => 'Str', is => 'rw' );
has 'description' => ( isa => 'Str', is => 'rw', default => '' );

sub load_data {
	my ($self, $as_html_fn, $data) = @_;
	
	$self->speaker(&$as_html_fn($data->{speaker}));
	$self->title(&$as_html_fn($data->{title}));
	if (exists($data->{description})) {
		$self->description(&$as_html_fn($data->{description}));
	}
}

1;
