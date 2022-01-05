# nimdenter

Do you hate Nim because it's indentation-based? No worries! This tool will allow you to write Nim code with braces and automatically fill in the indentation for you!

## Usage

```
$ cat hello.nim
      proc main() = #{
  if true: #{
        for _ in 0..<8: #{
    echo "oh my gosh this is terribly indented";
#}
              #}
    #}

$ nimdenter < hello.nim
proc main() = #{
  if true: #{
    for _ in 0..<8: #{
      echo "oh my gosh this is terribly indented";
    #}
  #}
#}
```
