myssh() {
    user=$1
    ipad=$2
    re='^[0-9]+$'
    if [ $# -eq 2 ]
    then
        ssh -CY ${user}@${ipad}
    elif [ $# -eq 3 ]
    then
        if ! [[ $3 =~ $re ]]
        then
            ssh -CY ${user}@${ipad} "$3"
        else
            ssh -CY ${user}@${ipad} -L "$3":localhost:"$3"
        fi
    elif [ $# -ge 4 ]
    then
        if ! [[ $3 =~ $re ]]
        then
            ssh -CY ${user}@${ipad} "${@:3:99}"
        else
            if ! [[ $4 =~ $re ]]
            then
                ssh -CY ${user}@${ipad} -L "$3":localhost:"$3" "${@:4:99}"
            else
                ssh -CY ${user}@${ipad} -L "$3":localhost:"$4" "${@:5:99}"
            fi
        fi
    fi
}

scpssh() {
  user=$1
  ipad=$2
  loc=$(expDot $3)
  rem=$(expDot $4)
  if [ ${rem:0:24} = "/Users/anchal/nodususers" ]
  then
      dest="/users${rem:24}"
  elif [ ${rem:0:13} = "/Users/anchal" ]
  then
      dest="/home/${user}${rem:13}"
  else
      dest=$rem
  fi
  scp "${@:5:99}" "${loc}" "${user}"@"${ipad}":"${dest}"
}

sshscp() {
  user=$1
  ipad=$2
  rem=$(expDot $3)
  loc=$(expDot $4)
  if [ ${rem:0:24} = "/Users/anchal/nodususers" ]
  then
      src="/users/${rem:24}"
  elif [ ${rem:0:13} = "/Users/anchal" ]
  then
      src="/home/${user}${rem:13}"
  else
      src=$rem
  fi
  scp "${@:5:99}" "${user}"@"${ipad}":"${src}" "${loc}"
}

expDot() {
    destArg=$1
    if [ ${destArg:0:2} = "./" ]
    then
        cwd=`pwd`
        dest="${cwd}""${destArg:1}"
    else
        dest="${destArg:0}"
    fi
    echo "${dest}"
}

jn() {
    re='^[0-9]+$'
    if [ $# -eq 0 ]
    then
        # jupyter notebook
        tmuxmux jn "jupyter notebook"
    elif [ $# -ge 1 ]
    then
        if [[ $1 =~ ^-?[0-9]+$ ]]
        then
            tmuxmux jn$1 "jupyter notebook --port "$1" "${@:2:99}""
        else
            tmuxmux jn "jupyter notebook "${@:1:99}""
        fi
    fi
}

ltmkpvc() {
    tmuxmux ltmk "latexmk -f -pvc -pdf "$1
}

tmuxmux() {
  session=$1
  command=$2
  sessionMult='x'
  tmux has-session -t $session 2>/dev/null
  if [ $? != 0 ]
  then
    tmux new -d -s "$session"
    tmux send -t "$session" "$command" Enter
    echo 'Made new session: '"$session"
    echo 'With command: '"$command"
  else
    echo 'Session '"$session"' already exists'
    while ! [ $? != 0 ]
    do
      session+=$sessionMult
      tmux has-session -t $session 2>/dev/null
    done
    tmux new -d -s "$session"
    tmux send -t "$session" "$command" Enter
    echo 'Made new session: '"$session"
    echo 'With command: '"$command"
  fi
}

gitHookExec() {
  for hook in ./.git/hooks/*; do
    chmod u+x $hook
  done
}
