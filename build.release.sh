#!/bin/sh
cd src
nim c --out:../ng2bounce -d:release --opt:speed --multimethods:on bounce.nim
cd ..

