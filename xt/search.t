#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

# TEST
BEGIN { use_ok('WWW::Search'); };
# TEST
BEGIN { use_ok('WWW::Search::Test'); };
# TEST
BEGIN { use_ok('WWW::Search::Techbang'); };

$WWW::Search::Test::oSearch = new WWW::Search('Techbang');
# TEST
isa_ok ($WWW::Search::Test::oSearch, "WWW::Search");
$WWW::Search::Test::oSearch->env_proxy('yes');

my $debug = 0;
my $dump  = 0;

$debug = 0;
$dump = 0;

my $count = 
    WWW::Search::Test::count_results(
        'normal',
        'iPhone4',
        0,
        19,
        $debug,
        $dump
    );

# TEST
# ok (($WWW::Search::Test::oSearch->approximate_result_count() =~ /^\d+$/),
#     "approximate_result_count is a number");

# TEST
# ok (($WWW::Search::Test::oSearch->approximate_result_count() > 0),
#     "approximate_result_count is greater than 0");

# TEST
is ($count, 20, "Checking for count");

my @results = $WWW::Search::Test::oSearch->results();

# TEST
is (scalar(@results), 20, "Checking for results");

# TEST*2*50
foreach my $r (@results)
{
    like ($r->url(), qr{\A(?:http|https)?://},
        'Result URL is http');
    ok ((length($r->title()) > 0), "Has a non-empty title");
}

done_testing;
