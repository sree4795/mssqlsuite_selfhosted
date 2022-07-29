Write-Output "Installing SQL Engine"

      Write-Output "windows detected, downloading sql server 2019"
      # docker takes 16 minutes, this takes 5 minutes
      if (-not (Test-Path C:\tempsql1)) {
            mkdir c:\tempsql1 -Force
             (New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-DEV-x64-ENU.exe','C:\tempsql1\setup.exe')
        }
        Write-Output "Unpacking SQL Server 2019 Express`r`n"
        C:\tempsql1\setup.exe /x:"c:\tempsql1\setup" /u | Out-Null     
        C:\tempsql1\setup\setup.exe /QUIETSIMPLE /ACTION=install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT SERVICE\MSSQLSERVER' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLCOLLATION=$Collation /USESQLRECOMMENDEDMEMORYLIMITS       
      
      
      
      
      
      
      
      
      
      
      
      
      
      
     
