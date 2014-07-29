use 5.010;
use strict;
use warnings;

package regulars;

# ABSTRACT: Functions for cpan-regulars

# AUTHORITY

use Sub::Exporter::Progressive -setup => { exports => [qw( final_week_number time_to_bins build_bins )] };
use DateTime;

my $FIRST_RELEASE_TIME = 801459900;
my $DAY_IN_SECONDS     = 24 * 60 * 60;

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

sub time_to_bins
{
    my $time        = shift;
    my @ts          = gmtime($time);
    my $year        = $ts[5] + 1900;
    my $month       = $ts[4] + 1;
    my $day         = $ts[3];
    my $date        = sprintf('%.4d-%.2d-%.2d', $year, $month, $day);
    my $ym          = sprintf('%.4d-%.2d', $year, $month);
    my $dt          = DateTime->from_epoch(epoch => $time);
    my $week_number = $dt->strftime('%U');
    my $week_year   = $year;

    if ($week_number == 0) {
        $week_year--;
        $week_number = final_week_number($week_year);
    }
    my $week = sprintf("%.4d-W%.2d", $week_year, $week_number);

    return ($ym, $week, $date);
}

sub build_bins
{
    my $bins = shift;
    my $time = time();
    my ($week_number,   $week_year);
    my ($previous_date, $previous_ym, $previous_week);
    my ($date,          $ym, $week);

    while ($time > $FIRST_RELEASE_TIME) {
        my ($ym, $week, $date) = time_to_bins($time);

        push(@{ $bins->{day} },   $date) if !defined($previous_date) || $previous_date ne $date;
        push(@{ $bins->{week} },  $week) if !defined($previous_week) || $previous_week ne $week;
        push(@{ $bins->{month} }, $ym)   if !defined($previous_ym)   || $previous_ym ne $ym;

        $previous_ym   = $ym;
        $previous_week = $week;
        $previous_date = $date;
        $time -= $DAY_IN_SECONDS;
    }
}
1;

