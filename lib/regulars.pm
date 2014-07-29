use 5.010;
use strict;
use warnings;

package regulars;

# ABSTRACT: Functions for cpan-regulars

# AUTHORITY

use Sub::Exporter::Progressive -setup => { exports => [qw( final_week_number )] };
use DateTime;

sub final_week_number
{
    my $year = shift;
    state %final_week_number;

    if (not exists $final_week_number{$year}) {
        my $dt = DateTime->new(year => $year, month => 12, day => 31, hour => 12, minute => 0, second => 0);
        $final_week_number{$year} = $dt->strftime('%U');
    }

    return $final_week_number{$year};
}

1;

