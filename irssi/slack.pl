use strict;
use warnings;

use vars qw($VERSION %IRSSI);
use Irssi;

$VERSION = '0.1';
%IRSSI = (
  authors     => 'Brandon Williams',
  contact     => 'driftx@gmail.com',
  name        => 'slack display name completion',
  description => 'completes nicks with @ style when needed',
  license     => 'Public Domain',
);

sub do_complete {
  my ($strings, $window, $word, $linestart, $want_space) = @_;
  if ($word =~ /^\//) { return; }
  my $channel = $window->{active};
  my $lower = lc($word);
  return unless $window->{active_server} && $window->{active_server}->{address} =~ /localhost/;
  return unless $channel;
  if (! $channel->can('nicks')) { return; }
  foreach my $nick ($channel->nicks()) {
    my $mention = '@' . $nick->{nick} . Irssi::settings_get_str('completion_char');
    $mention =~ s/_//g;
    if (lc($nick->{nick}) =~ /^$lower/) {
        unshift(@$strings, $mention);
    } else {
        push @$strings, $mention;
    }
  }

  $$want_space = 1;
  Irssi::signal_stop;
}

Irssi::signal_add_first('complete word',  \&do_complete);
