$DaysInactive = 90
$OutputFile = "C:\Temp\Active_VMs.txt"
$time = (Get-Date).Adddays(-($DaysInactive))

$dirpath = "C:\Temp"
If(!(test-path $dirpath))
{
      New-Item -ItemType Directory -Force -Path $dirpath
}

$hostnames = Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name,DNSHostname,Enabled
echo "Total Inactive VMs for more than $DaysInactive days: $($hostnames.Count)"
$active_vms = New-Object System.Collections.ArrayList

foreach ( $hostname in $hostnames )
{
    if ( $hostname.Enabled -eq $true )
    {
        $active_vms.Add("$($hostname.DNSHostName)") > null
    }
}

echo "Number of ENABLED Inactive VMs $($active_vms.Count)"

$active_vms | Out-File -FilePath "$OutputFile"
echo "Outfile file can be found at $OutputFile"