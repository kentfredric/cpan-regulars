
use strict;
use warnings;

use Test::More;

# ABSTRACT: Make sure final_week_number returns expected values

use regulars qw( final_week_number );

sub fnw
{
    my ($year, $week) = @_;

    my ($g_week) = final_week_number($year);

    @_ = ("($year) = week $week");

    if ($g_week eq $week) {
        goto &pass;
    }
    diag explain {
        year     => $year,
        expected => { final_week => $week },
        got      => { final_week => $g_week },
    };
    goto &fail;
}

fnw(2006, 53);
fnw(2007, 52);
fnw(2008, 52);
fnw(2009, 52);
fnw(2010, 52);
fnw(2011, 52);
fnw(2012, 53);
fnw(2013, 52);
fnw(2014, 52);

done_testing;

