#!/system/bin/sh

# Test for Atmel or EETI touchscreen
BIN=/system/bin
COUNT=`$BIN/lsusb | $BIN/grep -i atmel | $BIN/busybox wc -l`
DONE=false

# Atmel touchscreen handling
if [ $COUNT -ge "1" ];
  then
      # try to reset Atmel MXT1664S1 up to five times
      echo "$COUNT Atmel Touchscreen discovered"
      setprop pdiarm.touchscreen Atmel
 
      # Figure out where the Atmel touchscreen is on the usb bus
      PATH=`$BIN/lsusb | $BIN/grep -i Atmel | $BIN/busybox cut -d " " -f 1`
      # Simulating reconnect to CN5 port 
      "$BIN"/usbreset "$PATH"
      # Send USB packet to Atmel chip to reset itself
      "$BIN"/mxt-app -v 4 --reset

      RESULT=$?	
      let COUNTER=0
      if [ $RESULT -gt "0" ];
         then
         while [ $COUNTER -lt 5 ]; do
            echo "Reset failed with result code $RESULT ... Retrying mxt-app reset, try $COUNTER"
            # Figure out where the Atmel touchscreen is on the usb bus
            PATH=`$BIN/lsusb | $BIN/grep -i Atmel | $BIN/busybox cut -d " " -f 1`

            # Simulating reconnect to CN5 port 
            "$BIN"/usbreset "$PATH"
            # Send USB packet to Atmel chip to reset itself
            "$BIN"/mxt-app -v 4 --reset 

            # Check to see if we need to repeat process
            RESULT=$?
            if [ $RESULT -eq "0" ];  
               then
               # stop any additional attempts and display info on Atmel chip
               let COUNTER=100
               "$BIN"/mxt-app -i
            else
               # try again
               let COUNTER=COUNTER+1
            fi  
         done
      else
	    echo Atmel initalized okay with result code $RESULT
      fi  
      # For Atmel touchscreens we need to disable the egalax touchscreen 
      PROCESS=`$BIN/ps | $BIN/grep eGTouchD | $BIN/busybox tr -s " " | $BIN/busybox cut -d " " -f 2`
      if [ $PROCESS -gt "0" ];
         then
             echo "killing process $PROCESS"
             kill $PROCESS 
      else
          echo "Nothing to kill"
      fi
      DONE=true
fi

# EETI touchscreen handling
COUNT=`$BIN/lsusb | $BIN/grep -i egalax | $BIN/busybox wc -l`
if [ $COUNT -ge "1" ];
   then
       echo "$COUNT eGalax Touchscreen discovered"
       setprop pdiarm.touchscreen eGalax
       DONE=true
fi

# if nothing found assume i2c touchscreen
if [ DONE -eq "false"]
   then
      PROCESS=`$BIN/ps | $BIN/grep eGTouchD | $BIN/busybox tr -s " " | $BIN/busybox cut -d " " -f 2`
      echo "killing process $PROCESS"
      kill $PROCESS
      NAME=`cat /sys/bus/i2c/devices/1-004a/name`
      echo "found touchscreen $NAME"
      setprop pdiarm.touchscreen $NAME
fi

# Indicate completion of touchscreen processing
PROP="$("$BIN"/getprop pdiarm.touchscreen)"
echo "Done with touchscreen processing $PROP"
