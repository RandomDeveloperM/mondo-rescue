use 5.006001;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'PBPKG',
    DISTNAME     => 'PBPKG',
    VERSION      => 'PBVER',
    INST_SCRIPT  => 'blib/sbin',
	INSTALLDIRS  => 'vendor',
    PREREQ_PM    => {
			#HTTP::Headers                    => 1.59,
			#Template                         => 0,
    },    # e.g., Module::Name => 1.1
	#ABSTRACT_FROM => 'sbin/mrmini',   # retrieve abstract from module
    AUTHOR        => 'Bruno Cornec <bruno#mondorescue.org>',
	EXE_FILES     => [ qw( sbin/mrmini sbin/mrprepare-lvm ) ],
	MAN1PODS      => { 
			'sbin/mrmini' => '$(INST_MAN1DIR)/mrmini.$(MAN1EXT)', 
			'sbin/mrprepare-lvm' => '$(INST_MAN1DIR)/mrprepare-lvm.$(MAN1EXT)', 
					},
	MAN3PODS      => {	
			'lib/MondoRescue/Mini/Base.pm' => '$(INST_MAN3DIR)/MondoRescue::Mini::Base.$(MAN3EXT)',
			},
);


package MY;

sub postamble {

	use MondoRescue::DynConf;

	my ($confdir,$proj) = mr_dynconf_init();

	my $text .= "install ::\n";
	$text .= "\t".'@echo PBPKG PBVER-rPBREV will be installed under $(DESTDIR)'."\n";
	$text .= "\tinstall -m 755 -d ".' $(DESTDIR)/$(INSTALLMAN1DIR)/../man5 $(DESTDIR)'."/$confdir/".'; cp etc/PBPKG.conf $(DESTDIR)'."/$confdir/PBPKG.conf.dist ; pod2man etc/PBPKG.conf > ".'$(DESTDIR)/$(INSTALLMAN1DIR)/../man5/PBPKG.conf.5'."\n";
	$text .= "\t".'md5sum $(DESTDIR)'."$confdir/PBPKG.conf.dist > ".'$(DESTDIR)'."$confdir/PBPKG.conf.dist.md5\n";
	return($text);
}
