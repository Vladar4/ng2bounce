#!/bin/sh
cd src || exit
nim c --out:../ng2bounce --multimethods:on bounce.nim
cd ..

