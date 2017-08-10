function docker-enter() {
    if [ $# -eq 0 ]
    then
        echo "ERROR: Container missing"
        return
    fi
    docker exec -it $1 bash
}

function docker-ips(){
    if [ $# -eq 0 ]
    then
        CONTAINERS=$(docker ps | grep -o "cheetah[^ ]*$")
    else
        CONTAINERS="$1"
    fi
    for CONTAINER in $CONTAINERS
    do
        CONT_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER)
        printf "%-30s %-15s\n" $CONTAINER $CONT_IP
        # echo -e "$CONTAINER\t\t$CONT_IP"
    done
}


function _container_complete(){
    CONTAINERS=$(docker ps --format "{{ .Names }}" | tr '\n' ' ')
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    COMPREPLY=( $(compgen -W "${CONTAINERS}" -- ${cur_word}) )
    return 0
}

complete -F _container_complete docker-enter docker-ips
