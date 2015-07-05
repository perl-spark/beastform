package DBIx::BeastForm::DBIL::Schema;

use DBIx::Lite::Schema;
use strict;
use warnings;

sub _table {
  my ($self, $schema, $s, $table);
  
}

sub new {
  my ($self, $schema) = @_;
  my $s = DBIx::Lite::Schema->new;
  $self->_table($schema, $s, $_)
    foreach $schema->get_tables;
}

1;
__END__
