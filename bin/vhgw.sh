#!/usr/bin/env bash
#

APPDIR=/home/voeis-demo/vhgw/current
PIDFILE=/home/voeis-demo/vhgw/shared/pids/vhgw.pid

case "$1" in
  start)
    echo "Starting vhgw"
    cd $APPDIR
    nohup bundle exec bin/rackup > $APPDIR/log/vhgw.log 2>&1 &
    if [ $! != $$ ]; then
      if [ -x $PIDFILE ]; then
        rm $PIDFILE
      fi
      echo $! > $PIDFILE
    else
      echo "Failed to start vhgw, it appears to already be running."
    fi
  ;;

  restart)
    $0 stop
    $0 start
  ;;

  stop)
    echo "Stopping vhgw"
    cd $APPDIR
    if [ -f $PIDFILE ]; then
      kill -2 `cat $PIDFILE`
      if [ "$!" == "0" ]; then
        rm $PIDFILE
      else
        echo "Failed to kill vhgw."#, resorting to brute force."
        # Find the darn thing and kill it
        #kill -9 `ps auwx | grep trinidad | grep -v grep | awk '{ print $2 }'`
      fi
    fi
  ;;

  *)
    echo ”usage: $0  start|stop|restart”
    exit 3
  ;;
esac
