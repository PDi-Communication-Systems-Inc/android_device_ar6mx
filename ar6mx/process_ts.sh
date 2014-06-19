#!/system/bin/sh

COUNT=`lsusb | grep -i atmel | busybox wc -l`
if [ $COUNT -ge "1" ];
  then
      echo "$COUNT Atmel Touchscreen discovered"
      setprop pdiarm.touchscreen Atmel
      getprop pdiarm.touchscreen
      mxt-app -i
      mxt-app --reset
      PROCESS=`ps | grep eGTouchD | busybox tr -s " " | busybox cut -d " " -f 2`
      if [ $PROCESS -gt "0" ];
         then
             echo "killing process $PROCESS"
             kill $PROCESS 
      else
          echo "Nothing to kill"
      fi
      setprop pdiarm.touchscreen 
fi
COUNT=`lsusb | grep -i egalax | busybox wc -l`
if [ $COUNT -ge "1" ];
   then
       echo "$COUNT eGalax Touchscreen discovered"
       setprop pdiarm.touchscreen eGalax
fi
echo "Done with touchscreen processing"
