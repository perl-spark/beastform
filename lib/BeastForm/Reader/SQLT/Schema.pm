use 5.006;    # our
use strict;
use warnings;

package BeastForm::Reader::SQLT::Schema;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: Creates a SQL::Translator and reads from its schema

use Moo;
use BeastForm::Schema;
use BeastForm::Reader::SQLT::Table;
use BeastForm::Reader::SQLT::View;
use BeastForm::Reader::SQLT::Proc;
use BeastForm::Reader::SQLT::Trigger;
use Hash::Ordered;
use Data::Dumper 'Dumper'; # REMOVEME

with 'BeastForm::Role::Process';

has in_schema => (
  is => 'ro', required => 1,
  handles => [ qw( name ) ], # Cheap accessor
);

sub _tables {
  my ($self, $s) = @_;
  my @trs;
  foreach my $in_t (sort map $_->name, $self->in_schema->get_tables) {
    my $r = BeastForm::Reader::SQLT::Table->new(
      schema => $s,
      in_schema => $self->in_schema,
      in_table => $self->in_schema->get_table($in_t),
    );
    my $t = $r->go;
    $s->_add_table($t);
    push @trs, sub { $r->finalize_a($t); };
  }
  # Finalise in order
  $_->() foreach (@trs);
  $self;
}

sub _views {
  my ($self, $s) = @_;
  $self;
  # Hash::Ordered->new(
  #   map @{$_},
  #   sort { $a->[0] cmp $b->[0] }
  #   map [
  #     $_ => BeastForm::Reader::SQLT::View->new(
  #       in_schema => $self->in_schema,
  #       in_view   => $self->in_schema->get_view($_),
  #     )->go;
  #   ], $self->in_schema->get_views
  # );
}

sub _procs {
  my ($self, $s) = @_;
  $self;
  # Hash::Ordered->new(
  #   map @{$_},
  #   sort { $a->[0] cmp $b->[0] }
  #   map [
  #     $_ => BeastForm::Reader::SQLT::Proc->new(
  #       in_schema => $self->in_schema,
  #       in_proc   => $self->in_schema->get_procedure($_),
  #     )->go;
  #   ], $self->in_schema->get_procedures
  # );
}

sub _triggers {
  my ($self, $s) = @_;
  $self;
  # Hash::Ordered->new(
  #   map @{$_},
  #   sort { $a->[0] cmp $b->[0] }
  #   map [
  #     $_ => BeastForm::Reader::SQLT::Trigger->new(
  #       in_schema  => $self->in_schema,
  #       in_trigger => $self->in_schema->get_trigger($_),
  #     )->go;
  #   ], $self->in_schema->get_triggers
  # );
}

sub go {
  my ($self) = @_;
  my $s = BeastForm::Schema->new( name => $self->name );
  $self->_tables($s)
       ->_views($s)
       ->_procs($s)
       ->_triggers($s);
  $s;
}

1;
__END__

