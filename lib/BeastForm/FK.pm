use 5.006;    # our
use strict;
use warnings;

package BeastForm::FK;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;

has from      => (is => 'ro', required => 1);
has to        => (is => 'ro', required => 1);
has on_delete => (is => 'ro', required => 1);
has on_update => (is => 'ro', required => 1);

1;
__END__
