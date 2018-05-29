Import-Module ActiveDirectory


$Domain='blackriver.k12.oh.us'
$studentOrStaff = Read-Host -Prompt 'Is this for a student or staff member?'
$firstName = Read-Host -Prompt 'Input the first name of the user'
$lastName = Read-Host -Prompt 'Input the last name of the user'
$id = Read-Host -Prompt 'Input the student id of the user'

$fullName = '18jmeredith'
Write-Host $fullName
$securepassword=ConvertTo-SecureString -String $id -AsPlainText -Force

New-ADUser -Server blrv3 -Credential blrv\blrv -Name $fullName -AccountPassword $securepassword -DisplayName $fullName -Enabled $true -Organization Students

