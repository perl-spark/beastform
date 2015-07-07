package BeastForm::Driver;

# ABSTRACT: Represents a DBD. Can make a connector

use Moo;
use Carp qw(croak);
use DBI;
use BeastForm::DB;

has name => (
  is => 'ro',
  required => 1,
  isa => sub {local $_ = shift; croak("Expected string, got: $_") if ref $_},
);

sub connect {
  my ($self, $db, $user, $pass, %extra) = @_;
  BeastForm::DB->new(
    driver => $self, name => $db,
    user => $user,   pass => $pass,
   
  );
}

sub human_name {
  my ($self) = @_;
  return "PostgreSQL" if $self->driver eq 'Pg';
  return $self->driver;
}

1;
__END__
