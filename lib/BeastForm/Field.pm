use 5.006;    # our
use strict;
use warnings;

package BeastForm::Field;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;

has name     => ( is => 'ro', required => 1 );
has size     => ( is => 'ro', required => 1 );
has type     => ( is => 'ro', required => 1 );
has table    => ( is => 'ro', required => 1, weak_ref => 1 );

has comment  => ( is => 'ro', required => 1 );
has default  => ( is => 'ro', required => 1 );
has nullable => ( is => 'ro', required => 1 );

1;
__END__
