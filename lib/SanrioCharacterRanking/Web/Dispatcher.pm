package SanrioCharacterRanking::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use SanrioCharacterRanking::M::Vote;

get '/' => sub {
    my ($c) = @_;
    my @ranking = SanrioCharacterRanking::M::Vote->ranking;
    my @ranks;
    for my $i (0..$#ranking) {
        if ($i != 0) {
            if ($ranking[$i]->votes != $ranking[$i - 1]->votes) {
                push @ranks, $i + 1;
            }
            else {
                push @ranks, $ranks[$i - 1];
            }
        }
        else {
            push @ranks, 1;
        }
    }
    return $c->render('index.tx', {
        ranking => \@ranking,
        ranks => \@ranks,
    });
};

1;
