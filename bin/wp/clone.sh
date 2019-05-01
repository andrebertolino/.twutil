clone()
{
    cd $www
    echo ''
    echo -e '\033[01;32mRepositório\033[00;37m'
    read repositorio

    if [ -d $www/$repositorio ]
    then
        echo -e '\033[01;33mEsse diretório já existe, verifique e tente novamente!\033[00;37m'
        exit
    else
        git clone git@bitbucket.org:trinityweb/$repositorio.git && cd $repositorio
    fi

    if [ -d $www/$repositorio ]
    then
        echo ''
    else
        echo ''
        echo -e '\033[01;33mEsse diretório já existe ou seu repositório não foi encontrado, verifique e tente novamente!\033[00;37m'
        echo ''
        echo -e '\033[01;32mRepositório\033[00;37m'
        read repositorio

        if [ -d $www/$repositorio ]
        then
            echo -e '\033[01;33mEsse diretório já existe, verifique e tente novamente!\033[00;37m'
            exit
        else
            git clone git@bitbucket.org:trinityweb/$repositorio.git && cd $repositorio
        fi
    fi

    if [ -d $www/$repositorio ]
    then
        echo ''
    else
        echo ''
        echo -e '\033[01;31mRepositório não encontrado em https://bitbucket.org/trinityweb/\033[00;37m'
        exit
    fi

    if [ "$PWD" == "$www/$repositorio" ]
    then
        wp core download --locale=pt_BR

        rm -rf $www/$repositorio/wp-content/themes/twentyfifteen
        rm -rf $www/$repositorio/wp-content/themes/twentyseventeen
        rm -rf $www/$repositorio/wp-content/themes/twentysixteen
        rm -rf $www/$repositorio/wp-content/themes/twentynineteen

        wp config create --dbname=$repositorio --dbhost="localhost" --dbuser="root"

        # Bloco de criação do banco
        echo ''
        echo -e '\033[01;32mCriar Banco de Dados? (y/n)\033[00;37m':
        read dbquest
        if [ "$dbquest" = "y" ]
        then
            echo ''
            mysql -u root -e 'DROP DATABASE IF EXISTS $repositorio;'

            wp db create
        fi
        echo ''
        echo -e '\033[01;32mO repositório foi clonado com sucesso!\033[00;37m'
    else
        echo 'Infelizmente não foi possível clonar seu repositório, verifique e tente novamente!'
        exit
    fi
}