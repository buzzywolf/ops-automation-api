
$list = Get-WinEvent  -FilterHashtable @{LogName = 'Security';Id =4625} -ErrorAction SilentlyContinue

$startTime = (Get-Date).AddMinutes(-30)
$arr=@()
ForEach ($log in $list){
if($log.TimeCreated -ge $startTime)
{
$arr+=$log
}
}
$LISTOFip=@()
#Write-Host "the next ip adresss failed to enter your computer"

ForEach ($log in $arr){
$xmlEV=[xml]$log.ToXml()
$ip = ($xmlEV.Event.EventData.Data | where-Object {$_.Name -eq "IpAddress"}).'#text'
$LISTOFip+=$ip
#Write-Host $ip
}


$attackARR=@()
foreach ($LIS in $LISTOFip)
{
$counter=0
foreach ($LI in $LISTOFip)
{

if($LI -eq $LIS)
{
$counter+=1
}

}
$counter = $counter
# Write-Host "the ip address:" $LIS "attacked:" $counter "times in the last 30 minutes"
if( $counter -gt 3)
{
   $attackARR+=$LIS
}
}
# Convert to JSON, and ensure we only output unique IPs, forced as an array
@($attackARR | Select-Object -Unique) | ConvertTo-Json
