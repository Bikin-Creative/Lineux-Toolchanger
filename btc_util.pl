#!/usr/bin/perl -w
use strict;

use File::Fetch;
use IO::Uncompress::Unzip qw($UnzipError);

my $bundle_filename = "btc.zip";
my $zip_bundle = "https://raw.githubusercontent.com/Bikin-Creative/Lineux-Toolchanger/btc_dev/$bundle_filename";
my $btc_install_folder = glob("~/btc");
my $btc_staging_folder = "$btc_install_folder/config";
my $btc_staging_variables = "$btc_staging_folder/btc_variables.cfg";
my $btc_default_variables = "$btc_install_folder/default_variables.txt";
my $btc_unzip_folder = "$btc_install_folder/unzip";
my $printer_cfg_folder = glob("~/printer_data/config");
my $btc_cfg_folder = "$printer_cfg_folder/btc";
my $btc_variables_cfg = "$btc_cfg_folder/btc_variables.cfg";
my $btc_main_cfg = "$printer_cfg_folder/btc/btc.cfg";

my @variables = ();
my $regex;

if (!-d $btc_cfg_folder) { mkdir ($btc_cfg_folder, 0775) or $!{EEXIST} or die "Make directory $btc_cfg_folder failed!!"; }
symlink($btc_cfg_folder, $btc_staging_folder);
&move_includes_frombtc; # Move includes from btc.cfg. For those using very early versions

#&download_bundle;




&update_file; # Update btc_variables.cfg
#use Data::Dumper; print Dumper $defval{$btc_default_variables}; exit;

sub download_bundle
{ my $ff = File::Fetch->new(uri => $zip_bundle);
  my $file = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
	unzip($bundle_filename, "$btc_unzip_folder");
}

sub move_includes_frombtc
{ open my $btcmain, "<", $btc_main_cfg;
	my @tmpdata = <$btcmain>;
	close $btcmain;
	open my $old, "<", $btc_variables_cfg;
	open my $new, ">", "$btc_variables_cfg.tmp";
	open my $btcnew, ">", "$btc_main_cfg";
	foreach my $templine (@tmpdata)
	{ if (($templine =~ /^\s*(\[include .*?\])/) && ($templine !~ /^\s*(\[include \.\/btc_variables\.cfg\])/))
		{ print $new "$1\n";
			print "Moving $1 from btc.cfg to btc_variables.cfg\n";
		}
		else { print $btcnew $templine; }
	}
	while( <$old> ) { print $new $_; }
  close $old;
  close $new;
  close $btcnew;
  unlink($btc_variables_cfg);
  rename("$btc_variables_cfg.tmp", $btc_variables_cfg);
}

sub update_file
{ my %defval;
  (my $key1, my $values1, @variables) = read_entry($btc_default_variables);
  $defval{$key1} = $values1;
  $regex = join '|', map quotemeta, @variables;
  $regex = qr/^($regex)\s*:\s*/;
  my %btcvar;
  my @addvar;
  my ($key, $values) = read_entry($btc_variables_cfg);
  $btcvar{$key} = $values;
  foreach my $templine (@variables)
  { print "$templine: $btcvar{$btc_variables_cfg}{$templine}\n";
	  if ($btcvar{$btc_variables_cfg}{$templine} eq "")
  	{ push @addvar, $templine;
	  	print "$templine missing, adding $templine: $defval{$btc_default_variables}{$templine}\n";
	  }
  }
  open my $in, "$btc_staging_variables" or die $!;
	my @filedata = <$in>;
	close $in;
	my $addtxt = "";
	foreach my $templine (@addvar)	{ $addtxt .= "$templine: $defval{$btc_default_variables}{$templine}\n";	}
	$addtxt =~ s/\n$//;
	open $in, ">", "$btc_staging_variables" or die $!;
	foreach my $templine (@filedata)
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
