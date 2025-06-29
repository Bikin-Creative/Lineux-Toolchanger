#!/usr/bin/perl

use File::Fetch;
use IO::Uncompress::Unzip qw($UnzipError);

$bundle_filename = "btc.zip";
$zip_bundle = "https://raw.githubusercontent.com/Bikin-Creative/Lineux-Toolchanger/btc_dev/$bundle_filename";
$btc_install_folder = glob("~/btc");
$btc_staging_folder = "$btc_install_folder/config";
$btc_staging_variables = "$btc_staging_folder/btc_variables.cfg";
$btc_default_variables = "$btc_install_folder/default_variables.txt";
$btc_unzip_folder = "$btc_install_folder/unzip";
$printer_cfg_folder = glob("~/printer_data/config");
$btc_cfg_folder = "$printer_cfg_folder/btc";
$btc_variables_cfg = "$btc_cfg_folder/btc_variables.cfg";
symlink($btc_cfg_folder, $btc_staging_folder);

#&download_bundle;
my %defval;
my ($key1, $values1, @variables) = read_entry($btc_default_variables);
$defval{$key1} = $values1;
my $regex = join '|', map quotemeta, @variables;
$regex = qr/^($regex)\s*:\s*/;
my %btcvar;
my @addvar;
my ($key, $values) = read_entry($btc_variables_cfg);
$btcvar{$key} = $values;
#use Data::Dumper; print Dumper $defval{$btc_default_variables}; exit;

foreach $templine (@variables)
{ print "$templine: $btcvar{$btc_variables_cfg}{$templine}\n";
	if ($btcvar{$btc_variables_cfg}{$templine} eq "")
	{ push @addvar, $templine;
		print "$templine missing, adding $templine: $defval{$btc_default_variables}{$templine}\n";
	}
}
&update_file;

sub download_bundle
{ my $ff = File::Fetch->new(uri => $zip_bundle);
  my $file = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
	unzip($bundle_filename, "$btc_unzip_folder");
}

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
  { if ($key eq $btc_default_variables)
  	{ if (/^(.*?)\s*\:\s*(.*?)(\s|\#)/)
  		{ push @variables, $1;
  			$values{$1} = $2;
  		}
  	}
  	else
  	{ next if /^#/;
      if (/$regex(.*?)(\s|\#)/) { $values{$1} = $2; }
    }
  }
  return $key, \%values, @variables
}
