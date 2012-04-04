#!/usr/bin/perl
    use strict;
    use warnings;
    use File::stat;
    use Time::localtime;
    use Mail::Mailer;
#watch the directory for existing files in intervals of 10 minutes = process, service, scheduled task

my $processDir = "/path/to/watch/";
my $productionDir = "/path/to/dump/";
my @oldFiles = ();

chdir $processDir or die "Can't find process: $!\n";
my @files = <*>;

    opendir (DIR, $processDir) || die "Nice try Dingus: $!\n";
	foreach my $file(@files) {
 	my $modDate = ctime(stat($file)->mtime);
	my $minuteDiff = int((time - stat($file)->mtime) / 60);		#the file's age in minutes
	if ($minuteDiff >= 5) {
	    push(@oldFiles, $file);
	    print "$file in $processDir is $minuteDiff minutes old\n";
	} 
     }

my $joinFiles = join(", ", @oldFiles);

if (@oldFiles) {
my $message = "Type a message here.";

my $mailer = Mail::Mailer->new("smtp", Server => 'mailserver.domain.net');
$mailer->open( { From => 'Talbot Lawrence <talbotlawrence@mail.com>',
		To => 'Talbot Lawrence <talbotlawrence@mail.com>',
		Subject => 'URGENT' } ) || die "mailer->open failed: $!\n";

print $mailer $message; 
$mailer->close || die "can't close mailer: $!\n";
} 

    closedir(DIR);
    exit 0;
