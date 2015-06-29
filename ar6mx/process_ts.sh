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

# Indicate completion of touchscreen processing
if [ $DONE == "true" ];
   then
      PROP="$("$BIN"/getprop pdiarm.touchscreen)"
      echo "Done with touchscreen processing $PROP"
      exit 0
fi

# if nothing found assume i2c touchscreen
I2CDETECTCMD=`i2cdetect -y 1 0x4a 0x4a | busybox cut -d : -f2 | busybox tail +6 | busybox xargs`
echo Result of i2c detection is $I2CDETECTCMD
if [ $I2CDETECTCMD == "4a" ];
   then
      # load i2c touchscreen 
      RESULT=`insmod /system/lib/modules/atmel_mxt_ts.ko`
      if [ $RESULT -ne "0" ];
      then
         echo "Driver failed to load properly, try removing"
         rmmod atmel_mxt_ts.ko
      fi

      # remove eGalax USB Touch Daemon process 
      PROCESS=`$BIN/ps | $BIN/grep eGTouchD | $BIN/busybox tr -s " " | $BIN/busybox cut -d " " -f 2`
      echo "killing process $PROCESS"
      kill $PROCESS

      # indicate the i2c touchscreen has been setup via properties
      NAME=`cat /sys/bus/i2c/devices/1-004a/name`
      echo "found touchscreen $NAME"
      setprop pdiarm.touchscreen $NAME
      PROP="$("$BIN"/getprop pdiarm.touchscreen)"
      echo "Done with touchscreen processing $PROP"
elif [ $I2CDETECTCMD == "UU" ] 
     then
         echo "Driver already loaded"
         DONE=true
	 exit 126
else
   echo "Device not present"
   DONE=true 
   exit 131
fi

# Indicate completion of touchscreen processing
if [ $DONE == "true" ];
   then
      PROP="$("$BIN"/getprop pdiarm.touchscreen)"
      echo "Done with touchscreen processing $PROP"
      exit 0
fi
