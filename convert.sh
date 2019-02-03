#!/bin/sh

PNG_FILE=$(echo $1 | cut -d "." -f 1).png

echo $PNG_FILE

sips -s format png $1 --out $PNG_FILE

rm $1
