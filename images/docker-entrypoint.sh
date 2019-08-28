#!/bin/bash

# Enable LLDP on each ethX interface and provide SNMP daemon.

SNMPD_BIN=/usr/sbin/snmpd
LLDPD_BIN=/sbin/lldpd

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option
usage() {
    echo ""
    echo "Docker entry script for Intel LLDPAD service container"
    echo ""
    echo "-h: Show this help."
    echo "-s: Start SNMP and LLDP daemon."
    echo ""
}

# start SNMP daemon
startSnmpDaemon() {
  ${SNMPD_BIN} -f ${OPTIONS} -c /etc/snmp/snmpd.conf &
}

startLldpd() {
  ${LLDPD_BIN} -x -dd -l
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
    usage
    exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts fhis flag; do
    case ${flag} in
        s)
            startSnmpDaemon
            startLldpd
            exit
            ;;
        h)
            usage
            exit
            ;;
        *)
            usage
            exit ${E_ILLEGAL_ARGS}
            ;;
    esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
    echo "Error: To many arguments: ${*}."
    usage
    exit ${E_ILLEGAL_ARGS}
fi
