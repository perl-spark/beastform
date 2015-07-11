use 5.006;    # our
use strict;
use warnings;

package BeastForm::Reader::SQLT::Field;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use BeastForm::Field;
use Data::Dumper 'Dumper';

has in_field => (
  is => 'ro', required => 1,
  isa => sub { die("Not truthy!") unless $_[0] },
  handles => {
    name    => 'name',          size      => 'size',
    type    => 'data_type',     comments  => 'comments',
    default_value => 'default_value', nullable => 'is_nullable',
  },
);
has table => ( is => 'ro', required => 1, weak_ref => 1 );

sub go {
  my ($self) = @_;
  my $f = BeastForm::Field->new(
    name  => $self->name,  size    => [$self->size],    type    => $self->type,
    table => $self->table, comment => join("\n", $self->comments),
    default => $self->default_value, nullable => $self->nullable,
  );
  if ($self->in_field->is_unique) {
    # Install a key for it if we're unique
    $self->table->keys->set( $f->name, BeastForm::Key->new(
      table => $self->table,
      fields => Hash::Ordered->new(
        $f->name => $self
      )
    ));
  }
  $f;
}

1;
__END__
