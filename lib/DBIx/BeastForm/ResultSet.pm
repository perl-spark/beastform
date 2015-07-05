package DBIx::BeastForm::ResultSet;

use overload '""' => sub { "<DBIx::BeastForm::Resultset object>"; };
use Moo;

extends 'DBIx::Lite::ResultSet';

1;
__END__

