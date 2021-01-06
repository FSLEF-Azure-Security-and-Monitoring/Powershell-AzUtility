#requires -version 3
<#
.SYNOPSIS
  This script list all the LogAnalytics Worspace information across several subscriptions
.DESCRIPTION

.PARAMETER Subscriptions
    Array of subscriptions ID where to gather informations

.NOTES
  Version:        0.1
  Author:         Francois LEFEBVRE
  Creation Date:  November 2nd 2020
  Purpose/Change: Initial script development

.EXAMPLE
  $AzSubs = Get-AzSubscription -TenantId <Tenant ID>
  $AzSubs | Get-LogAnalyticsWorkspace
#>

param(
    [Parameter(ValueFromPipeline = $true)]
    $Subscriptions=Get-AzSubscription -TenantId 7339ee4a-beed-4dcc-ba34-a2fe756861b6
)

$colLAW = @()

Foreach ($Subscription in $Subscriptions){
    Set-AzContext -TenantId $Subscription.TenantID -Subscription $Subscription.Id | Out-Null
    Get-AzOperationalInsightsWorkspace | ForEach-Object{
        $LAWObject = New-Object psobject
           $LAWObject | Add-Member -type NoteProperty -Name Name -Value $_.name
           $LAWObject | Add-Member -type NoteProperty -Name Location -Value $_.Location
           $LAWObject | Add-Member -type NoteProperty -Name ProvisioningState -Value $_.ProvisioningState
           $LAWObject | Add-Member -type NoteProperty -Name retentionInDays -Value $_.retentionInDays
           $LAWObject | Add-Member -type NoteProperty -Name Sku -Value $_.Sku
           $colLAW += $LAWObject}
    }

$colLAW | Format-Table

