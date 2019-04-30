clone()
{
    echo ''
    echo -e '\033[01;32mRepositório\033[00;37m'
    read repositorio

    cd /c/wamp64/www && git clone git@bitbucket.org:trinityweb/$repositorio.git && cd $repositorio

    if [ -d /c/wamp64/www/$repositorio ]
    then
        echo ''
    else
        echo ''
        echo -e '\033[01;33mNão encontrado! Tente novamente:\033[00;37m'
        read repositorio

        cd /c/wamp64/www && git clone git@bitbucket.org:trinityweb/$repositorio.git && cd $repositorio
    fi

    if [ -d /c/wamp64/www/$repositorio ]
    then
        echo ''
    else
        echo ''
        echo -e '\033[01;31mRepositório não encontrado em https://bitbucket.org/trinityweb/\033[00;37m'
        exit
    fi

    wp core download --locale=pt_BR

    rm -rf /c/wamp64/www/$repositorio/wp-content/themes/twentyfifteen
    rm -rf /c/wamp64/www/$repositorio/wp-content/themes/twentyseventeen
    rm -rf /c/wamp64/www/$repositorio/wp-content/themes/twentysixteen
    rm -rf /c/wamp64/www/$repositorio/wp-content/themes/twentynineteen

    # # Configurando wordpress
    # wp core config --dbname=$repositorio --dbhost=localhost --dbuser=root --dbpass=trinity

    # # Bloco de criação do banco
    # echo ''
    # echo -e '\033[01;32mCriar Banco de Dados? (y/n)\033[00;37m':
    # read dbquest
    # if [ "$dbquest" = "y" ]
    # then
    #     echo ''
    #     mysql -e 'DROP DATABASE IF EXISTS $repositorio;'

    #     wp db create
    # fi
    echo ''
    echo -e '\033[01;32mO repositório foi clonado com sucesso!\033[00;37m'
}