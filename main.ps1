   Write-Output "Installing SQL Engine"
   
      Write-Output "windows detected, downloading sql server 2019"
      # docker takes 16 minutes, this takes 5 minutes
      if (-not (Test-Path C:\temp)) {
         mkdir c:\tempsql1 -Force
      }
      Push-Location C:\temp
      $ProgressPreference = "SilentlyContinue"
      Invoke-WebRequest -Uri https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-DEV-x64-ENU.exe -OutFile C:\tempsql1\sqlsetup.exe
      Invoke-WebRequest -Uri https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-DEV-x64-ENU.box -OutFile C:\tempsql1\sqlsetup.box
      Start-Process -Wait -FilePath C:\tempsql1\sqlsetup.exe -ArgumentList /qs, /x:"c:\tempsql1\setup"
      .\c:\tempsql1setup\setup.exe /q /ACTION=Install /INSTANCENAME=MSSQLSERVER /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT SERVICE\MSSQLSERVER' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLCOLLATION=$Collation /USESQLRECOMMENDEDMEMORYLIMITS
      Set-ItemProperty -path 'HKLM:\Software\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLSERVER\' -Name LoginMode -Value 2 
     # Restart-Service MSSQLSERVER
      sqlcmd -S localhost -q "ALTER LOGIN [sa] WITH PASSWORD=N'$SaPassword'"
      sqlcmd -S localhost -q "ALTER LOGIN [sa] ENABLE"
      Pop-Location
      
      Write-Output "sql server 2019 installed at localhost and accessible with both windows and sql auth"
   


