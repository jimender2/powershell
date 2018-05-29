param (
[Parameter(Mandatory,ValueFromPipelineByPropertyname)]
    [ValidateNotNullOrEmpty()]
     [string]$FirstName,
     [Parameter(Mandatory,ValueFromPipelineByPropertyname)]
     [ValidateNotNullOrEmpty()]
     [string]$LastName,
     [Parameter(Mandatory,ValueFromPipelineByPropertyname)]
     [ValidateNotNullOrEmpty()]
     [string]$MiddleInitial,
[Parameter(Mandatory,ValueFromPipelineByPropertyname)]
[ValidateNotNullOrEmpty()]
 [string]$Department,
    
    [Parameter(Mandatory,ValueFromPipelineByPropertyname)]
    [ValidateNotNullOrEmpty()]
    [string]$Title,
     [Parameter(ValueFromPipelineByPropertyname)]
     [ValidateNotNullOrEmpty()]
     [string]$Location = 'OU=Corporate Users',
    
     [Parameter()]
     [ValidateNotNullOrEmpty()]
     [string]$DefaultGroup = 'XYZCompany',
     [Parameter()]
     [ValidateNotNullOrEmpty()]
     [string]$DefaultPassword = 'p@$$w0rd12345', ## Don't do this...really
     [Parameter()]
     [ValidateScript({ Test-Path -Path $_ })]
     [string]$BaseHomeFolderPath = '\\MEMBERSRV1\Users'
)
Next, I'll need to figure out what the username will be based on our defined company standard and verify the home folder doesn't exist yet.
## Find the distinguished name of the domain the current computer is a part of.
$DomainDn = (Get-AdDomain).DistinguishedName
## Define the 'standard' username (first initial and last name)
$Username = "$($FirstName.SubString(0, 1))$LastName"
#region Check if an existing user already has the first initial/last name username taken
Write-Verbose -Message "Checking if [$($Username)] is available"
if (Get-ADUser -Filter "Name -eq '$Username'")
{
    Write-Warning -Message "The username [$($Username)] is not available. Checking alternate..."
    ## If so, check to see if the first initial/middle initial/last name is taken.
    $Username = "$($FirstName.SubString(0, 1))$MiddleInitial$LastName"
    if (Get-ADUser -Filter "Name -eq '$Username'")
    {
throw "No acceptable username schema could be created"
    }
    else
    {
Write-Verbose -Message "The alternate username [$($Username)] is available."
    }
}
else
{
    Write-Verbose -Message "The username [$($Username)] is available"
}
#endregion