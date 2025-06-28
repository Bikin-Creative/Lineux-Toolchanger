#!/usr/bin/perl
use File::Fetch;

#wget https://raw.githubusercontent.com/Bikin-Creative/Lineux-Toolchanger/btc_dev/install.pl -O - | perl
$btc_install_folder = glob("~/btc");
$util_file = "btc_util.pl";
$btc_source = "https://raw.githubusercontent.com/Bikin-Creative/Lineux-Toolchanger/btc_dev/$util_file";

if (!-d $btc_install_folder) { mkdir ($btc_install_folder, 0775) or $!{EEXIST} or die "Make directory $btc_install_folder failed!!"; }
$ff = File::Fetch->new(uri => $btc_source);
$file = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
chmod 0755, "$btc_install_folder/$util_file";
print "Btc downloaded. Now start installation by typing: cd btc && ./btc_util.pl\n";
