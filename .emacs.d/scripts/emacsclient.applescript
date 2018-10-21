on emacsclient(input)
  set theCommand to "/usr/local/bin/emacsclient -n -c -F \"((name . \\\"capture\\\")(height . 10) (width . 100) (left . 100) (top . 100))\"" & " " & "\"" & input & "\""
  do shell script theCommand
  do shell script "open -a Emacs"
end emacsclient

on open location input
  emacsclient(input)
end open location

on open inputs
  repeat with raw_input in inputs
    set input to POSIX path of raw_input
    emacsclient(input)
  end repeat
end open

on run
  do shell script emacsclient("")
end run
