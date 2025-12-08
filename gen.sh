#!/bin/bash

WORKSPACE=..
CLIENT_ASSETS=$WORKSPACE/HuntingClient/Assets
CONF_ROOT=.
LUBAN_DLL=$CONF_ROOT/Tools/Luban/Luban.dll
DATA_OUTPATH=$CLIENT_ASSETS/Bundle/Raw/Configs/bytes/
CODE_OUTPATH=$CLIENT_ASSETS/Scripts/GameConfig/gen/

dotnet $LUBAN_DLL \
    -t all \
    -d bin \
    -c cs-bin \
    --conf $CONF_ROOT/luban.conf \
    -x outputDataDir=DATA_OUTPATH \
    -x outputCodeDir=CODE_OUTPATH