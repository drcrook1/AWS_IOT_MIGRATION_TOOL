while ($TRUE)
{
    If (Test-Path -Path .\upgrade_device.txt) 
    {
       Stop-Process -Name python -Force -ErrorAction SilentlyContinue
       Start-Sleep -Seconds 2 #give python time to die before starting a new one
       start python azureClient.py
       #start ./go.bat
        exit
    }
    Else
    {
        Start-Sleep -Seconds 3
    }
}
