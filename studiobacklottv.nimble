# Package

version       = "0.1.0"
author        = "Thiago Navarro"
description   = "Studio Backlot TV video extractor"
license       = "MIT"
srcDir        = "src"
bin           = @["studiobacklottv"]

binDir = "build"

# Dependencies

requires "nim >= 1.6.4"
requires "cligen"
requires "util"
requires "https://github.com/thisago/brightcove"
