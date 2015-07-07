package BeastForm::Reader::SQLT::Schema;

# ABSTRACT: Creates a SQL::Translator and reads from its schema

use Moo;
use BeastForm::Schema;
use BeastForm::Reader::SQLT::Table;
use BeastForm::Reader::SQLT::View;
use BeastForm::Reader::SQLT::Proc;
use BeastForm::Reader::SQLT::Trigger;
use Hash::Ordered;

with 'BeastForm::Role::Process';

has in_schema => (
  is => 'ro', required => 1,
  handles => [ qw( name ) ], # Cheap accessor
);

sub tables {
  my ($self) = @_;
  Hash::Ordered->new(
    map @{$_},
    sort { $a->[0] cmp $b->[0] }
    map [
      $_ => BeastForm::Reader::SQLT::Table->new(
        in_schema => $self->in_schema,
        in_table => $self->in_schema->get_table($_),
      )->go
    ], $self->in_schema->get_tables
  )
}

sub views {
  my ($self) = @_;
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

sub procs {
  my ($self) = @_;
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

sub triggers {
  my ($self) = @_;
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
  BeastForm::Schema->new(
    name     => $self->name,
    procs    => $self->procs,
    views    => $self->views,
    tables   => $self->tables,
    triggers => $self->triggers,
  );
}

1;
__END__

