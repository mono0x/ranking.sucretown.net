package SanrioCharacterRanking::Web;
use strict;
use warnings;
use utf8;
use parent qw/SanrioCharacterRanking Amon2::Web/;
use File::Spec;

# dispatcher
use SanrioCharacterRanking::Web::Dispatcher;
sub dispatch {
    return (SanrioCharacterRanking::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
    '+SanrioCharacterRanking::Web::Plugin::Session',
);

# setup view
use SanrioCharacterRanking::Web::View;
{
    sub create_view {
        my $view = SanrioCharacterRanking::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *SanrioCharacterRanking::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

sub render {
    my ($c, $tmpl, $vars) = @_;
    if ($ENV{PLACK_ENV} eq 'development') {
        require DBIx::Tracer;
        my $tracer = DBIx::Tracer->new(
            sub {
                return unless Text::Xslate->current_engine;
                my %args = @_;
                my $sql = $args{sql};
                warn "Do not execute query in a view: $sql";
                Text::Xslate->print(
                    Text::Xslate::mark_raw('<span style="color: red; font-size: 1.8em;">'),
                   "[[ Do not execute query in a view: $sql ]]",
                   Text::Xslate::mark_raw('</span>')
                );
            }
        );
    }
    $c->SUPER::render($tmpl, $vars);
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
