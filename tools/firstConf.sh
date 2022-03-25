#!/bin/bash

#Script de Primeira Configuração do MineCore by Gaka
#Nesse script usaremos a particao onde o sistema foi montado
#e já faremos as alteracoes necessárias nos arquivos de configuracao.

#verificamos a existencia dos arquivos do ponto de montagem
if [[ -f ".mountpoint" ]]
then
    echo "::Arquivo .mountpoint Encontrado!"
else
    echo "::Arquivo .mountpoint nao Encontrado!"
    bash ./getMountPoint.sh
fi

#checamos se o ponto de montagem está funcional
read -r particao<.mountpart
read -r montagem<.mountpoint

if [[ $particao == "" ]]
then
    echo "::A particao nao pode ser vazia!"
    echo "Abortando!"
    echo "Reporte esse incidente no Matrix/Telegram, por favor"
    exit
fi

#entramos no ponto de montagem
cd $montagem

#debug desmarque para teste
#cd <INSIRA AQUI SEU DIRETORIO DE TESTES>

#agora verificamos pelo arquivo (apenas uma unidade estará montada e terá arquivos sem a manipulação do usuário)
#durante a primeira inicialização, essa unidade é o sistema de arquivos do MineCore e terá um arquivo ldlinux na raíz.

#checa pela existencia do ldlinux
if [[ -f "ldlinux.sys" ]]
then
    echo ":: ldlinux.sys Encontrado!"
else
    echo "::: ldlinux.sys nao encontrado em $montagem"
    echo "Abortando..."
    echo ".!. Reporte esse incidente no Matrix/Telegram, por gentileza"
    exit
fi


#definimos o diretório do configurador do syslinux
syslinuxConfig="boot/syslinux/syslinux.cfg"

#debug, desmarque para ler
#ponto de montagem encontrado
#echo "Ponto de Montagem: $montagem"
#o arquivo deve estar nesse caminho
#echo "$montagem/$syslinuxConfig"

#substituiremos agora as linhas tce=sdb do syslinux.cfg
#se a montagem for diferente de sdb
if [[ $particao != "sdb" ]]
then
    sed -i 's/tce=sdb/tce='$particao'/g' "$montagem/$syslinuxConfig"
    echo "::: Configuracoes alteradas em $montagem/$syslinuxConfig"
    echo "Primeira configuracao realizada com sucesso"
    echo "Debug..."
    cat "$montagem/$syslinuxConfig"
    sleep 60
    echo ":: Reiniciando em 5"
    sleep 1
    echo ":: Reiniciando em 4"
    sleep 1
    echo ":: Reiniciando em 3"
    sleep 1
    echo ":: Reiniciando em 2"
    sleep 1
    echo ":: Reiniciando em 1"
    sleep 1
    echo ":: Reiniciando..."
    sleep 1
    #reinicialização especial, implementar baseado no arquivo
    #/etc/init.d/rc.shutdown
    #Importante: NESSA PARTE NÃO USAR REBOOT COMUM
    #<COMANDO DO REBOOT ESPECIAL>
else
    echo "O ponto de montagem ja eh sdb, nada sera alterado"
    echo "Primeira configuracao realizada com sucesso"
fi
