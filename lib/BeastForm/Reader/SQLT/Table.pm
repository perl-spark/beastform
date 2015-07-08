use 5.006;    # our
use strict;
use warnings;

package BeastForm::Reader::SQLT::Table;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use BeastForm::Reader::SQLT::Field;
use BeastForm::Key;
use BeastForm::Table;
use Hash::Ordered;
use Data::Dumper 'Dumper'; # REMOVEME

with 'BeastForm::Role::Process';

has in_table  => (
  is => 'ro', required => 1,
  handles => [ qw( name ) ],
);
has in_schema => ( is => 'ro', required => 1 );
has fields => ( is => 'lazy' );

sub pk {
  my ($self) = @_;
  BeastForm::Key->new(
    table => $self,
    fields => [map $self->fields->get($_->name), $self->in_table->pkey_fields],
  );
}
sub fks {
  my ($self) = @_;
  # TODO: 
  my @fields = $self->in_table->fkey_fields;
  my @constraints = $self->in_table->fkey_constraints;
#  warn Dumper [@fields, @constraints];
  # return (\@fields, \@constraints);
}
sub uniques {
  my ($self) = @_;
  # my @fields = $self->table->unique_fields;
  # my @constraints = $self->table->unique_constraints;
  # return [\@fields, \@constraints];
}
sub indices {
  my ($self) = @_;
#  $self->table->get_indices;
}
sub _build_fields {
  my ($self) = @_;
#  warn Dumper([$self->in_table->pkey_fields, $self->in_table->data_fields]);
  Hash::Ordered->new(
    map @{$_},
    sort { $a->[0] cmp $b->[0] }
    map [
      $_->name => BeastForm::Reader::SQLT::Field->new(
        in_field => $self->in_table->get_field($_), table => $self,
      )->go
    ], ($self->in_table->pkey_fields, $self->in_table->data_fields)
  );
}

sub go {
  my ($self) = @_;
  BeastForm::Table->new(
    pk => $self->pk, fields => $self->fields, name => $self->name,
#    uniques => $self->uniques, indices => $self->indices,
    fks => $self->fks
  );
}

1;
__END__
