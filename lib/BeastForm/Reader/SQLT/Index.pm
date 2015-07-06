use 5.006;    # our
use strict;
use warnings;

package BeastForm::Reader::SQLT::Index;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use BeastForm::Field;
use Data::Dumper 'Dumper';

with 'BeastForm::Role::Process';

has in_field => (
  is => 'ro', required => 1,
  handles => {
    name    => 'name',          size      => 'size',
    type    => 'data_type',     comments  => 'comments',
    default_value => 'default_value', nullable => 'is_nullable',
  },
);
has table => ( is => 'ro', required => 1, weak_ref => 1 );

sub go {
  my ($self) = @_;
  BeastForm::Field->new(
    name  => $self->name,  size    => [$self->size],    type    => $self->type,
    table => $self->table, comment => join("\n", $self->comments),
    default => $self->default_value, nullable => $self->nullable,
  );
}

1;
__END__
