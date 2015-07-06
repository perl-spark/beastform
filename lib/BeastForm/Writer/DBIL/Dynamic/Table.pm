package DBIx::BeastForm::Writer::DBIL::Dynamic::Table;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: Configures a table in the DBIx::Lite Schema

use Moo;

with 'DBIx::BeastForm::Role::Writer::Table';

has table => ( is => 'lazy' );

sub _build_table {
  my ($self) = @_;
  $self->schema->table($self->in_table->name);
}

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

1;
__END__
