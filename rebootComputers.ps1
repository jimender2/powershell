$s = Get-Content Computers.txt
$creatorusername = ""
$creatorpassword = ConvertTo-SecureString "" -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $creatorusername, $creatorpassword
Stop-Computer -ComputerName $s -Force -Credential $cred
