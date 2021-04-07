while ($TRUE)
{
    If (Test-Path -Path .\upgrade_device.txt) 
    {
       start python azureClient.py 
       #start ./go.bat
        exit
    }
    Else
    {
        Start-Sleep -Seconds 3
    }
}
