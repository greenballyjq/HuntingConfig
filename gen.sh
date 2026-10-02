#!/bin/bash

CONF_ROOT=.
LUBAN_DLL=$CONF_ROOT/Tools/Luban/Luban.dll

dotnet $LUBAN_DLL \
    -t all \
    -d bin \
    -c cs-bin \
    --conf $CONF_ROOT/luban.conf \
    -x outputDataDir=output/bytes \
    -x outputCodeDir=output/code
