Param(
	[string]$ADMHost = "https://adm.domain.local"
)
$RunningPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$BasePath = (Get-Item $RunningPath).parent.parent.FullName
Import-Module ($RunningPath + '\ADM.psm1') -Force
$Cred = Get-Credential
$ADMSession = Connect-ADM $ADMHost $Cred
$ADCS = Invoke-ADMNitro -ADMSession $ADMSession -OperationMethod GET -ResourceType ns
$RunningConfigs = @()
foreach ($ADC in $ADCs.ns)
{
	$RunningConfigs += (Invoke-ADMNitro -ADMSession $ADMSession -OperationMethod GET -ResourceType nsrunningconfig -ADCHost $ADC.ip_address).nsrunningconfig
}