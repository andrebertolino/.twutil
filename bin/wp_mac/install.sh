install()
{
    echo ''
    echo -e '\033[01;32mProjeto\033[00;37m'
    read projeto

    cd ~/www && mkdir $projeto && cd $projeto  

    wp core download --locale=pt_BR

    # Configurando wordpress
    wp core config --dbname=$projeto --dbhost=localhost --dbuser=root --dbpass=trinity

    # Bloco de criação do banco
    wp db create
    wp core install --url=http://localhost/$projeto --title=$projeto --admin_user=trinityweb --admin_password=trinity --admin_email=websites@trinityweb.com.br
}