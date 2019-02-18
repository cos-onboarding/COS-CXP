#!/bin/bash

#
# Usage: run.sh [-b]
#

#
# Check that a build has been run.
#

BASE_PATH=$(pwd)
LOG_PATH=$BASE_PATH

if [ ! -d "${BASE_PATH}/data" ]; then
    echo 'You need to run the initial build first:'
    echo '    `mvn clean install -Pclean-database`'
    exit 1
fi


# run paths.
CONTENT_SERVICES_PATH="webapps/contentservices"
PORTAL_SERVER_PATH="webapps/portalserver"
ORCHESTRATOR_PATH="webapps/orchestrator"
SOLR_PATH="webapps/solr"
SEARCH_PATH="webapps/search"

# run commands.
CONTENT_SERVICES_RUN="sh run.sh"
PORTAL_SERVER_RUN="sh run.sh"
PORTAL_SERVER_RUN_DEMO="sh run_with_demo.sh"
ORCHESTRATOR_RUN="sh run.sh"
SOLR_RUN="sh run.sh"
SEARCH_RUN="sh run.sh"

# check run in bg.
RUN_IN_BG=true
if [ ! -z `command -v osascript` ]; then
	RUN_IN_BG=false
fi

while getopts "bd" opt; do
	case $opt in
		b)
			RUN_IN_BG=true
			;;
		d)
			PORTAL_SERVER_RUN=$PORTAL_SERVER_RUN_DEMO
			;;
	esac
done

function run_in_tab() {
	NAME=$1; shift
	RUN_PATH=$1; shift
	RUN_CMD=$1; shift

	COMMAND="cd ${BASE_PATH}/${RUN_PATH} && $RUN_CMD"
	osascript \
		-e "tell application \"Terminal\"" \
		-e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
		-e "do script \"printf '\\\e]1;$NAME\\\a'; $COMMAND\" in front window" \
		-e "end tell" > /dev/null
}

function run_in_bg() {
	NAME=$1; shift
	RUN_PATH=$1; shift
	RUN_CMD=$1; shift
	# to kill: "pkill -f jetty"
	( cd ${BASE_PATH}/${RUN_PATH} && $RUN_CMD &> ${LOG_PATH}/${RUN_PATH}/run.log & )
}

function run_server() {
	if [ "$RUN_IN_BG" = true ]; then
		run_cmd="run_in_bg"
		echo "Starting $1 in background (run 'pkill -f jetty' to stop)"
	else
		run_cmd="run_in_tab"
	fi
	$run_cmd "$@"
}

function main() {
	run_server "Content Services" "$CONTENT_SERVICES_PATH" "$CONTENT_SERVICES_RUN"
	run_server "Portal Server" "$PORTAL_SERVER_PATH" "$PORTAL_SERVER_RUN"
	run_server "Orchestrator" "$ORCHESTRATOR_PATH" "$ORCHESTRATOR_RUN"
	run_server "Solr" "$SOLR_PATH" "$SOLR_RUN"
	run_server "Search Services" "$SEARCH_PATH" "$SEARCH_RUN"
}

# run the servers
main
