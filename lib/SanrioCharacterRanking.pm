package SanrioCharacterRanking;
use strict;
use warnings;
use utf8;
our $VERSION='0.01';
use 5.008001;
use SanrioCharacterRanking::DB::Schema;
use SanrioCharacterRanking::DB;

use parent qw/Amon2/;
# Enable project local mode.
__PACKAGE__->make_local_context();

my $schema = SanrioCharacterRanking::DB::Schema->instance;

sub db {
    my $c = shift;
    if (!exists $c->{db}) {
        ENV{'DATABASE_URL'} =~ m{\Apostgres(?:ql)?://(\S+?)(?::(\S+))?@(\S+?):(\d+)/(\S+?)\z} or die;
        my ($user, $password, $host, $port, $database) = ($1, $2, $3, $4, $5);
        $c->{db} = SanrioCharacterRanking::DB->new(
            schema       => $schema,
            connect_info => [
                "dbi:Pg:dbname=$database;host=$host;port=$port", $user, $password,
                +{
                    AutoCommit => 1,
                    RaiseError => 1,
                    PrintError => 0,
                },
            ],
        );
    }
    $c->{db};
}

1;
__END__

=head1 NAME

SanrioCharacterRanking - SanrioCharacterRanking

=head1 DESCRIPTION

This is a main context class for SanrioCharacterRanking

=head1 AUTHOR

SanrioCharacterRanking authors.

