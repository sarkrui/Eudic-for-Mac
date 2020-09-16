#!/bin/bash

# Create redistributable encrypted shell scripts
shc -e 31/12/9999 -r -f Eudic.sh -o Release/Eudic && rm **.sh.x.c
shc -e 31/12/9999 -r -f Eudic_cn.sh -o Release/Eudic_cn && rm **.sh.x.c 
shc -e 31/12/9999 -r -f Activation.sh -o Release/Activation && rm **.sh.x.c 

echo "Compile finished."