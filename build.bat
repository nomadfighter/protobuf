@echo off

set vc_ver=%1

set build_dir=".\build_win\"
if not exist "%build_dir%" (
    mkdir %build_dir%
)

cd %build_dir%

if defined VS140COMNTOOLS (
    set VSTOOLS="%VS140COMNTOOLS%"
    set VC_VER=140
)

set VSTOOLS=%VSTOOLS:"=%"
set "VSTOOLS=%VSTOOLS:\=/%"

set VSVARS="%VSTOOLS%vsvars32.bat"

if not defined VSVARS (
    echo Can't find vs2015 installed!
    goto ERROR
)
call %VSVARS%
set GENERATOR="Visual Studio 14 2015"
cmake ..\cmake -Dprotobuf_BUILD_TESTS=OFF -G %GENERATOR%
msbuild protobuf.sln /nologo /m /v:m /p:Configuration=Debug
msbuild protobuf.sln /nologo /m /v:m /p:Configuration=Release

cd ..
if not exist .\lib (
    mkdir lib
)
xcopy %build_dir%Debug\*.lib .\lib\Debug\ /Y /Q
xcopy %build_dir%Release\*.lib .\lib\Release\ /Y /Q

if not exist .\bin (
    mkdir bin
)
xcopy %build_dir%Release\*.exe .\bin\ /Y /Q

exit

:error
echo unsupport compiler...