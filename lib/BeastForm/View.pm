package BeastForm::View;

# ABSTRACT: The useful information we know about a view

use Moo;

has sql     => ( is => 'ro', required => 1 );
has name    => ( is => 'ro', required => 1 );
has order   => ( is => 'ro', required => 1 );
has fields  => ( is => 'ro', required => 1 );
has tables  => ( is => 'ro', required => 1 );
has options => ( is => 'ro', required => 1 );

1;
__END__

