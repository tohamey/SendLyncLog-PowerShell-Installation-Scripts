<#

###########################################
# Skype For Business installation script  #
###########################################

**Make sure to run this script as an administrator

Simple PowerShell script to create the required registery keys 
for the SkypeFB / Lync 2013 Automatic SIP-Stack log file creator 

##############
# How To use #
##############
1- run using powershell console opened as an Administrator
2- use the -NetworkPath to point to the exe file
3- use the -AdminEmail to give the IT-help desk or Skype for business Administrator email address
4- use the -SmtpServer to give yoru organization SMTP server

#>
param(
	[parameter(Mandatory=$true)]
	[string]$NetworkPath,
	[string]$AdminEmail,
	[String]$SmtpServer
)
#some variables
$RegistryPath = "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\"
$KeyExist = test-path $RegistryPath
if($KeyExist -eq $false)
	{
		New-Item -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\" -Name SessionManager -Verbose
		New-Item -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\" -Name Apps -Verbose
		New-Item -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\" -Name "{7ABD864F-D44A-466B-81CA-C4EC9FE0513D}" -Verbose
		New-ItemProperty -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\{7ABD864F-D44A-466B-81CA-C4EC9FE0513D}" -Name "Path" -Value "$NetworkPath $AdminEmail $SmtpServer" -Verbose
		New-ItemProperty -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\{7ABD864F-D44A-466B-81CA-C4EC9FE0513D}" -Name "Name" -Value "Send Log File" -Verbose
		New-ItemProperty -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\{7ABD864F-D44A-466B-81CA-C4EC9FE0513D}" -Name "SessionType" -Value 0 -PropertyType "DWord" -Verbose
		New-ItemProperty -Path "HKLM:\Software\Microsoft\Office\16.0\Lync\SessionManager\Apps\{7ABD864F-D44A-466B-81CA-C4EC9FE0513D}" -Name "ExtensibleMenu" -Value "MainWindowActions;MainWindowRightClick" -Verbose

	}
	else{
		Write-Host "Already Installed"
	
	}
