#!/usr/bin/env perl
use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use WWW::Search;
my $searcher = WWW::Search->new('Techbang');

$searcher->native_query(WWW::Search::escape_query(join(" ",@ARGV)));
while (my $hit = $searcher->next_result()) {
    print "@{[ $hit->title ]}\n    @{[ $hit->url ]}\n\n";
}
