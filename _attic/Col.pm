use 5.006;    # our
use strict;
use warnings;

package BeastForm::Col;

our $VERSION = '0.000001';

# AUTHORITY

use Moo;

has name => (
  is => 'ro',
  isa => sub {
    local $_ = shift;
    croak("Expected string, got $_") if ref $_ || !$_;
  },
  required => 1,
);

has table => (
  is => 'ro',
  isa => sub {
    local $_ = shift;
    croak("Expected BeastForm::Table, got: '$_'")
      unless $_->isa('BeastForm::Table');
  },
  weak_ref => 1,
  required => 1,
);


sub new_from_table {
  my ($self, $table, %info) = @_;
  __PACKAGE__->new(
    table => $table,
    name => $info{COLUMN_NAME},
    sql_type => $info{SQL_DATA_TYPE},
    wtf_type => $info{DATA_TYPE}, # WTF is this?
    real_type => $info{TYPE_NAME},
    size => $info{COLUMN_SIZE},
    buffer_len => $info{BUFFER_LENGTH},
    decimal_digits => $info{DECIMAL_DIGITS},
    precision_radix => $info{NUM_PREC_RADIX},
    nullable => $info{NULLABLE},
    is_nullable => $info{IS_NULLABLE}, # WTF?
    default => $info{COLUMN_DEF}, # could be arbitrary expression
    datetime_subcode => $info{SQL_DATETIME_SUB},
    char_octet_length => $info{CHAR_OCTET_LENGTH},
    offset => $info{ORDINAL_POSITION},
  );
}
1;
__END__
