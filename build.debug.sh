#!/bin/sh
cd src
nim c --out:../ng2bounce --multimethods:on bounce.nim
cd ..

