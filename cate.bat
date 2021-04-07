net stop wuauserv
net stop Wsearch
	SLEEP 5
	del "C:\Windows\SoftwareDistribution\*.*" /s /q
	del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb"
net start wuauserv
SLEEP 2
net start Wsearch
SLEEP 2
REM Make sure Windows update service actually started
for /F "tokens=3 delims=: " %%H in ('sc query wuauserv ^| findstr "STATE"') do (
  if /I "%%H" NEQ "RUNNING" (
  net start wuauserv
  )
)
REM Start Chrome part
@ECHO On
for /f %%a in ('dir c:\Users /b') do (
rd "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\Cache" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*.*" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\Application Cache\*.*" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\*history*.*" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\*History Provider Cache*.*" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\*cookies*.*" /s /q
del "c:\Users\%%a\AppData\Local\Google\Chrome\User Data\Default\Media Cache\f_*.*" /s /q
del "c:\Users\%%a\AppData\Roaming\Default\Cache\f_*.*" /s /q
del "c:\Users\%%a\AppData\Roaming\Default\Code Cache\*.* /s /q
REM Clear All Temps Start
del "c:\Users\%%a\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" /s /q
REM del "c:\Users\%%a\AppData\Local\Microsoft\Windows\INetCache\Low\Content.IE5\*.*" /s /q
REM del "c:\Users\%%a\AppData\Local\Microsoft\Windows\INetCache\Low\Flash\*.*" /s /q
REM del "c:\Users\%%a\AppData\Local\Microsoft\Windows\INetCache\Content.Outlook\*.*" /s /q
del "c:\Users\%%a\AppData\Local\Temp\*.*" /s /q
del "c:\Users\%%a\AppData\Local\Adobe\Flash Player\AssetCache"
REM Delete miscelaneous Windows things.
del "C:\Windows\System32\LogFiles\*.*" /s /q
del "C:\Windows\System32\wbem\Logs\*.*" /s /q
del "C:\Windows\Logs\CBS\*.log" /s /qsni
del "C:\Windows\Logs\DISM\*.log" /s /q
del "C:\Windows\INF\*.log" /s /q
del "C:\Windows\Prefetch\*.pf" /s /q
del "C:\Windows\Temp\*.*" /s /q
)
REM Recreate required folders under Not Logged In\Appdata\Local\Temp 
setlocal EnableDelayedExpansion

if not exist "c:\Users\%%a\AppData\Local\Temp\Low\" (
  mkdir ":\Users\%%a\AppData\Local\Temp\Low\"
  if "!errorlevel!" EQU "0" (
    echo Folder \Local\Temp\Low\  created successfully
  ) else (
    echo Error while creating folder
  )
) else (
  echo Folder already exists
)
if not exist "c:\Users\%%a\AppData\Local\Temp\1\" (
  mkdir ":\Users\%%a\AppData\Local\Temp\1\"
  if "!errorlevel!" EQU "0" (
    echo Folder \Local\Temp\1\  created successfully
  ) else (
    echo Error while creating folder
  )
) else (
  echo Folder already exists
)
exit /b 0
