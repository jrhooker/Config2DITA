#! /bin/sh

PATHTOPROJECT=$1 #/Source
OUTPUTPATH=$2 #/Out
FILENAME=$3 #pnr_cfg_file.xml
DITAMAPNAME=$4 #pnr_cfg_file.ditamap

cd ../

WORKINGDIR=$PWD

echo WORKINGDIR = $WORKINGDIR

cd $WORKINGDIR/batchfiles

rm -fr $WORKINGDIR/out/

mkdir $WORKINGDIR/out/

rm -fr $WORKINGDIR/in/

mkdir $WORKINGDIR/in/

java -cp $WORKINGDIR/depend/tools/saxon9/saxon9he.jar;$WORKINGDIR\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:$WORKINGDIR$OUTPUTPATH\$DITAMAPNAME ^
-s:$WORKINGDIR\$PATHTOPROJECT\$FILENAME ^
-xsl:$WORKINGDIR\depend\custom\generate_ditamap.xsl ^
OUTPUT-DIR="$WORKINGDIR$OUTPUTPATH/" FILENAME="$DITAMAPNAME"

java -cp $WORKINGDIR/depend/tools/saxon9/saxon9he.jar;$WORKINGDIR\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:$WORKINGDIR$OUTPUTPATH\temp.xml ^
-s:$WORKINGDIR$\$PATHTOPROJECT\$FILENAME ^
-xsl:$WORKINGDIR\depend\custom\generate_topics.xsl ^
OUTPUT-DIR="$WORKINGDIR$OUTPUTPATH/" FILENAME="$DITAMAPNAME"

cd $WORKINGDIR/batchfiles