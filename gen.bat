set CONF_ROOT=.
set LUBAN_DLL=%CONF_ROOT%\Tools\Luban\Luban.dll

dotnet %LUBAN_DLL% ^
    -t all ^
    -c cs-bin ^
    -d bin ^
    --conf %CONF_ROOT%\luban.conf ^
    -x outputCodeDir=output\code ^
    -x outputDataDir=output\bytes

pause
