package TorotonPerlMongers::Plugins::Meetings;

use common::sense;
use Dancer ':syntax';
use Dancer::Plugin;

register 'meetings' => sub {
    my $conf = plugin_setting();
    
};

register_plugin;

1;
