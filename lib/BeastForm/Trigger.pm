use 5.006;    # our
use strict;
use warnings;

package BeastForm::Trigger;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: The useful information we know about a trigger

use Moo;

has sql      => ( is => 'ro', required => 1 );
has name     => ( is => 'ro', required => 1 );
has order    => ( is => 'ro', required => 1 );
has scope    => ( is => 'ro', required => 1 );
has table    => ( is => 'ro', required => 1 );
has fields   => ( is => 'ro', required => 1 );
has run_on   => ( is => 'ro', required => 1 );
has run_when => ( is => 'ro', required => 1 );

1;
__END__


