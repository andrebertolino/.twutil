download()
{
    echo ""
    echo -e "\033[01;32mProjeto\033[00;37m"
    read projeto

    echo ""

    cd $www && mkdir $projeto && cd $projeto  

    wp core download --locale=pt_BR
}