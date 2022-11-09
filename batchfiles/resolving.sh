#! /bin/sh


PATHTOPROJECT=/Source
OUTPUTPATH=/Out
FILENAME=pnr_cfg_file.xml
DITAMAPNAME=pnr_cfg_file.ditamap

cd ../

WORKINGDIR=$PWD

echo WORKINGDIR = $WORKINGDIR

cd $WORKINGDIR/batchfiles

rm -fr $WORKINGDIR/out/

mkdir $WORKINGDIR/out/

rm -fr $WORKINGDIR/in/

mkdir $WORKINGDIR/in/

java -jar $WORKINGDIR/depend/tools/saxonhe9-3-0-4j/saxon9he.jar   -o:$WORKINGDIR$OUTPUTPATH/$DITAMAPNAME $WORKINGDIR/$PATHTOPROJECT/$FILENAME $WORKINGDIR/depend/custom/generate_ditamap.xsl OUTPUT-DIR="$WORKINGDIR$OUTPUTPATH/" FILENAME="$DITAMAPNAME"


java -jar $WORKINGDIR/depend/tools/saxonhe9-3-0-4j/saxon9he.jar   -o:$WORKINGDIR$OUTPUTPATH/temp.xml $WORKINGDIR/$PATHTOPROJECT/$FILENAME $WORKINGDIR/depend/custom/generate_topics.xsl OUTPUT-DIR="$WORKINGDIR$OUTPUTPATH/" FILENAME="$DITAMAPNAME"


cd $WORKINGDIR/batchfiles