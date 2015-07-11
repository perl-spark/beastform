use 5.006;    # our
use strict;
use warnings;

package BeastForm::FK;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;

# These should be weak, but doing so breaks the tests. WTF?
has from      => (is => 'ro', required => 1 ); #, weak_ref => 1);
has to        => (is => 'ro', required => 1 ); #, weak_ref => 1);

# These are simple strings
has on_delete => (is => 'ro', required => 1);
has on_update => (is => 'ro', required => 1);

1;
__END__
