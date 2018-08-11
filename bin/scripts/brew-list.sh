for pkg in `brew list -f1 | egrep -v '\.|\.\.'`
  do echo $pkg `brew info $pkg | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*$/\1/'`
done
