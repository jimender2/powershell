Import-Module ActiveDirectory


$Domain='blackriver.k12.oh.us'

$creatorusername = ""
$creatorpassword = ConvertTo-SecureString "" -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $creatorusername, $creatorpassword


$me=$env:username
$studentou="OU=Students,DC=blackriver,DC=k12,DC=oh,DC=us"
$teacherou="OU=Teachers,DC=blackriver,DC=k12,DC=oh,DC=us"
$staffou="OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
$continue = 'yes'

while ($continue -match 'yes'){
	$date=Get-date -Format "dd-MMM-yy"
	
	
	$studorstaf = Read-Host -Prompt 'Is this for a student or staff member?'
	$studentOrStaff = $studorstaf.toLower()
	
	if ($studentOrStaff -eq 'staff') {
		$firstName = Read-Host -Prompt 'Input the first name of the staff member'
		$lastName = Read-Host -Prompt 'Input the last name of the user'
		
		$fullName = $firstName + ' ' + $lastName
		$username = $firstName.Substring(0,1) + $lastName

		Write-Host $fullName
		$securepassword=ConvertTo-SecureString -String "pirate1" -AsPlainText -Force
		
		New-ADUser -Server blrv3 -Credential $cred -Name $username -GivenName $firstName -Surname $lastName -AccountPassword $securepassword -DisplayName $fullName -Enabled $true -Description $description -Organization $staffou --ChangePasswordAtLogon $true
		
		$UserDN  = (Get-ADUser -Server blrv3 -Credential $cred -Identity $fullName)
		
		$valid = 'no'
		while ($valid -eq 'no') {		
			$getwhatou = Read-Host -Prompt 'What do they do? (Board Office, Bus Driver, Cafeteria, Custodian, Office Staff)'
			$whatou = $getwhatou.ToLower()
			if ($whatou -match 'board office'){
				$staffou="OU=Board Office,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'bus driver') {
				$staffou="OU=Bus Drivers,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'cafeteria') {
				$staffou="OU=Cafeteria,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'custodian') {
				$staffou="OU=Custodians,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'office staff') {
				$staffou="OU=Office Staff,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} else {
				Write-Host 'ERROR: Enter one of the following Board Office, Bus Driver, Cafeteria, Custodian, Office Staff'
			}
		}
			
		
	} elseif ($studentOrStaff -eq 'student'){
		$firstName = Read-Host -Prompt 'Input the first name of the student'
		$lastName = Read-Host -Prompt 'Input the last name of the student'
		$id = Read-Host -Prompt 'Input the student id of the user'
		
				$fullName = $firstName + ' ' + $lastName
		$username = $firstName.Substring(0,1) + $lastName

		Write-Host $fullName
		$securepassword=ConvertTo-SecureString -String "pirate1" -AsPlainText -Force
		
		New-ADUser -Server blrv3 -Credential $cred -Name $username -GivenName $firstName -Surname $lastName -AccountPassword $securepassword -DisplayName $fullName -Enabled $true -Description $description -Organization $staffou --ChangePasswordAtLogon $true
		
		$UserDN  = (Get-ADUser -Server blrv3 -Credential $cred -Identity $fullName)
		
		$valid = 'no'
		while ($valid -eq 'no') {		
			$getwhatou = Read-Host -Prompt 'What do they do? (Board Office, Bus Driver, Cafeteria, Custodian, Office Staff)'
			$whatou = $getwhatou.ToLower()
			if ($whatou -match '2019'){
				$staffou="OU=Board Office,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match '201') {
				$staffou="OU=Bus Drivers,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'cafeteria') {
				$staffou="OU=Cafeteria,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'custodian') {
				$staffou="OU=Custodians,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} elseif ($whatou -match 'office staff') {
				$staffou="OU=Office Staff,OU=Staff,DC=blackriver,DC=k12,DC=oh,DC=us"
				Move-ADObject -Server blrv3 -Credential $cred -Identity $UserDN  -TargetPath $staffou
				$valid = 'yes'
			} else {
				Write-Host 'ERROR: Enter the graduation year'
			}
		}

	} else {
		Write-Host "ERROR: Please enter staff or student"
	}
	
	$continue = Read-Host -Prompt 'Do you want to continue'

}
