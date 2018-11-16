use strict;
use warnings;
use utf8;
use Irssi;


our $VERSION = '0.0.0';
our %IRSSI = (
    authors     => 'Brandon Williams',
    contact     => 'driftx@gmail.com',
    name        => 'irssi-slack-emoticon',
    description => 'adds tab completion for slack emoticons in irssi.',
    license     => 'Public Domain',
);

our @emoji = (
"100",
"allthethings",
"awyeah",
"awthanks",
"badjokeeel",
"confused",
"disappointed",
"disapproval",
"fingers_crossed",
"fry",
"hannibal",
"iseewhatyoudidthere",
"joy",
"ninja",
"nothingtodohere",
"okay",
"puke",
"relieved",
"rockon",
"sadpanda",
"salute",
"slightly_smiling_face",
"stare",
"success",
"thumbsup",
"trollface",
"wink",
);

sub completer {
    my ($strings, $window, $word, $linestart, $want_space) = @_;

    return unless ($word =~ /^:/);

    if ($word =~ /^:([a-zA-Z_\+\-1-9]+)$/) {
        @$strings = map {":" . $_ . ":" } grep {/^\Q$1\E/} @emoji;
        $$want_space = 0;
        Irssi::signal_stop();
    }
}

Irssi::signal_add_first('complete word', \&completer);
 

# vim: set ts=4 sw=4 tw=0 et fdm=marker:
