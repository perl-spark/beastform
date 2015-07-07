use 5.006;    # our
use strict;
use warnings;

package BeastForm::Role::DBIL;

our $VERSION = '0.000001';

# AUTHORITY

use Moo::Role;
use DBIx::Lite;
use DBIx::BeastForm::DBIL::Schema;
use DBIx::BeastForm::DBIL::Builder::Dynamic;
# use DBIx::BeastForm::DBIL::Builder::Static;

with 'DBIx::BeastForm::Role::Introspective';

has namespace   => ( is => 'ro', required => 1  );

=head1 SYNOPSIS

    package My::BeastForm;
    use Moo;
    use My::Config qw(config);
    with 'DBIx::BeastForm::Role::DBIL;
    has '+username' => ( default => sub { config('username') } );
    has '+password' => ( default => sub { config('password') } );
    has '+extra' => (
      default => sub { +{host => config('host'),
                         port => config('port')}; },
    );

=head1 METHODS

=head2 $bf->dynamic() -> Void

Introspects the database and returns a L<DBIx::BeastForm::DBIL::DB>

=cut

sub dynamic {
  my ($self) = @_;
  DBIx::BeastForm::DBIL::Builder::Dynamic->new(
    connector => $self->connector,
    schema => $self->schema,
    namespace => $self->namespace,
  )->build;
}

sub static {
  die("Not yet implemented. Patches Welcome!");
}

1;
__END__
