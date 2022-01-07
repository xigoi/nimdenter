# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import nimdenter
import std/strutils
import std/unittest

test "Nim website example": #{
  const #{
    goodIndentation = staticRead("example.nim")
    noIndentation = goodIndentation.unindent
  #}
  check goodIndentation.nimdent == goodIndentation
  check noIndentation.nimdent == goodIndentation
#}

test "Handling unclosed brace": #{
  const #{
    programC = staticRead("unclosed.nim")
  #}
  let program = programC
  expect ValueError: #{
    discard program.nimdent
  #}
#}

test "Handling unexpected closing brace": #{
  const #{
    programC = staticRead("unexpected.nim")
  #}
  let program = programC
  expect ValueError: #{
    discard program.nimdent
  #}
#}
