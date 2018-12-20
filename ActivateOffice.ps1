$s = Get-Content Computers.txt
$creatorusername = ""
$creatorpassword = ConvertTo-SecureString "" -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $creatorusername, $creatorpassword

Invoke-Command -ComputerName $s -ScriptBlock { cscript "\Program Files\Microsoft Office\Office16\ospp.vbs" /inkey:""}
Invoke-Command -ComputerName $s -ScriptBlock { cscript "\Program Files\Microsoft Office\Office16\ospp.vbs" /act}
