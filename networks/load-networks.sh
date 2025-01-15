#!/bin/bash

# Auto-detect repository from remote URL or use default
if [ -z "${GITHUB_REPOSITORY}" ]; then
    GITHUB_REPOSITORY=$(git remote get-url origin 2>/dev/null | \
                      sed -E 's/.*github.com[:/](.+)(\.git)?/\1/' || \
                      echo "sourcegraph/networks")
fi

BASE_URL="https://raw.githubusercontent.com/${GITHUB_REPOSITORY}/master/networks"

usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo "  -a, --all         Load all networks"
  echo "  -4, --ipv4        Load only IPv4 networks"
  echo "  -6, --ipv6        Load only IPv6 networks"
  echo "  -c, --company     Load specific company networks"
  echo "      --all         With --company: load both IPv4 and IPv6"
  echo "      --ipv4        With --company: load only IPv4"
  echo "      --ipv6        With --company: load only IPv6"
  echo "  -l, --list        List available companies"
  echo "  -h, --help        Show this help"
  exit 1
}

load_company() {
  local company=$1
  local type=$2
  
  echo "Creating ipset for ${company}..."
  ipset create "${company}" hash:net family "${type}" -exist
  
  if [ "${type}" = "inet" ]; then
    curl -s "${BASE_URL}/ipv4/${company}.ipset" | grep "^ipset add" | bash
  else
    curl -s "${BASE_URL}/ipv6/${company}.ipset" | grep "^ipset add" | bash
  fi
}

load_all_ipv4() {
  for file in $(curl -s "${BASE_URL}/ipv4/" | grep -o '[^>]*\.ipset'); do
    company=$(basename "${file}" .ipset)
    load_company "${company}" inet
  done
}

load_all_ipv6() {
  for file in $(curl -s "${BASE_URL}/ipv6/" | grep -o '[^>]*\.ipset'); do
    company=$(basename "${file}" .ipset)
    load_company "${company}" inet6
  done
}

list_companies() {
  echo "Available companies:"
  curl -s "${BASE_URL}/ipv4/" | grep -o '[^>]*\.ipset' | sed 's/\.ipset//'
}

COMPANY=""
MODE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--company)
      COMPANY="$2"
      shift 2
      ;;
    -a|--all)
      MODE="all"
      shift
      ;;
    -4|--ipv4)
      MODE="ipv4"
      shift
      ;;
    -6|--ipv6)
      MODE="ipv6"
      shift
      ;;
    -l|--list)
      list_companies
      exit 0
      ;;
    *)
      usage
      ;;
  esac
done

if [ -n "$COMPANY" ]; then
  case "$MODE" in
    "all"|"")
      load_company "$COMPANY" inet
      load_company "$COMPANY" inet6
      ;;
    "ipv4")
      load_company "$COMPANY" inet
      ;;
    "ipv6")
      load_company "$COMPANY" inet6
      ;;
  esac
else
  case "$MODE" in
    "all")
      load_all_ipv4
      load_all_ipv6
      ;;
    "ipv4")
      load_all_ipv4
      ;;
    "ipv6")
      load_all_ipv6
      ;;
    *)
      usage
      ;;
  esac
fi
