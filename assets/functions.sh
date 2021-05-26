function movie-split()
{
    if [[ -z "${3}" ]]; then
        echo "Usage: movie-split {file path: example.mp4} {start: 00:00:06} {end: 01:01:01}"
        return 1
    fi

    FILE_PATH="${1}"
    START_HH_MM_SS="${2}"

    START_IN_SEC=$(echo "${2}" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    END_IN_SEC=$(echo "${3}" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    DURATION_IN_SEC=$(expr $END_IN_SEC - $START_IN_SEC)

    # ffmpeg -i "${FILE_PATH}" -ss "${START_HH_MM_SS}" -c copy -t "${DURATION_IN_SEC}" "splitted_${FILE_PATH}"
    ffmpeg -i "${FILE_PATH}" -ss "${START_HH_MM_SS}" -c:v libx264 -c:a aac -t "${DURATION_IN_SEC}" "splitted_${FILE_PATH}"

    echo "Your new file: splitted__${FILE_PATH}"
} 

function lsda(){
    echo -e '\n=======================================================================================================================================\n'
    docker image ls
    echo -e '\n---------------------------------------------------------------------------------------------------------------------------------------\n'
    docker ps -a
    echo -e '\n---------------------------------------------------------------------------------------------------------------------------------------\n'
    docker network ls
    echo -e '\n---------------------------------------------------------------------------------------------------------------------------------------\n'
    docker volume ls
    echo -e '\n=======================================================================================================================================\n'
    echo
}

function rmalld(){
    docker rm -f $(docker ps -aq)
    docker network rm $(docker network ls)
    docker volume prune --force
    clear
    lsda
}
