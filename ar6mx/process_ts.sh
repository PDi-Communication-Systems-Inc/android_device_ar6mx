#!/system/bin/sh

# Test for Atmel or EETI touchscreen
COUNT=`lsusb | grep -i atmel | busybox wc -l`

# Atmel touchscreen handling
if [ $COUNT -ge "1" ];
  then
      # try to reset Atmel MXT1664S1 up to five times
      echo "$COUNT Atmel Touchscreen discovered"
      setprop pdiarm.touchscreen Atmel
      mxt-app --reset
      RESULT=$?	
      let COUNTER=0
      if [ $RESULT -gt "0" ];
         then
         while [ $COUNTER -lt 5 ]; do
            echo "Retrying mxt-app reset, try $COUNTER"
            PATH=`lsusb | grep -i Atmel | busybox cut -d " " -f 1`

            # Simulating reconnect to CN5 port 
            usbreset $PATH
            # Send USB packet to Atmel chip to reset itself
            mxt-app --reset

            # Check to see if we need to repeat process
            RESULT=$?
            if [ $RESULT -eq "0" ];  
               then
               # stop any additional attempts and display info on Atmel chip
               let COUNTER=100
               mxt-app -i
            else
               # try again
               let COUNTER=COUNTER+1
            fi  
         done
      fi  
      # For Atmel touchscreens we need to disable the egalax touchscreen 
      PROCESS=`ps | grep eGTouchD | busybox tr -s " " | busybox cut -d " " -f 2`
      if [ $PROCESS -gt "0" ];
         then
             echo "killing process $PROCESS"
             kill $PROCESS 
      else
          echo "Nothing to kill"
      fi
fi

# EETI touchscreen handling
COUNT=`lsusb | grep -i egalax | busybox wc -l`
if [ $COUNT -ge "1" ];
   then
       echo "$COUNT eGalax Touchscreen discovered"
       setprop pdiarm.touchscreen eGalax
fi

# Indicate completion of touchscreen processing
PROP="$(getprop pdiarm.touchscreen)"
echo "Done with touchscreen processing $PROP"
