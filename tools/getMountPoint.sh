#!/bin/bash

#executar isso apenas na primeira vez
#é interessante verificar a existencia do arquivo .mountpoint
#pois se ele existe provavelmente não é a primeira vez que o sistema está rodando
if [[ -f ".mountpoint" ]]
then
    echo "::Arquivo .mountpoint Encontrado! Abortando..."
    exit 1
fi

#obtem a particao no sistema live.
a= lsblk | grep /mnt | cut -f1 -d" "

#DEBUG, desmarque para conferir
#a="sdd"

#gera o arquivo de particao de montagem
echo $a > .mountpart
echo "Particao de Montagem: $a"
b="/mnt/$a"
echo "Ponto de montagem: $b"
#gera o arquivo de ponto de montagem
echo $b > .mountpoint

#debug, desmarque para conferir
#echo "arquivo mountpart"
#cat .mountpart
#echo "arquivo mountpoint"
#cat .mountpoint
