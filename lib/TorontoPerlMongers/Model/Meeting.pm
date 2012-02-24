package TorontoPerlMongers::Model::Meeting;

use strict;
use warnings;

use Moose;

use XML::Simple;

use TorontoPerlMongers::Model::Details;
use TorontoPerlMongers::Model::Talk;

my $id = 1;

has 'id' => ( isa => 'Int', is => 'rw' );
has 'details' => ( isa => 'TorontoPerlMongers::Model::Details', is => 'rw' );
has 'talks' => ( isa => 'ArrayRef[TorontoPerlMongers::Model::Talk]', is => 'rw' );

sub load {
	my ($self, $file) = @_;
	
	print STDERR "$file\n";
	$self->id($id++);

	my $xs = XML::Simple->new(ForceArray => 1);
	
	my $data = $xs->XMLin($file);
	
	my $formatter = sub {
		my ($data) = @_;
		my $result = join('', map { (ref($_)) ? $xs->XMLout($_, KeepRoot => 1) : $_; } @$data);
		return $result;
	};
	
	my $details = TorontoPerlMongers::Model::Details->new();
	
	$details->load_data($formatter, $data->{details}->[0]);
	$self->details($details);
	
	my @talks = ();
	foreach my $talk_data (@{$data->{talk}}) {
		my $talk = TorontoPerlMongers::Model::Talk->new();
		$talk->load_data($formatter, $talk_data);
		push @talks, $talk;
	}
	$self->talks(\@talks);	
}

# Generate a useful label, either from the details or from the talks

sub label {
	my ($self) = @_;
	
	return $self->details()->topic() || join(", ", map { $_->title()} @{$self->talks()});
}

1;