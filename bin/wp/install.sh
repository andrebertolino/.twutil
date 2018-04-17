install()
{
    echo ''
    echo -e '\033[01;32mProjeto\033[00;37m'
    read projeto

    cd ~/www && mkdir $projeto && cd $projeto  

    wp core download --locale=pt_BR

    # Bloco de configuração
    echo ''
    echo -e '\033[01;32mDB name\033[00;37m':
    read dbname
    echo ''
    echo -e '\033[01;32mDB Host\033[00;37m':
    read dbhost
    echo ''
    echo -e '\033[01;32mDB user\033[00;37m':
    read dbuser
    echo ''
    echo -e '\033[01;32mDB pass\033[00;37m':
    read dbpass
    echo ''

    # Configurando wordpress
    wp core config --dbname=$dbname --dbhost=$dbhost --dbuser=$dbuser --dbpass=$dbpass

    echo ''
    # Bloco de criação do banco
    wp db create

    # Bloco de instalação
    echo ''
    echo -e '\033[01;32mTítulo do site\033[00;37m':
    read title
    echo ''
    # echo 'WP user':
    # read admin_user
    # echo ''
    # echo 'WP pass':
    # read admin_password
    # echo ''
    # echo 'Digite o email do usuário administrador':
    # read admin_email

    wp core install --url=http://localhost/$projeto --title=$title --admin_user=admin --admin_password=admin --admin_email=websites@trinityweb.com.br
}