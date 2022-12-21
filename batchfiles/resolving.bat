set PATHTOPROJECT=\Source
set OUTPUTPATH=\Out
set FILENAME=pnr_cfg_file2.xml
set DITAMAPNAME=pnr_cfg_file.ditamap

cd ..\

set WORKINGDIR=%CD%

cd %WORKINGDIR%\batchfiles

rd /s /q %WORKINGDIR%\out\

mkdir %WORKINGDIR%\out\

rd /s /q %WORKINGDIR%\in\

mkdir %WORKINGDIR%\in\

#xcopy %WORKINGDIR%\%PATHTOPROJECT% %WORKINGDIR%\out\ /S /Y


java -jar %WORKINGDIR%\depend\tools\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%%OUTPUTPATH%\%DITAMAPNAME% %WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% %WORKINGDIR%\depend\custom\generate_ditamap.xsl OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%DITAMAPNAME%"


java -jar %WORKINGDIR%\depend\tools\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%%OUTPUTPATH%\temp.xml %WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% %WORKINGDIR%\depend\custom\generate_topics.xsl OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%DITAMAPNAME%"


cd %WORKINGDIR%\batchfiles