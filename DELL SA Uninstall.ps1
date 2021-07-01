Start-Process powershell -Verb runas
$program = Get-WmiObject -Class win32_product -ComputerName $env:COMPUTERNAME -Filter "Name like '%SupportAssist%'"
$program.Uninstall()