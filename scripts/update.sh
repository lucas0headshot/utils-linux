#!/bin/bash

echo "Atualizando a lista de pacotes..."
sudo apt update

echo "Atualizando pacotes instalados..."
sudo apt upgrade


echo "Executando full-upgrade..."
sudo apt full-upgrade

echo "Removendo pacotes desnecessários..."
sudo apt autoremove
sudo apt autoclean

echo "Atualização concluída com sucesso!"
