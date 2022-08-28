# Package

version       = "0.2.0"
author        = "Thiago Navarro"
description   = "Studio Backlot TV video downloader"
license       = "MIT"
srcDir        = "src"
bin           = @["studiobacklottv"]

binDir = "build"

# Dependencies

requires "nim >= 1.6.4"
requires "cligen"
requires "util"
requires "https://github.com/thisago/brightcove"
