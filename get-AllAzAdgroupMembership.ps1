
$result = @()

Get-AzADGroup | Select-Object -First 2 | ForEach-Object{
    $GRPName = $_.DisplayName
    $GRPid = $_.Id
    $GRPDesc = $_.Description
    Get-AzADGroupMember -GroupObjectId $_.Id | ForEach-Object {
        $UserLine = [PSCustomObject]@{
            Group_Name = $GRPName
            Group_ID = $GRPid
            Group_Desc = $GRPDesc
            Member_Type = $_.Type
            Member_Displayname = $_.DisplayName
            Member_ID = $_.Id

        }
        $result += $UserLine
    }


