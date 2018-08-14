net()
{
    # Bloco de criação do banco
    echo ''
    echo -e '\033[01;32mDeseja reiniciar o roteador da NET? (y/n)\033[00;37m':
    read dbquest
    if [ "$dbquest" = "y" ]
    then
        echo ''
        cd /Users/$USER/.twutil/bin/net/ && node reboot.js
    fi
    echo ''
    echo -e '\033[01;32mO roteador foi reiniciado com sucesso!\033[00;37m'
}