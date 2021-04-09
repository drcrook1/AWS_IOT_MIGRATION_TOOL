$userprofiledir = $env.USERPROFILE
Start-Process -FilePath python3 -ArgumentList "awsClient.py --thing-name JBThing1 --client-id JBThing1 --endpoint a1fxcu0l5seyuv-ats.iot.us-west-2.amazonaws.com --root-ca Amazon-root-CA-1.pem --cert device.pem.crt --key private.pem.key"

while ($TRUE)
{
    If (Test-Path -Path .\upgrade_device.txt) 
    {
       Stop-Process -Name python3 -Force -ErrorAction SilentlyContinue
       Start-Sleep -Seconds 2 #give python time to die before starting a new one
       
       $connectionstring = Get-Content -Path '.\deviceconnectionstring.txt'
       $args = "azureClient.py --connectionstring "+ $connectionstring
       Start-Process -FilePath python3 -ArgumentList $args
       #start ./go.bat
       while ($TRUE)
       {
        Start-Sleep -Seconds 60
       }
       
    }
    Else
    {
        Start-Sleep -Seconds 3
    }
}
