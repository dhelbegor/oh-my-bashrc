# // Init personal configs
# Start virtualenvs
function Envs(){
    # used to create virtualenvs
    alias wait_env='echo wait creating the env...  && sleep 2 && clear'
    alias done_env='echo done! && sleep 2 && clear'
    alias env_create='virtualenv -p python3 .venv'
    alias pip_upgrade='pip install --upgrade pip'
    alias create_env='wait_env && env_create && pip_upgrade && done_env'
}
Envs

# Start personal projects
function Projects(){
    alias wait_create='echo wait creating the project...'
    alias done_create='sleep 2 && clear && echo done good work!'
    function InitDjango(){
        # install django
        alias install_django='pip install django'
        
        # variable for  my personal boilerplate django
        alias django_boilerplate='django-admin.py startproject --template=https://github.com/dhelbegor/omelette/archive/master.zip --extension=md --name=Makefile --name=local_settings.py $project_name .'
        
        # comand line projects
        alias create_django='wait_create && install_django && django_boilerplate && chmod +x manage.py && done_create'
    }
    InitDjango
}
Projects

### creating django projects with envs
# environment
function en(){
if [ $1 ]; then
    project_name=$1
    mkdir $project_name
    cd $project_name
    create_env && create_django
fi
}

# alias for personal ls
alias ls='ls -A'

# adding my personal config for python workspace
alias ww='cd workspace/python/works'
alias wp='cd workspace/python/projects'

function env_auto_activate(){
    if [ -e ".venv" ]; then
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo activating virtualenv \"$_VENV_NAME\"...
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate; PS1="(`basename \"$VIRTUAL_ENV\"`):/\W$ "
            sleep 1
            clear
        fi
    fi
}
export PROMPT_COMMAND=env_auto_activate

# // End personal configs
