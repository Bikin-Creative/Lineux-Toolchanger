#!/usr/bin/perl

use File::Fetch;
use IO::Uncompress::Unzip qw($UnzipError);
use IO::File;
use JSON::PP 'decode_json';
use File::Spec::Functions qw(splitpath);
use File::Path qw(mkpath);
use File::Copy qw(copy);

$tmploc = "https://www.myperniagaan.com/lineux";
$version = 2.1;
$versions_file = "$tmploc/versions.txt";
$btc_util_file = "$tmploc/btc_util.pl";
$bundle_filename = "btc.zip";
$btc_bundle = "$tmploc/$bundle_filename";

$btc_install_folder = glob("~/btc");
$btc_unzip_folder = "$btc_install_folder/unzip";




$src_api = "https://api.github.com/repos/Bikin-Creative/Lineux-Toolchanger/releases/latest";
$btc_backup_folder = "$btc_install_folder/backup";
$btc_staging_folder = "$btc_install_folder/config";
$btc_staging_variables = "$btc_staging_folder/btc_variables.cfg";
$btc_default_variables = "$btc_install_folder/default_variables.txt";

$printer_cfg_folder = glob("~/printer_data/config");
$btc_cfg_folder = "$printer_cfg_folder/btc";
$btc_variables_cfg = "$btc_cfg_folder/btc_variables.cfg";
$btc_main_cfg = "$printer_cfg_folder/btc/btc.cfg";

@alltoolboards = ("H36", "EBB36", "SHT36", "Nitehawk", "Others");
@toolboardfile = ("h36", "ebb36", "sht36", "nitehawk", "ebb36");
@variables = ();

if (!-d $btc_cfg_folder) { mkdir ($btc_cfg_folder, 0775) or $!{EEXIST} or die "Make directory $btc_cfg_folder failed!!"; }

&check_versions;
&main_menu;
exit;

my ($dowhat, $latest_tag);
my $tooltxt = "";
my $decoded;







#&update_file; # Update btc_variables.cfg
#use Data::Dumper; print Dumper $defval{$btc_default_variables}; exit;

sub download_bundle
{ print "Downloading package...";
  $ff = File::Fetch->new(uri => $btc_bundle);
  $fh = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
  unzip("$btc_install_folder/$bundle_filename", "$btc_unzip_folder");
  unlink("$btc_install_folder/$bundle_filename.zip");
}

sub installbtc
{ print "\nHow many tools will you be using? Your choice: ";
	my $toolnum = <STDIN>;
  chomp $toolnum;
  my @toolboards = ();
  my $toolboard;
  for (my $i=1;$i<=$toolnum;$i++)
  { print "\nWhat is toolboard $i?\n1. H36, 2. EBB36, 3. SHT36, 4. Nitehawk, 5. Others or not sure. Your choice: ";
	  $toolboard = <STDIN>;
    chomp $toolboard;
    push @toolboards, $toolboard-1;
    $tooltxt .= "Tool $i: $alltoolboards[$toolboard-1]\n";
  }
  &download_bundle;
  exit;
  &backupconfig;
  &moveconfig;
  &setuptoolboard(\@toolboards);
	print "\nInstalling ...";
  print "\nDone!\n$tooltxt\nNext step is to firmware restart and check for cfg errors.\n";
}

sub doinstall
{ print "\nWhat do you want to install?\n1. Install Btc (Dockslide included)\n2. Install Dockslide (Not required if Btc is installed)\n3. Back\n4. Quit\n\nYour choice: ";
	my $dowhat = <STDIN>;
  chomp $dowhat;
  if ($dowhat eq "1") { &installbtc; }
  elsif ($dowhat eq "2") { &installdockslide; }
  elsif ($dowhat eq "3") { &main_menu; }
  elsif ($dowhat eq "4") { exit; }
  else
  { print "\nInvalied choice: $dowhat\n";
  	### Do something TODO
  	&doinstall;
  }
}

sub main_menu
{ print "\nWelcome to Btc Utility\nWhat do you want to do?\n1. Install new\n2. Update\n3. Add tool\n4. Quit\n\nYour choice: ";
	my $dowhat = <STDIN>;
  chomp $dowhat;
  if ($dowhat eq "1") { &doinstall; }
  elsif ($dowhat eq "4") { exit; }
}

sub check_versions
{ my $ff = File::Fetch->new(uri => $versions_file);
  my $fh = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
	open (TMP, "$btc_install_folder/versions.txt");
	@versions = <TMP>;
	close (TMP);
	foreach $templine (@versions)
	{ ($key, $value) = split (/\|/, $templine);
		$version{$key} = $value;
	}
	if ($version{btc_util} > $version)
	{ print "btc_util has a newer version. Downloaded, please restart btc_util\n";
		$ff = File::Fetch->new(uri => $btc_util_file);
    $fh = $ff->fetch(to => "$btc_install_folder") or die $ff->error;
    exit;
	}
}




























sub setuptoolboard
{ my @toolboards = @{$_[0]};
	open my $tooltemplate, "<", "$btc_install_folder/toolboard_template.txt";
	my $template = do { local $/; <$tooltemplate> };
	for (my $i=0;$i<scalar(@toolboards);$i++)
	{ my $newtemplate = $template;
		$newtemplate =~ s/<gcode_macro_variables>/[gcode_macro _Variables_t$i]/;
		open my $pinjson, "<", "$btc_install_folder/$toolboardfile[$toolboards[$i]]_pins.json";
	  my $json = do { local $/; <$pinjson> };
    $decoded = decode_json($json);
    $latest_tag = $decoded->{tag_name};
		keys %$decoded; # reset the internal iterator so a prior each() doesn't affect the loop
    while(my($k, $v) = each %$decoded) { $newtemplate =~ s/<$k>/$k: toolboard$i: $v/; }
    open my $newcfg, ">", "$btc_install_folder/tmp/tool_$i.cfg";
    print $newcfg $newtemplate;
	}
}



sub backupconfig
{ print "\nBacking up current configs...";
	if (!-d "$btc_backup_folder/30062025") { mkdir ("$btc_backup_folder/30062025", 0775) or $!{EEXIST} or die "Make directory $btc_install_folder failed!!"; }
	rename $btc_cfg_folder, "$btc_backup_folder/30062025/";
	mkdir ($btc_cfg_folder, 0775);
}

sub moveconfig
{ print "\nCopying new configs...";
	my $zipfolder = "$btc_unzip_folder/Bikin-Creative-Lineux-Toolchanger-9d9acd0Klipper";
	rename $zipfolder, "$btc_cfg_folder/";
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

# Unzip code by Daniel S. Sterling <sterling.daniel@gmail.com>
# https://gist.github.com/eqhmcow/5389877
sub unzip
{ my ($file, $dest) = @_;

  die 'Need a file argument' unless defined $file;
  $dest = "." unless defined $dest;
  $dest =~ s!/|\\$!!;

  die "File argument is a directory: $file" if -d $file;

  die "No such file: $file $!" unless -e $file;

  my $u = IO::Uncompress::Unzip->new($file) or die "Cannot open $file: $UnzipError";

  my $status;
  my %dirs;
  for ($status = 1; $status > 0; $status = $u->nextStream())
  { # bail on error
    last if $status < 0;

    my $header = $u->getHeaderInfo();
    my $stored_time = $header->{'Time'};
    my (undef, $path, $name) = splitpath($header->{Name});
    $path =~ s!/|\\$!!;
    $name =~ s!/|\\$!!;

    my $destdir = "/$dest/$path";
    my $destfile = "$destdir/$name";
    # https://cwe.mitre.org/data/definitions/37.html
    # CWE-37: Path Traversal
    die "unsafe $destfile" if $destfile =~ m!\Q..\E(/|\\)!;

    # don't try to overwrite an extant file by creating a directory
    if (-e $destdir and not -d $destdir) { die "Cannot create directory $destdir: File or path already exists.\nTry extracting to a different directory."; }

    # skip if the entire path is just an extant directory
    if (-d $destfile) { next; }

    # ok let's make a directory for this zip archive entry
    unless (-d $destdir)
    { mkpath($destdir) or die "Couldn't mkdir $destdir: $!";

      # we're done if the entire path is simply the directory we
      # just created
      if (-d $destfile)
      { # this entry is probably for the directory itself, so store
        # its mtime, because we have to touch all the dirs after
        # creating all the files; otherwise as we process the archive,
        # file creation will just reset each directory's mtime
        $dirs{$destdir} = $stored_time;

        next;
      }
    }

    # ok we should have a valid file here we can extract
    my $buff;
    my $fh = IO::File->new($destfile, "w") or die "Couldn't write to $destfile: $!";

    $fh->binmode();

    while (($status = $u->read($buff)) > 0) { $fh->write($buff); }
    $fh->close();
    utime ($stored_time, $stored_time, $destfile) or die "Couldn't touch $destfile: $!";
  }

  die "Error processing $file: $UnzipError $!\n" if $status < 0 ;

  # touch all the dirs that we created and that also had explicit directory
  # entries in the archive
  foreach my $dirpath (keys %dirs)
  { my $stored_time = $dirs{$dirpath};
    utime ($stored_time, $stored_time, $dirpath) or die "Couldn't touch directory $dirpath: $!";
  }
  return;
}
