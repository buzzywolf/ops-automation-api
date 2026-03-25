
$list = Get-WinEvent  -FilterHashtable @{LogName = 'Security';Id =4625}

$startTime = (Get-Date).AddMinutes(-30)
$arr=@()
ForEach ($log in $list){
if($log.StartTime -ge $startTime)
{
$arr+=$log
}
}
$LISTOFip=@()
Write-Host "the next ip adresss failed to enter your computer"
ForEach ($log in $arr){
$xmlEV=[xml]$log.ToXml()
$ip = ($xmlEV.Event.EventData.Data | where-Object {$_.Name -eq "IpAddress"}).'#text'
$LISTOFip+=$ip
Write-Host $ip
}



foreach ($LIS in $LISTOFip)
{
$counter=0
foreach ($LI in $LISTOFip)
{
$attackARR=@()
if($LI -eq $LIS)
{
$counter+=1
}

}
$counter = $counter
Write-Host "the ip address:" $LIS "attacked:" $counter "times in the last 30 minutes"
if( $counter -gt 3)
{
   $attackARR+=$LIS
}
}
$attackARR | ConvertTo-Json

