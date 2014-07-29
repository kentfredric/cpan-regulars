
use strict;
use warnings;

use Test::More;

# ABSTRACT: Make sure time_to_bins returns expected values

use regulars qw( time_to_bins );

sub bins_ok
{
    my ($ts, $ym, $week, $date) = @_;

    my ($g_ym, $g_week, $g_date) = time_to_bins($ts);

    if ($g_ym ne $ym) {
        diag explain {
            expected => { ym => $ym },
            got      => { ym => $g_ym },
        };

        @_ = ("($ts) ym = $ym, .... ");
        goto \&fail;
    }
    if ($g_week ne $week) {
        diag explain {
            expected => { week => $week },
            got      => { week => $g_week },
        };
        @_ = ("($ts) ym = $ym, week = $week .... ");
        goto \&fail;
    }
    if ($g_date ne $date) {
        diag explain {
            expected => { date => $date },
            got      => { date => $g_date },
        };
        @_ = ("($ts) ym = $ym, week = $week, date = $date");
        goto \&fail;
    }
    @_ = ("($ts) ym = $ym, week = $week, date = $date");
    goto \&pass;

}

bins_ok(1406591442, '2014-07', '2014-W30', '2014-07-28');

done_testing;

