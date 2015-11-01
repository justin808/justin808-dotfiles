# Generic Utilities

funcs() {
    # The functions are stored in an associative array functions, so to get only the
    # funtion names (k flag for keys) in alphabetical order (o flag for ordering)

    # then use which <func_name> to see the definition of that function
    print -l ${(ok)functions}
}


tz_pst() {
  tz=`sudo systemsetup -gettimezone`
  original_tz=`echo $tz| sed 's/Time Zone: //'`
  pst=America/Los_Angeles
  if [ "$original_tz" != "$pst" ]; then
    echo "You may be asked for your password to change the timezone."
    sudo systemsetup -settimezone $pst
  fi
}

tz_hst() {
  tz=`sudo systemsetup -gettimezone`
  original_tz=`echo $tz| sed 's/Time Zone: //'`
  hst="Pacific/Honolulu"
  if [ "$original_tz" != "$hst" ]; then
    echo "You may be asked for your password to change the timezone."
    sudo systemsetup -settimezone $hst
  fi
}

using_port() {
  #lsof -i:${1}
  ps -p $(lsof -i:$1 -Fp | cut -c 2-)
}

# most_used for zsh not working
# most_used() {
#   history | awk '{a[$4]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20
# }

log()
{
 echo "[$(date)] $*"
}

echoRun() {
  START=$(date +%s)
  log "> $1"
  eval time $1
  END=$(date +%s)
  DIFF=$(( $END - $START ))
  log "It took $DIFF seconds"
}

sanitize() {
  echo $1 | tr ":  /."  "-" | tr -d ",'\""
}


# history grep tail
hgt() {
  fc -l 1 | grep -i --color=auto $1 | tail -n 40
}


marked() {
  if [[ -f $1 ]]; then
    open -a marked.app $1
    echo found file $1
  else
    open -a marked.app
    echo no file existing $1
  fi
}

ls_symlinks() {
  find . -maxdepth 1 -type l | xargs ls -al
}

setup-docker() {
  # Setup docker vars
  eval "$(docker-machine env default)"
}
