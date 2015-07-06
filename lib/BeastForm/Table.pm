use 5.006;    # our
use strict;
use warnings;

package BeastForm::Table;

our $VERSION = '0.000001';

# AUTHORITY

# ABSTRACT: The useful information we know about a table

use Moo;

has pk      => ( is => 'ro', required => 1 );
# has fks     => ( is => 'ro', required => 1 );
# has checks  => ( is => 'ro', required => 1 );
has name    => ( is => 'ro', required => 1 );
has fields  => ( is => 'ro', required => 1 );
# has indices => ( is => 'ro', required => 1 );
# has uniques => ( is => 'ro', required => 1 );

1;
__END__


