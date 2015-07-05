package DBIx::BeastForm;

use Moo;
use DBI;
use DBIx::BeastForm::Driver;

# ABSTRACT: Introspect a database and dynamically generate models

=head1 INTRODUCTION

Because I want to distribute my next application as a single fatpacked script,
I can't use the L<DBIx::Class> (and the equally excellent L<DBIx::Class::Schema::Loader>)
which leaves me feeling like a sad panda. I know, I'll write some, I thought...

=head1 LIBRARY SUPPORT

Currently, we support L<DBIx::Lite> only, though it is hoped this will change
Database support is anything L<SQL::Translator> supports, which is most things.

=head1 MODES OF OPERATION

The primary mode of operation at the minute is 'dynamic'. This attempts to
introspect your database and generate a schema for DBIL

We'd like to generate static pm files like L<DBIx::Class::Schema::Loader> one day
We'd also like scripts to automate the generation of static files from the shell

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
  map {
    $_ => DBIx::BeastForm::Driver->new(name => $_)
  } DBI->available_drivers;
}

1;
__END__

