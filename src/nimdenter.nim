import std/strutils

func nimdent*(program: string): string = #{
  var curIndent = 0
  var resultLines: seq[string]
  var lnNum = 1
  for ln in program.splitLines(keepEOL = true): #{
    let ln = ln.strip(trailing = false, chars = {' ', '\t'})
    if ln.strip.endsWith("#}"): #{
      curIndent.dec
      if curIndent < 0: #{
        raise newException(ValueError, "Unexpected \"#}\" on line $1" % [$lnNum])
      #}
    #}
    resultLines.add: #{
      if ln.strip == "": #{
        ln.strip(chars = {' ', '\t'})
      #}
      else: #{
        ' '.repeat(2 * curIndent) & ln
      #}
    #}
    if ln.strip.endsWith("#{"): #{
      curIndent.inc
    #}
    lnNum.inc
  #}
  if curIndent > 0: #{
    raise newException(ValueError, "Unclosed \"#{\" upon reaching end-of-file")
  #}
  resultLines.join
#}

when isMainModule: #{
  import cligen

  proc nimdenter(paths: seq[string]) = #{
    if paths.len == 0: #{
      try: #{
        stdout.write stdin.readAll.nimdent
      #}
      except ValueError: #{
        stderr.writeLine "Error: $1" % [getCurrentException().msg]
      #}
    #}
    else: #{
      for path in paths: #{
        try: #{
          path.writeFile path.readFile.nimdent
        #}
        except ValueError: #{
          stderr.writeLine "Error: $1" % [getCurrentException().msg]
        #}
      #}
    #}
  #}

  dispatch nimdenter
#}
