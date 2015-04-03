#!/system/bin/sh

# Test for Atmel or EETI touchscreen
COUNT=`"$BIN"/lsusb | "$BIN"/grep -i atmel | "$BIN"/busybox wc -l`
BIN="/system/bin"

# Atmel touchscreen handling
if [ $COUNT -ge "1" ];
  then
      # try to reset Atmel MXT1664S1 up to five times
      echo "$COUNT Atmel Touchscreen discovered"
      setprop pdiarm.touchscreen Atmel
 
      # Figure out where the Atmel touchscreen is on the usb bus
      PATH=`"$BIN"/lsusb | "$BIN"/grep -i Atmel | "$BIN"/busybox cut -d " " -f 1`
      # Simulating reconnect to CN5 port 
      "$BIN"/usbreset $PATH
      # Send USB packet to Atmel chip to reset itself
      "$BIN"/mxt-app --reset

      RESULT=$?	
      let COUNTER=0
      if [ $RESULT -gt "0" ];
         then
         while [ $COUNTER -lt 5 ]; do
            echo "Retrying mxt-app reset, try $COUNTER"
            # Figure out where the Atmel touchscreen is on the usb bus
            PATH=`"$BIN"/lsusb | "$BIN"/grep -i Atmel | "$BIN"/busybox cut -d " " -f 1`

            # Simulating reconnect to CN5 port 
            "$BIN"/usbreset $PATH
            # Send USB packet to Atmel chip to reset itself
            "$BIN"/mxt-app --reset

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
      fi  
      # For Atmel touchscreens we need to disable the egalax touchscreen 
      PROCESS=`"$BIN"/ps | "$BIN"/grep eGTouchD | "$BIN"/busybox tr -s " " | "$BIN"/busybox cut -d " " -f 2`
      if [ $PROCESS -gt "0" ];
         then
             echo "killing process $PROCESS"
             kill $PROCESS 
      else
          echo "Nothing to kill"
      fi
fi

# EETI touchscreen handling
COUNT=`"$BIN"/lsusb | "$BIN"/grep -i egalax | "$BIN"/busybox wc -l`
if [ $COUNT -ge "1" ];
   then
       echo "$COUNT eGalax Touchscreen discovered"
       setprop pdiarm.touchscreen eGalax
fi

# Indicate completion of touchscreen processing
PROP="$("$BIN"/getprop pdiarm.touchscreen)"
echo "Done with touchscreen processing $PROP"
