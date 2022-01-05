import std/strutils

func nimdent*(program: string): string =
  var curIndent = 0
  var resultLines: seq[string]
  var lnNum = 1
  for ln in program.splitLines:
    let ln = ln.unindent
    if ln == "#}":
      curIndent.dec
    if curIndent < 0:
      raise newException(ValueError, "Unexpected \"#}\" on line $1" % [$lnNum])
    resultLines.add:
      if ln == "":
        ""
      else:
        ln.indent(2 * curIndent)
    if ln.endsWith("#{"):
      curIndent.inc
    lnNum.inc
  if curIndent > 0:
    raise newException(ValueError, "Unclosed \"#{\" upon reaching end-of-file")
  resultLines.join("\n")

when isMainModule:
  import cligen

  proc nimdenter() =
    try:
      stdout.writeLine stdin.readAll.nimdent
    except ValueError:
      stderr.writeLine "Error: $1" % [getCurrentException().msg]

  dispatch nimdenter
