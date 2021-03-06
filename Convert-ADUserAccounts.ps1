﻿<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Convert-ADUserAccounts
{
    [CmdletBinding()]
    Param
    (
        $Path = 'OU=Year R CAC Computer Science 2012 Intake,OU=Students,OU=Users,OU=BHS,DC=BHS,DC=INTERNAL'
        ,$ProfilePath = "\\bhs-fs01\profiles$\Students\2015 Students"
        ,$HomeDirectory = "\\bhs-fs01\home$\Students\Year R Computing Controlled Assessment\%USERNAME%"
        ,$HomeDrive = "N"
        ,[parameter(ValueFromPipelineByPropertyName=$true)]
        $Surname
        ,[parameter(ValueFromPipelineByPropertyName=$true)]
        $Givenname
        ,[parameter(ValueFromPipelineByPropertyName=$true)]
        $SamAccountName
        ,[parameter(ValueFromPipelineByPropertyName=$true)]
        $Description = "2015 Computing CA"
    )

    Begin
    {
    }
    Process
    {
        $Intake = "2015 Students";
        $ShortIntake = "15"
        $Password = Get-Random -Minimum 1000 -Maximum 9999
        if(-not $SamAccountName){
            $SamAccountName = $ShortIntake + $Surname + $Givenname[0]
        }

        Write-Verbose $password
        

        $user = @{
            Path = $path;
            SamAccountName = $SamAccountName;
            UserPrincipalName = $SamAccountName + '@BHS.INTERNAL'
            name = $SamAccountName;
            GivenName = $Givenname;
            Surname = $Surname;
            DisplayName = $SamAccountName;
            #EmailAddress = $SamAccountName + "@birkdalehigh.co.uk";
            Description = $Description;
            ProfilePath = $ProfilePath;
            HomeDirectory = $HomeDirectory;
            HomeDrive = $HomeDrive;
            accountPassword = ConvertTo-SecureString ('pass' + $Password) -AsPlainText -Force;
            ChangePasswordAtLogon = $true;
            enabled = $true;
        }

        New-Object -TypeName psobject -Property $user
        
        # set password with: ConvertTo-SecureString $Password -AsPlainText -Force;
    }
    End
    {
    #Import-Csv '.\y7 import.csv' | Convert-ADUserAccounts | ConvertTo-Csv | out-file 'adimport.csv' -Force
    #import-csv .\adimport.csv | select -ExcludeProperty accountpassword -Property @{n='accountpassword';e={ConvertTo-SecureString $_.accountpassword -AsPlainText -Force}},* | New-ADUser
    }
}