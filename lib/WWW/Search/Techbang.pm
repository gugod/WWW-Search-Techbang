package WWW::Search::Techbang;

use strict;
use warnings;
use 5.10.1;
use parent 'WWW::Search';
use WWW::SearchResult;

our $VERSION = '0.01';

sub _native_setup_search {
    my ($self, $native_query, $opts) = @_;
    $self->user_agent('non-robot');
    $self->{_next_url} = "http://www.techbang.com.tw/search?q=${native_query}&x=0&y=0";
}

sub _parse_tree {
    my ($self, $tree) = @_;

    my @hits = map {
        my $tag = $_;
        my $hit = WWW::SearchResult->new;
        $hit->add_url("http://www.techbang.com.tw" . $tag->{href});
        $hit->title($tag->as_trimmed_text);
        $hit->description(q{});

        $hit;
    } $tree->look_down(_tag => "a", href => qr{^/posts/}, sub { $_[0]->parent->tag eq 'h1'});

    $self->{cache} = \@hits;

    return scalar @hits;
}

1;
__END__

=head1 NAME

WWW::Search::Techbang - A module to search Techbang

=head1 SYNOPSIS

    use WWW::Search;

    my $searcher = WWW::Search->new('Techbang');
    $searcher->native_query(WWW::Search::escape_query('iPhone4'));
    while (my $hit = $searcher->next_result()) {
        print $hit->title, $hit->url;
    }

=head1 DESCRIPTION

WWW::Search::Techbang is a module to crawl search results on
L<http://www.techbang.com.tw/>.  This module should only be used
through the interface of L<WWW::Search>.

=head1 AUTHOR

Kang-min Liu E<lt>gugod@gugod.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011, Kang-min Liu C<< <gugod@gugod.org> >>.

This is free software, licensed under:

    The MIT (X11) License

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENSE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut

