package DBIx::BeastForm::DBIL::Builder::Dynamic;

use Moo;
use Data::Dumper 'Dumper';
use DBIx::Lite::Schema;

with 'DBIx::BeastForm::Role::Builder';

has namespace   => (is => 'ro', required => 1);
has connector   => (is => 'ro', required => 1);
has dbil_schema => (is => 'lazy');

sub _build_dbil_schema {
  DBIx::Lite::Schema->new;
}

sub _pre {}
sub __pk {
  my ($self, $table, $t) = @_;
  my @pkey_fields = $table->pkey_fields;
  # Check if it's a SERIAL of some kind
  if ((@pkey_fields == 1) && ($pkey_fields[0]->data_type =~ /int/i) && $pkey_fields[0]->default_value) {
    $t->autopk(@pkey_fields);
  } else {
    $t->pk(map $_->name, @pkey_fields);
  }
}
sub __fks {
  my ($self, $table, $t) = @_;
  my @fkey_fields = $table->fkey_fields;
  my @fkey_constraints = $table->fkey_constraints;
  foreach my $f (@fkey_fields) {
    warn "f:" .  $f;
  }
}
sub __uniques {
  my ($self, $table, $t) = @_;
  my @unique_fields = $table->unique_fields;
  my @unique_constraints = $table->unique_constraints;

}
sub __indices {
  my ($self, $table, $t) = @_;
  my @indices = $table->get_indices;
}

sub __fields {
  my ($self, $table, $t) = @_;
  my @data_fields = $table->data_fields;
}
sub _table {
  my ($self, $table) = @_;
  my $t = $self->dbil_schema->table($table->name);
  $self->__pk($table, $t);
#  $self->__fks($table, $t);
#  $self->__uniques($table, $t);
#  $self->__indices($table, $t);
#  $self->__fields($table, $t);
}
sub _view {
  my ($self, $view) = @_;
  warn "Got view '${view}': Sorry, views are not supported properly. We currently fake them being tables\n";
  $self->_table($view);
}
sub _procedure {
  my ($self, $proc) = @_;
  warn "Got procedure '${proc}': Sorry, procedures are not supported yet. Patches welcome!\n";
}
sub _trigger {
  my ($self, $trig) = @_;
  warn "Got trigger '${trig}': Sorry, triggers are not supported yet. Patches welcome!\n";
}

sub _post {
  my ($self) = @_;
  DBIx::Lite->new(connector => $self->connector, schema => $self->dbil_schema);
}

1;
__END__
