package BeastForm::Role::Constraint;

our $VERSION = '0.000001';

# AUTHORITY

use Moo::Role;

has table => ();
has type => ();
has name => ();
has fields => ();

1;
__END__
