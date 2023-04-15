#!/bin/bash

WORLDOLD=/Users/zhafen/Downloads/world
WORLDNEW=/Users/zhafen/Documents/curseforge/minecraft/Instances/MiZaTaCraft/saves/world
DIRS_TO_OVERWRITE=( data poi region )
FILES_TO_OVERWRITE=( level.dat level.dat_old )

WORLDMERGEDDIR=$(dirname $WORLDOLD)/merged_minecraft_world
WORLDMERGED=$WORLDMERGEDDIR/world
echo Merged world will be saved at $WORLDMERGEDDIR
if [ -d $WORLDMERGEDDIR ] ; then
    echo Pre-existing merged world. Removing.
    rm -r $WORLDMERGEDDIR
fi
mkdir $WORLDMERGEDDIR

echo Copying $WORLDOLD as the base
echo Overwriting with $WORLDNEW
cp -r $WORLDOLD $WORLDMERGED

echo Replacing directories...
for dir in ${DIRS_TO_OVERWRITE[@]}
do
    echo "    " $WORLDMERGED/$dir
    rm -r $WORLDMERGED/$dir
    cp -r $WORLDNEW/$dir $WORLDMERGED/
done

echo Replacing files...
for file in ${FILES_TO_OVERWRITE[@]}
do
    echo "    " $WORLDMERGED/$file
    rm $WORLDMERGED/$file
    cp $WORLDNEW/$file $WORLDMERGED/
done

echo Compressing...
zip -r $WORLDMERGED $WORLDMERGED

echo Finished!
echo Final product at $WORLDMERGEDDIR/world.zip