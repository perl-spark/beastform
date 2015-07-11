use 5.006;    # our
use strict;
use warnings;

package BeastForm::Table;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: The useful information we know about a table

use Moo;
use Hash::Ordered;

has schema   => ( is => 'ro', required => 1, weak_ref => 1 );
has name     => ( is => 'ro', required => 1 );

# Populated during build

has pk       => ( is => 'rwp',  default => undef );
has fields   => ( is => 'ro',   default => sub { Hash::Ordered->new } );
has keys     => ( is => 'ro',   default => sub { Hash::Ordered->new } );
has checks   => ( is => 'ro',   default => sub { Hash::Ordered->new } );
has indices  => ( is => 'ro',   default => sub { Hash::Ordered->new } );
has outs     => ( is => 'ro',   default => sub { Hash::Ordered->new } );
has ins      => ( is => 'ro',   default => sub { Hash::Ordered->new } );

sub field {
  my ($self, $name) = @_;
  $self->fields->get($name);
}
sub key {
  my ($self, $name) = @_;
  $self->keys->get($name);
}
sub check {
  my ($self, $name) = @_;
  $self->checks->get($name);
}
sub index {
  my ($self, $name) = @_;
  $self->indices->get($name);
}
sub out {
  my ($self, $name) = @_;
  $self->outs->get($name);
}
sub in {
  my ($self, $name) = @_;
  $self->ins->get($name);
}

1;
__END__


