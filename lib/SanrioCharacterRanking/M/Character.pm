package SanrioCharacterRanking::M::Character;
use strict;
use warnings;
use utf8;
use 5.012;

use parent qw/SanrioCharacterRanking::M/;

use Amon2::Declare;

sub daily_votes {
    my ($class, $id) = @_;

    c()->db->search_by_sql("
        SELECT
            TO_CHAR(statuses.created_at, 'YYYY-MM-DD') AS date,
            COUNT(votes.status_id) AS votes
        FROM votes
        JOIN statuses ON votes.status_id = statuses.id
        WHERE votes.character_id = ?
        GROUP BY date
        ORDER BY date ASC
    ", [ $id ]);
}

1;
