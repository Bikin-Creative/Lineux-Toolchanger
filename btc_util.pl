#!/usr/bin/perl

$btc_install_folder = glob("~/btc");
$btc_staging_folder = "$btc_install_folder/config";
$btc_staging_variables = "$btc_staging_folder/btc_variables.cfg";
$btc_default_variables = "$btc_install_folder/default_variables.txt";
$printer_cfg_folder = glob("~/printer_data/config");
$btc_cfg_folder = glob("~/printer_data/config/btc");  #####################
$btc_variables_cfg = glob("~/printer_data/config/btc/btc_variables.cfg");
symlink($btc_cfg_folder, $btc_staging_folder);

my @variables = qw( variable_btc_travel_speed variable_btc_toolchange_speed variable_btc_wipe_speed variable_btc_z_hop variable_btc_temp_allow variable_btc_inc_leds variable_btc_enable_spoolman_integration );
my $regex = join '|', map quotemeta, @variables;
$regex = qr/^($regex)\s*:\s*/;
my %btcvar;
my @addvar;
my %defval;
my ($key, $values) = read_entry($btc_variables_cfg);
$btcvar{$key} = $values;
my ($key1, $values1) = read_entry($btc_default_variables);
$defval{$key1} = $values1;
#use Data::Dumper; print Dumper $defvar{$btc_default_variables}; exit;

foreach $templine (@variables)
{ print "$templine: $btcvar{$btc_variables_cfg}{$templine}\n";
	if ($btcvar{$btc_variables_cfg}{$templine} eq "")
	{ push @addvar, $templine;
		print "$templine missing, adding $templine: $defval{$btc_default_variables}{$templine}\n";
	}
}
&update_file;

sub update_file
{ open my $in, "$btc_staging_variables" or die $!;
	my @filedata = <$in>;
	close $in;
	my $addtxt;
	foreach $templine (@addvar)	{ $addtxt .= "$templine: $defval{$btc_default_variables}{$templine}\n";	}
	$addtxt =~ s/\n$//;
	open $in, ">", "$btc_staging_variables" or die $!;
	foreach $templine (@filedata)
	{	$templine =~ s/(\[gcode_macro _btc_Variables\])/$1\n$addtxt/;
		print $in $templine;
	}
	close $in;
}

sub read_entry
{ my ($key) = @_;
  open my $in, '<', "$key" or die $!;

  my %values;
  while (<$in>)
  { next if /^#/;
    if (/$regex(.*?)(\s|\#)/) { $values{$1} = $2; }
  }
  return $key, \%values
}
