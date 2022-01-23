#!/usr/bin/env bash

set -ETeu -o pipefail

#######################################
#
# Destroys the Docker development environment.
#
#######################################
function destroy_environment() {
  docker-compose -f docker-compose.yml down
}

#######################################
#
# Cleans the development environment.
#
#######################################
function cleanup_dev_environment() {
  destroy_environment
}

#######################################
#
# Echoes the usage instructions of the script.
#
#######################################
function usage() {
  cat <<EOF
Usage: bash bin/launch-devenv.bash
EOF
}

#######################################
#
# Prints exit code before exiting.
#
#######################################
function cleanup() {
	local EXIT_CODE=$?

	printf "Exiting: %s\n" "${EXIT_CODE}"
	exit ${EXIT_CODE}
}

#######################################
#
# Main
#
#######################################

# Ensure clean development environment when the script terminates (cleanly or abnormally)
trap cleanup_dev_environment EXIT

# For now, let's force developers to develop inside the container.
# This is the only way we can ensure a clean pipeline directory afterwards.
docker-compose -f docker-compose.yml up \
--build \
-d || cleanup

docker exec -it nestjs-starter-web-1 sh
