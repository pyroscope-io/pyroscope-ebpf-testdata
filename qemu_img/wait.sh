#!/usr/bin/env bash
set -ex

# TODO move it to makefile somehow?

connect="ssh -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost"

wait_for_ssh() {
  local retries=0
  while ! (${connect} true); do
    if [[ "${retries}" -gt 30 ]]; then
      echo "SSH connection failed after 30 retries"
      exit 1
    fi
    retries=$((retries + 1))
    sleep 1
  done
}

wait_for_ssh


${connect} date -s "@$(date +%s)"
${connect} date 
