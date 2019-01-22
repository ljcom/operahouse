osql -S ".\sqlexpress" -E -d oph_core -Q "exec core.aws_loadBalance 0, @isdebug=0"
