#!/usr/bin/env bash
#
CURDIR=$(dirname $0)
cd $CURDIR/..
APPDIR=`/usr/bin/env pwd`
PIDFILE=$APPDIR/tmp/pids/vhgw.pid

#echo "Application root is $APPDIR"

case "$1" in
    start)
        echo "Starting vhgw"
        cd $APPDIR
        nohup bundle exec trinidad -p 4000  -r --load daemon --daemonize $PIDFILE > $APPDIR/log/vhgw.log 2>&1 &
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
            kill `cat $PIDFILE`
            if [ $? == 0 ]; then
                rm $PIDFILE
            else
                echo "Failed to kill vhgw, resorting to brute force."
        # Find the darn thing and kill it
	        PID="`ps auwx | grep rackup | grep -v grep | awk '{ print $2 }'`"
	        if [ $PID != "" ]; then
	            kill -9 $PID
	        else
	            echo "Process not found, must not be running!"
	        fi
            fi
        fi
        ;;
    
    *)
        echo "usage: $0  start|stop|restart"
        exit 3
        ;;
esac
