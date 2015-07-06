use 5.006;    # our
use strict;
use warnings;

package BeastForm;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;
use DBI;
use List::Util qw(first);
use BeastForm::Driver;

# ABSTRACT: Introspect a database and dynamically generate models

=head1 INTRODUCTION

Because I want to distribute my next application as a single fatpacked script,
I can't use the L<DBIx::Class> (and the equally excellent L<DBIx::Class::Schema::Loader>)
which leaves me feeling like a sad panda. I know, I'll write some, I thought...

This library provides a means of connecting to a database (via L<DBIx::Connector>),
introspecting it and configuring your database wrappers appropriately. We will
one day support spitting out module files like L<DBIx::Class::Schema::Loader>

Think of us as the glue code that sorts out the tedious parts of dealing with
databases for you so you can get on with building whatever you're working on!

=head1 SYNOPSIS

    use BeastForm;
    use Mojolicious::Lite;
    get "/" => sub {
      $_[0]->stash( drivers => BeastForm::drivers );
      $_[0]->render( template => "form.html.ep" );
    };
    post "/" => sub {
      my $db = BeastForm::driver( $_[0]->param( 'driver' ) )->connect(
        $_[0]->param( 'db' ), $_[0]->param( 'username' ), $_[0]->param( 'password' )
      )->read_with( 'BeastForm::Reader::SQLT' )
      ->write_with( 'BeastForm::Writer::DBIL::Dynamic' );
      $_[0]->stash( posts => [ $db->table( 'posts' )->all ] );
      $_[0]->render( template => "posts.html.ep" );
    };

=head1 LIBRARY SUPPORT

For input, we currently support:
* L<SQL::Translator> (via L<BeastForm::Reader::SQLT>)

For output, we currently support:
* L<DBIx::Lite> (via L<BeastForm::Writer::DBIL>)

Database support is anything L<SQL::Translator> supports, which is most things.

=head1 MODES OF OPERATION

The primary mode of operation at the minute is 'dynamic'. This attempts to
introspect your database and generate a schema for DBIL

We'd like to generate static pm files like L<DBIx::Class::Schema::Loader> one day
We'd also like scripts to automate the generation of static files from the shell

=head1 CURRENT FEATURES

* Simple Moose-based API
* Reasonable support for DBD::Pg
* Introspects just about everything SQL::Translator does

=head1 FUTURE AIMS

* Better support for other databases (particularly SQLite)
* Tests to run on everyone's machine. One day.


=head1 DEVELOPMENT AIMS

* Be packable with L<App::FatPacker> (i.e. no XS, try and keep it small)
* Favour simplicity and reusing existing cpan
* Our (currently) preferred means of keeping an ordered hash is L<Hash::Ordered>
* Favour predictability. That means sorting hash keys etc.

=head1 GET INVOLVED

It's easy and we're friendly.

1. Fork the repository on github
2. Check out your fork: C<git clone git@github.com:username/beastform.git && cd beastform>
3. Make your changes
4. Add a remote for the upstream repository: C<git remote add upstream https://github.com/perl-spark>
5. Rebase from master: C<git fetch upstream && git rebase upstream/master>
6. File a pull Request!

=cut

# sub from_dsn {
#   # my ($self, $dsn, %extra) = @_;
#   # my $fields = DBI->
#   # my $host = $extra{host};
#   # my $port = $extra{port};
#   # $extra{
# }

=head2 find_drivers -> Hash[String -> DBIx::BeastForm::Driver]

Returns a hash of names to Driver objects

=cut

sub find_drivers {
  my ($self) = @_;
  map (
    $_ => BeastForm::Driver->new( name => $_ )
  ), DBI->available_drivers;
}

sub driver {
  my ($self, $name) = @_;
  return (first { $_ eq $name } DBI->available_drivers) ?
	BeastForm::Driver->new( name => $name ) :
    undef;
}

1;
__END__

