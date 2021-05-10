install()
{
    echo ''
    echo -e '\033[01;32mProjeto\033[00;37m'
    read projeto

    if [ -d $www/$projeto ]
    then
        echo -e '\033[01;33mJá existe um projeto com esse nome, verifique e tente novamente!\033[00;37m'
        exit
    else
        cd $www && mkdir $projeto && cd $projeto 

        wp core download --locale=pt_BR

        # Configurando wordpress
        wp core config --dbname=$projeto --dbhost=localhost --dbuser=root --dbpass= --dbprefix=tw3_

        # Bloco de criação do banco
        wp db create
        wp core install --url=http://localhost/$projeto --title=$projeto --admin_user=admin --admin_password=root --admin_email=admin@agenciatw.com.br
    fi
}