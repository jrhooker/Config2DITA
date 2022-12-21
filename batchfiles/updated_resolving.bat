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

java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%%OUTPUTPATH%\%DITAMAPNAME% ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_ditamap.xsl ^
OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%DITAMAPNAME%"

java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%%OUTPUTPATH%\temp.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_topics.xsl ^
OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%DITAMAPNAME%"

cd %WORKINGDIR%\batchfiles