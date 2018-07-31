#!/bin/sh
#
# snmp_exporter          Start/Stop the snmp exporter daemon.
#
# chkconfig: 2345 71 66
# description: A self-made script that communicates health status to prometheus.

### BEGIN INIT INFO
# Provides: snmp_exporter
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Description: A self-made script that communicates health status to prometheus.
### END INIT INFO

# Source function library.
. /etc/init.d/functions

RETVAL=0
exec=/usr/bin/snmp_exporter
prog=snmp_exporter
lockfile=/var/lock/subsys/snmp_exporter
config=/etc/prometheus/snmp_exporter.yml

start() {
    [ "$EUID" != "0" ] && exit 4
    [ -x $exec ] || exit 5
    [ -f $config ] || exit 6

    echo -n $"Starting $prog: "
    daemon $prog -config.file=$config 9116 &
    RETVAL=$?

    echo
    [ $RETVAL -eq 0 ] && touch $lockfile
    return $RETVAL
}

stop() {
    [ "$EUID" != "0" ] && exit 4
    echo -n $"Shutting down $prog: "
    killproc $prog
    RETVAL=$?

    echo
    [ $RETVAL -eq 0 ] && rm -f $lockfile
    return $RETVAL
}

restart() {
    rh_status_q && stop
    start
}

reload() {
  echo -n $"Reloading $prog: "
  if [ -n "`pidfileofproc $exec`" ]; then
    killproc $exec -HUP
  else
    failure $"Reloading $prog"
  fi
  retval=$?
  echo
}

force_reload() {
  # new configuration takes effect after restart
    restart
}

rh_status() {
    # run checks to determine if the service is running or use generic status
    status -p /var/run/node_exporter.pid $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}


# See how we were called.
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status $prog
    ;;
  restart|force-reload)
    stop
    start
    ;;
  try-restart|condrestart)
    if status $prog > /dev/null; then
        stop
        start
    fi
    ;;
  reload)
    exit 3
    ;;
  *)
    echo $"Usage: $0 {start|stop|status|restart|try-restart|force-reload}"
    exit 2
esac