package SanrioCharacterRanking::M::Vote;
use strict;
use warnings;
use utf8;
use 5.012;

use parent qw/SanrioCharacterRanking::M/;

use Amon2::Declare;

sub ranking {
    my ($class) = @_;
    c()->db->search_by_sql('
        SELECT
            ranking.character_id AS character_id,
            characters.name AS character_name,
            ranking.votes AS votes
        FROM (
            SELECT
                votes.character_id AS character_id,
                COUNT(statuses.id) AS votes
            FROM statuses
            JOIN votes ON votes.status_id = statuses.id
            GROUP BY character_id
        ) ranking
        JOIN characters ON ranking.character_id = characters.id
        ORDER BY votes DESC, character_id ASC
    ');
}

1;
