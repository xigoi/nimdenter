# Package

version       = "2022.1.5"
author        = "Adam Blažek"
description   = "A tool for people who don't like Nim's indentation-based syntax"
license       = "GPL-3.0-or-later"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nimdenter"]


# Dependencies

requires "nim >= 1.6.0"
requires "cligen"
