package DBIx::BeastForm::Driver;

use Moo;
use Carp qw(croak);
use DBI;
use DBIx::BeastForm::DB;

has name => (
  is => 'ro',
  required => 1,
  isa => sub {local $_ = shift; croak("Expected string, got: $_") if ref $_},
);

has dsn => (
  is => 'rw',
  default => sub {$ENV{DBI_DSN}||undef},
);

has user => (
  is => 'rw',
  default => sub {$ENV{DBI_USER}//''},
);

has pass => (
  is => 'rw',
  default => sub {$ENV{DBI_PASS}//''},
);

sub dbs {
  my ($self, %options) = @_;
  # The DBI stack is starting to show bitrot and should be cleansed with fire
  local $ENV{DBI_DSN} = $self->dsn;
  local $ENV{DBI_USER} = $self->user;
  local $ENV{DBI_PASS} = $self->pass;
  map {
    DBIx::BeastForm::DB->new(dsn => $self->dsn,  user => $self->user, pass => $self->pass);
  } DBI->data_sources($self->name),
}

sub human_name {
  my $self = shift;
  return "Postgres" if $self->driver eq 'Pg';
  return $self->driver;
}

1;
__END__
