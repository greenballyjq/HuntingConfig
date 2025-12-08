set WORKSPACE=..
set CLIENT_ASSETS=%WORKSPACE%\HuntingClient\Assets
set CONF_ROOT=.
set LUBAN_DLL=%CONF_ROOT%\Tools\Luban\Luban.dll
set DATA_OUTPATH=%CLIENT_ASSETS%\Resources\Bundle\Raw\Configs\bytes\
set CODE_OUTPATH=%CLIENT_ASSETS%\Scripts\GameConfig\gen\

dotnet %LUBAN_DLL% ^
    -t all ^
    -c cs-bin ^
    -d bin ^
    --conf %CONF_ROOT%\luban.conf ^
    -x outputCodeDir=%CODE_OUTPATH% ^
    -x outputDataDir=%DATA_OUTPATH%

pause