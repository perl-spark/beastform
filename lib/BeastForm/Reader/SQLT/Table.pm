use 5.006;    # our
use strict;
use warnings;

package BeastForm::Reader::SQLT::Table;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use BeastForm::Reader::SQLT::Field;
use BeastForm::Reader::SQLT::FK;
use BeastForm::Key;
use BeastForm::Table;
use Hash::Ordered;
use Data::Dumper 'Dumper'; # REMOVEME

with qw(
  BeastForm::Role::Process
  BeastForm::Role::Finalizer
);

has in_table  => (
  is => 'ro', required => 1,
  handles => [ qw( name ) ],
);
has in_schema => ( is => 'ro', required => 1 );
has schema => ( is => 'ro', required => 1 );

sub _make_numbered_name {
  my ($self, $name, $test) = @_;
  my $i = 2;
  $i++ while ($test->("${name}_${i}"));
  "${name}_${i}";
}

sub _fields {
  my ($self, $t) = @_;
  my @fnames = sort map $_->name,
                 ($self->in_table->pkey_fields, $self->in_table->data_fields);
  foreach my $f (@fnames) {
    $t->fields->set($f, BeastForm::Reader::SQLT::Field->new(
      in_field => $self->in_table->get_field($f), table => $t,
    )->go);
  }
  $self;
}

sub _pk {
  my ($self, $t) = @_;
  $t->_set_pk(
    BeastForm::Key->new(
      table => $self,
      fields => [map $t->field($_), sort map $_->name, $self->in_table->pkey_fields],
    )
  );
  $self;
}

sub _key_name {
  my ($self, $c, $ks) = @_;
  # predictable and unlikely to clash
  my $name = join("_", sort $c->field_names);
  $ks->get($name) ?
    $self->_make_numbered_name($name, sub { $ks->get( shift ); } ) :
    $name;
}

sub _keys {
  my ($self, $t) = @_;
  foreach my $c ($self->in_table->unique_constraints) {
    my $key = BeastForm::Reader::SQLT::Key->new(
      in_constraint => $c,
      table => $self,
    )->go;
    $t->keys->set($self->_key_name($c, $t->keys), $key);
  };
  $self;
}
sub _indices {
  my ($self, $t) = @_;
  # Do something with $self->table->get_indices;
  $self;

}
sub _checks {
  my ($self, $t) = @_;
  # Do something with grep ($_->type eq 'CHECK_C') $self->table->get_constraints;
  $self;
}

sub go {
  my ($self) = @_;
  my $t = BeastForm::Table->new(
    schema => $self->schema, name => $self->name,
  );
  $self->_fields($t)
       ->_pk($t)
	   ->_keys($t)
       ->_indices($t)
       ->_checks($t);
  $t;
}


sub _out_name {
  my ( $self, $t, $c ) = @_;
  my $name;
  # Grr, stupid context-sensitive function
  if (@{[$c->field_names]} == 1 and
      $c->field_names->[0] =~ /(.+)_id\Z/) {
    $name = $1;
  } else {
    $name = $c->reference_table;
  }
  if ($t->outs->get($name)) {
    warn "WARNING: Outbound FK name clash on field: '@{[$name]}'";
    $name = $self->_make_numbered_name($name, sub { $t->outs->get(shift); } );
  }
  $name;
}

sub _in_name {
  my ( $self, $t ) = @_;
  if ( $t->ins->get( $t->name ) ) {
    warn "WARNING: Inbound FK name clash on field: '@{[$t->name]}'";
    return $self->_make_numbered_name($t->name, sub { $t->ins->get(shift); } );
  }
  $t->name;
}

sub _outs {
  my ($self, $t) = @_;
  my @cs = $self->in_table->fkey_constraints;
  foreach my $c (@cs) {
    my $name = $self->_out_name($t, $c, $t->outs);
    my $fk = BeastForm::Reader::SQLT::FK->new(
      in_constraint => $c,
      schema => $t->schema,
    )->go;
    $t->outs->set($name, $fk);
  }
  $self;
}

sub _ins {
  my ($self, $t) = @_;
  foreach my $o ($t->outs->values) {
    $self->_add_backref($o->to->table, $o);
  }
  $self;
}
sub _add_backref {
  my ($self, $table, $fk) = @_;
  my $name = $self->_in_name( $table );
  $table->ins->set( $name, $fk );
}
sub finalize_a {
  my ($self, $t) = @_;
  $self->_outs($t)
       ->_ins($t);
  $t;
}

1;
__END__
