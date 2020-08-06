ws1() {
    re='^[0-9]+$'
    if [ $# -eq 0 ]
    then
        ssh -CY controls@131.215.115.216
    elif [ $# -eq 1 ]
    then
        if ! [[ $1 =~ $re ]]
        then
            ssh -CY controls@131.215.115.216 "$1"
        else
            ssh -CY controls@131.215.115.216 -L "$1":localhost:"$1"
        fi
    elif [ $# -ge 2 ]
    then
        if ! [[ $1 =~ $re ]]
        then
            ssh -CY controls@131.215.115.216 "${@:1:99}"
        else
            if ! [[ $2 =~ $re ]]
            then
                ssh -CY controls@131.215.115.216 -L "$1":localhost:"$1" "${@:2:99}"
            else
                ssh -CY controls@131.215.115.216 -L "$1":localhost:"$2" "${@:3:99}"
            fi
        fi
    fi
}

nodus() {
    re='^[0-9]+$'
    if [ $# -eq 0 ]
    then
        ssh -CY controls@nodus.ligo.caltech.edu
    elif [ $# -eq 1 ]
    then
        if ! [[ $1 =~ $re ]]
        then
            ssh -CY controls@nodus.ligo.caltech.edu "$1"
        else
            ssh -CY controls@nodus.ligo.caltech.edu -L "$1":localhost:"$1"
        fi
    elif [ $# -ge 2 ]
    then
        if ! [[ $1 =~ $re ]]
        then
            ssh -CY controls@nodus.ligo.caltech.edu "${@:1:99}"
        else
            if ! [[ $2 =~ $re ]]
            then
                ssh -CY controls@nodus.ligo.caltech.edu -L "$1":localhost:"$1" "${@:2:99}"
            else
                ssh -CY controls@nodus.ligo.caltech.edu -L "$1":localhost:"$2" "${@:3:99}"
            fi
        fi
    fi
}

scpws1() {
    dest=$2
    if [ ${dest:0:13} = "/Users/anchal" ]
    then
        scp "${@:3:99}" "$1" controls@131.215.115.216:"/home/controls${dest:13}"
    else
        scp "${@:3:99}" "$1" controls@131.215.115.216:"$2"
    fi
}

ws1scp() {
    dest=$1
    if [ ${dest:0:13} = "/Users/anchal" ]
    then
        scp "${@:3:99}" controls@131.215.115.216:"/home/controls${dest:13}" "$2"
    else
        scp "${@:3:99}" controls@131.215.115.216:"$1" "$2"
    fi
}

scpnodus() {
    dest=$2
    if [ ${dest:0:13} = "/Users/anchal" ]
    then
        scp "${@:3:99}" "$1" controls@nodus.ligo.caltech.edu:"/home/controls${dest:13}"
    else
        scp "${@:3:99}" "$1" controls@nodus.ligo.caltech.edu:"$2"
    fi
}

nodusscp() {
    dest=$1
    if [ ${dest:0:13} = "/Users/anchal" ]
    then
        scp "${@:3:99}" controls@nodus.ligo.caltech.edu:"/home/controls${dest:13}" "$2"
    else
        scp "${@:3:99}" controls@nodus.ligo.caltech.edu:"$1" "$2"
    fi
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
    tmux new -d -s "$session" ""$command" ; read" \;
    echo 'Made new session: '"$session"
    echo 'With command: '"$command"
  else
    echo 'Session '"$session"' already exists'
    while ! [ $? != 0 ]
    do
      session+=$sessionMult
      tmux has-session -t $session 2>/dev/null
    done
    tmux new -d -s "$session" ""$command" ; read" \;
    echo 'Made new session: '"$session"
    echo 'With command: '"$command"
  fi
}

gitHookExec() {
  for hook in ./.git/hooks/*; do
    chmod u+x $hook
  done
}
