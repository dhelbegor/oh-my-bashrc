# // Init personal configs
# Start virtualenv and docker containers
function Envs(){
    # used to create virtualenvs
    alias wait_env='echo wait creating the env/container...  && sleep 2 && clear'
    alias done_env='echo done! && sleep 2 && clear'
    alias env_create='virtualenv -p python3 .venv'
    alias env_activate='source .venv/bin/activate; PS1="\[\033[0;32m\]\${debian_chroot:+(\$debian_chroot)}(`basename \"$VIRTUAL_ENV\"`)\W\[\033[0;31m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[0;34m\]$\[\033[1;37m\] "'
    alias pip_upgrade='pip install --upgrade pip'
    alias create_env='wait_env && env_create && env_activate && pip_upgrade && done_env'

    #used to create docker containers
    alias create_dock='sudo docker build -f $(pwd)/docker/Dockerfile -t $project_name .'
    alias access_dock='sudo docker run -ti -v $(pwd)/:/root -p 8000:8000 $project_name bash'
}
Envs

# Start project django
function Projects(){
    alias wait_create='echo wait creating the project...'
    alias done_create='sleep 2 && clear && echo done good work!'
    function InitDjango(){
        # install django
        alias install_django='pip install django'
        
        # variable for boilerplate django
        alias django_boilerplate='django-admin.py startproject --template=https://github.com/dhelbegor/omelette/archive/master.zip --extension=md --name=Makefile --name=local_settings.py $project_name .'
        
        # variable to start the project
        alias create_django='wait_create && install_django && django_boilerplate && chmod +x manage.py && done_create'
    }
    InitDjango
}
Projects

# custom commands
function CustomCommand(){
    #init django projects with virtualenv
    function en(){
        if [ $1 ]; then
            project_name=$1
            mkdir $project_name
            cd $project_name && create_env && create_django
        fi
    }
    #init apps django
    function app(){
        if [ $1 ]; then
            app_name=$1
            cd apps && ../manage.py startapp $app_name && cd ..
        fi
    }
    #init docker containers doi = docker init
    function doi(){
        if [ $1 ]; then
            docker_name=$1
            docker build -f $(pwd)/docker/Dockerfile -t $docker_name .
        fi
    }
    #enter docker containers den = docker enter
    function den(){
        if [ $1 ]; then
            container_name=$1
            docker run -ti -v $(pwd)/:/root -p 8000:8000 $container_name bash
        fi
    }
    #remove all containers docker
    function rmc(){
        docker rm -f $(docker ps -a -q)
    }
    #open sudo subl projects
    function sub(){
        sudo subl .
    }
}
CustomCommand

# custom ls with -A
alias ls='ls -A'

# adding my personal config for python workspace
alias ww='cd workspace/python/works'
alias wp='cd workspace/python/projects'

#env auto activate
function env_auto_activate(){
    if [ -e ".venv" ]; then
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo activating virtualenv \"$_VENV_NAME\"...
            source .venv/bin/activate; PS1="\[\033[0;32m\]\${debian_chroot:+(\$debian_chroot)}(`basename \"$VIRTUAL_ENV\"`)\W\[\033[0;31m\][\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)]\[\033[0;34m\]:~$\[\033[1;37m\] "
            sleep 1
            clear
        fi
    fi
}
export PROMPT_COMMAND=env_auto_activate
# // End personal configs
