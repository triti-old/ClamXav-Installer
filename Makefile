include /usr/local/share/luggage/luggage.make

TITLE=ClamXav_for_UT_System_Administrators-2.1.1
REVERSE_DOMAIN=edu.utexas.clamxav.pkg

PAYLOAD=\
	unbz2-applications-ClamXav.app\
	pack-Library-LaunchAgents-uk.co.markallan.clamxav.ClamXavSchedule.plist\
	pack-Library-LaunchAgents-uk.co.markallan.clamxav.ClamXavSentry.plist\
	pack-Library-LaunchDaemons-uk.co.markallan.clamxav.clamd.plist\
	pack-Library-Preferences-uk.co.markallan.clamxav.plist\
	pack-usr-local-clamXav-etc-clamd.conf\
	pack-usr-local-bin-ClamXavSchedule.sh\
	pack-script-common.sh\
	pack-script-preflight\
	pack-script-postflight

ClamXav.app.tar.bz2: ClamXav.app Makefile
	${TAR} cjf ClamXav.app.tar.bz2 $<


l_usr_local_clamXav_bin: l_usr_local
	@sudo mkdir -p ${WORK_D}/usr/local/clamXav/bin
	@sudo chown -R root:wheel ${WORK_D}/usr/local/clamXav/bin
	@sudo chmod -R 755 ${WORK_D}/usr/local/clamXav/bin

l_usr_local_clamXav_etc: l_usr_local
	@sudo mkdir -p ${WORK_D}/usr/local/clamXav/etc
	@sudo chown -R root:wheel ${WORK_D}/usr/local/clamXav/etc
	@sudo chmod -R 755 ${WORK_D}/usr/local/clamXav/etc


pack-usr-local-clamXav-bin-%: % l_usr_local_clamXav_bin
	@sudo ${INSTALL} -m 755 -g wheel -o root $< ${WORK_D}/usr/local/clamXav/bin

pack-usr-local-clamXav-etc-%: % l_usr_local_clamXav_etc
	@sudo ${INSTALL} -m 755 -g wheel -o root $< ${WORK_D}/usr/local/clamXav/etc
