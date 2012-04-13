#!/bin/bash

EXCLUDE_PATTERNS=(
	"\.plist$"
	"\.strings$"
	"\.vmware/.*\.vmdk$"
	"\.sparsebundle/bands/[0-9a-f]+"
)

SCAN_PATHS=(
	"/Applications"
	"/Developer"
	"/Library"
	"/System"
	"/Users"
)

FRESHCLAM_H=09
FRESHCLAM_M=45
FRESHCLAM_D=1,2,3,4,5
FRESHCLAM_CMD="/usr/local/clamXav/bin/RunFreshclam --quiet --log=/usr/local/clamXav/share/clamav/freshclam.log"

CLAMSCAN_H=21
CLAMSCAN_M=45
CLAMSCAN_D=1,2,3,4,5
CLAMSCAN_CMD="/usr/local/clamXav/bin/clamscan -r --log=$HOME/Library/Logs/clamXav-scan.log --scan-mail=yes"

TAB_FORMAT="%s\t%s\t*\t*\t%s\t%s"

# ----------------------------------------------------------------------------

function add_line_to_crontab_file () {
	if [[ -n "$crontab_file" ]]; then
		printf -v crontab_file "%s\n%s" "$crontab_file" "$1"
	else
		crontab_file="$1"
	fi
}

# ----------------------------------------------------------------------------

modified=false
crontab_file="$(/usr/bin/crontab -l 2> /dev/null)"

if [[ "$crontab_file" != *freshclam* ]]; then
	printf -v freshclam_line "$TAB_FORMAT" $FRESHCLAM_M $FRESHCLAM_H $FRESHCLAM_D "$FRESHCLAM_CMD"
	
	add_line_to_crontab_file "$freshclam_line"
	modified=true
fi

if [[ "$crontab_file" != *clamscan* ]]; then
	exclude_args=()
	for entry in "${EXCLUDE_PATTERNS[@]}"; do
		exclude_args+=(--exclude=\"$entry\")
	done
	
	scan_args=()
	for entry in "${SCAN_PATHS[@]}"; do
		scan_args+=(\"$entry\")
	done
	
	printf -v clamscan_line "$TAB_FORMAT" $CLAMSCAN_M $CLAMSCAN_H $CLAMSCAN_D "$CLAMSCAN_CMD ${exclude_args[*]} ${scan_args[*]}"
	
	add_line_to_crontab_file "$clamscan_line"
	modified=true
fi

if $modified; then
	/usr/bin/crontab - <<< "$crontab_file"
fi
