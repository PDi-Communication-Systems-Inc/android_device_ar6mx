#!/system/bin/sh

COUNT=`lsusb | grep -i atmel | busybox wc -l`
if [ $COUNT -ge "1" ];
  then
      echo "$COUNT Atmel Touchscreen discovered"
      setprop pdiarm.touchscreen Atmel
      mxt-app -i
      RESULT=$?	
      let COUNTER=0
      if [ $RESULT -gt "0" ];
         then
         while [ $COUNTER -lt 2 ]; do
            echo "Retrying mxt-app, try $COUNTER"
            mxt-app -i
            RESULT=$?
            if [ $RESULT -eq "0" ]; 
               then
               let COUNTER=100
            else
	       let COUNTER=COUNTER+1
	    fi
         done
      fi
      mxt-app --reset
      RESULT=$? 
      COUNTER=0
      if [ $RESULT -gt "0" ];
         then
         while [ $COUNTER -lt 2 ]; do
            echo "Retrying mxt-app, try $COUNTER"
            mxt-app --reset
            RESULT=$?
            if [ $RESULT -eq "0" ]; 
               then
               let COUNTER=100
            else
               let COUNTER=COUNTER+1
            fi
         done
      fi
      PROCESS=`ps | grep eGTouchD | busybox tr -s " " | busybox cut -d " " -f 2`
      if [ $PROCESS -gt "0" ];
         then
             echo "killing process $PROCESS"
             kill $PROCESS 
      else
          echo "Nothing to kill"
      fi
fi
COUNT=`lsusb | grep -i egalax | busybox wc -l`
if [ $COUNT -ge "1" ];
   then
       echo "$COUNT eGalax Touchscreen discovered"
       setprop pdiarm.touchscreen eGalax
fi
PROP="$(getprop pdiarm.touchscreen)"
echo "Done with touchscreen processing $PROP"
