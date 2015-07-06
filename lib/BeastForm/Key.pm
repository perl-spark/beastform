package BeastForm::Key;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;

has table   => ( is => 'ro', required => 1, weak_ref => 1);
has fields  => ( is => 'ro', required => 1 );

1;
__END__
