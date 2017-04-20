#!/usr/bin/perl -w
# Changed this so that the first arguement is the job name
use strict;

die "Error: No command specified\n" unless scalar(@ARGV);
my $username= (getpwuid($<))[0];

# TODO: use getopt long to offer slick selection of walltime, nondeletion of
# job file, capture of stdout/stderr etc.
my $walltime;

# We could use tmpnam to generate temporary files, but it's probably a good
# idea to err on the side of not cluttering up /tmp with these things.
my $homeDir = $ENV{HOME};
my $jobfileDir = "home/dhanushd/jobfiles/";
mkdir $jobfileDir unless -d $jobfileDir;
die "Error creating directory $jobfileDir: $!" if $?;
my $jobfile= $jobfileDir.'singlenode.job.'.$$;
my $stderrfile = $jobfileDir.'/out/stderr'.$$;
my $stdoutfile = $jobfileDir.'/out/stdout'.$$;
# This is what gets displayed in the output of "qstat -n" and suchlike
my $jobname = $ARGV[0];
$jobname =~ s/.*\///;

# Number of CPU cores to allocate (there are 16 per backend node)
my $ppn=2;

open F, ">$jobfile" or die "Error: Unable to write to temporary job file '$jobfile'\n";
print F "#!/bin/sh\n";
#print F "#PBS -e /dev/null -o /dev/null -N $jobname -l nodes=1:ppn=$ppn\n";
print F "#PBS -e $stderrfile -o $stdoutfile -N $jobname -l procs=$ppn,pmem=3gb\n";
print F "#PBS -l walltime=$walltime:00:00\n" if defined $walltime;
print F "#PBS -l walltime=24:00:00\n";
print F "#PBS -M afyshe\@uvic.ca -m abe\n";
print F "#PBS -q default\n";
print F "cd \$PBS_O_WORKDIR\n";

my $argnum = 1;
foreach $argnum (1 .. $#ARGV) {
    print F "$ARGV[$argnum] ";
}
print F "\n";
#print F "@ARGV\n";
close F;

my $qsubcmd = "qsub $jobfile";
system $qsubcmd;
die "Error executing '$qsubcmd': $!\n" if $?;

#unlink $jobfile;
