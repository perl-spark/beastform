use 5.006;    # our
use strict;
use warnings;

package BeastForm::Writer::DBIL::Dynamic::Table;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: Configures a table in the DBIx::Lite Schema

use Moo;

with 'BeastForm::Role::Process';

sub pk {
  my ($self, @fields) = @_;
  $self->table->_set_primary_key(map $_->name, @fields);
}

sub fks {
  my ($self, $fk_fields, $fk_constraints) = @_;
  foreach my $f (@$fk_fields) {}
  foreach my $f (@$fk_constraints) {}
}

sub uniques {
  my ($self, $unique_fields, $unique_constraints) = @_;
}

sub indices {
  my ($self, @indices) = @_;
}

sub fields {
  my ($self, @fields) = @_;
}

sub go {
  my ($self) = @_;
  $self->schema->table($self->in_table->name);

}
1;
__END__
