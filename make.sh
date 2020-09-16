#!/bin/bash

shc -f Eudic.sh && mv Eudic.sh.x Eudic && rm **.sh.x.c && mv Eudic Release
shc -f Eudic_cn.sh && mv Eudic_cn.sh.x Eudic_cn && rm **.sh.x.c && mv Eudic_cn Release
shc -f Activation.sh && mv Activation.sh.x Activation && rm **.sh.x.c && mv Activation Release

echo "Compile finished."