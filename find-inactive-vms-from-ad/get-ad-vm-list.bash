cat stalecomps.csv | awk -F '"' {'print $4,$6'} | grep True
