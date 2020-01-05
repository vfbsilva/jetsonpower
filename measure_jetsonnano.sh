#!/bin/bash   
# to measure average power consumed in 30sec with 1sec sampling interval   
duration=30   
interval=1   
RAILS=("VDD_IN /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power0_input"
"VDD_SYS_GPU /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power0_input"
"VDD_SYS_CPU /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power1_input"
"VDD_SYS_SOC /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power1_input"
"VDD_SYS_DDR /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power2_input"
"VDD_4V0_WIFI /sys/bus/i2c/drivers/ina3221x/6-0040/iio_device/in_power2_input")

for ((i = 0; i < ${#RAILS[@]}; i++)); do 
  read -r name[$i] node[$i] pwr_sum[$i] pwr_count[$i]<<<"$(echo "${RAILS[$i]} 0 0")"  
 done  
 end_time=$(($(date +'%s')+duration)) 
  while [ "$(date +'%s')" -le $end_time ]; 
  do  
    for ((i =0; i < ${#RAILS[@]};i++)); do  
   pwr_sum[$i]=$((${pwr_sum[$i]}+$(cat "${node[$i]}"))) && pwr_count[$i]=$((${pwr_count[$i]}+1))  
  done  
 sleep $interval
done  
  echo "RAIL,POWER_AVG";   
for ((i =0; i< ${#RAILS[@]}; i++)); do  
  pwr_avg=$((${pwr_sum[$i]} /${pwr_count[$i]}))  
  echo "${name[$i]},$pwr_avg"   
done