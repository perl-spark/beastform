use 5.006;    # our
use strict;
use warnings;

package BeastForm::Writer::DBIL::Dynamic::Schema;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use DBIx::Lite::Schema;
use BeastForm::Writer::DBIL::Dynamic::Table;
with 'BeastForm::Role::Process';

sub tables {
  my ($self, @tables) = @_;
  map {
	BeastForm::Writer::DBIL::Dynamic::Table->new(
      schema => $self->schema,
      in_table => $_,
    )->go;
  } @tables
}
sub views {
  my ($self, @views) = @_;
  map {
    warn "Treating view '@{[$v->name]}' as a table\n";
	BeastForm::Writer::DBIL::Dynamic::Table->new(
      schema => $self->schema,
      table => $_,
    )->go;
  } @views;
  1;
}
sub procs {
  my ($self, @procs) = @_;
  warn "Sorry, we don't support procedures yet\n"
    if @procs;
}
sub triggers {
  my ($self, @triggers) = @_;
  warn "Sorry, we don't support triggers yet\n"
    if @triggers;
}

sub go {
  DBIx::Lite::Schema->new
}

1;
__END__
