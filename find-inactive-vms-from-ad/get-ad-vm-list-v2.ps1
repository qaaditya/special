$DaysInactive = 90
$time = (Get-Date).Adddays(-($DaysInactive))
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name,DNSHostname,Enabled | select DNSHostName,Enabled | Export-CSV “C:\Temp\HostNames.txt” –NoTypeInformation

Get-Content -Path “C:\Temp\HostNames.txt” | Where-Object {$_ -like '*True*'}

#| Export-CSV “C:\Temp\StaleComps.CSV” –NoTypeInformation

