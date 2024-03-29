VOLTAGE_DROP=43
MAX_VOLTAGE=4202
MIN_VOLTAGE=3600
is_charging=$(cat /usr/lib/pocketchip-batt/charging)
voltage=$(cat /usr/lib/pocketchip-batt/voltage)
voltage_offset=$(bc <<< "$is_charging*$VOLTAGE_DROP")
excess_voltage=$(bc <<< "$voltage-$voltage_offset-$MIN_VOLTAGE")
max_excess_voltage=$(bc <<< "$MAX_VOLTAGE-$VOLTAGE_DROP-$MIN_VOLTAGE")
percentage=$(bc <<< "scale=2; $excess_voltage/($max_excess_voltage/100)")
status="-" && [[ "$is_charging" == 1 ]] && status="+"
echo $percentage$status