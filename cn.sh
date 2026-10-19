#!/usr/bin/env bash

# -----------------------------------------------------------------------
# Projeto   : Cianobactérias
# Arquivo   : cn.sh
# Descrição : Script para criação de scripts
# Versão    : 0.1.2
# Data      : 20/08/2026 - 19:39
# Autor     : Alan Fernandes <4lan7ernandes@proton.me>
# Licença   : GNU/GPL v3.0
# -----------------------------------------------------------------------
# Uso: cn.sh nomedoseuscript
# -----------------------------------------------------------------------

# PROCEDIMENTOS DE VALIDAÇÃO
#
#
#
# Define LC_ALL para a categoria de localidade C

LC_ALL=C

# Mensagens de erro

msg_erro[1]='Número incorreto de parâmetros'
msg_erro[2]='Nome inválido'
msg_erro[3]="Já existe uma pasta chamada $1"

# Função para encerrar o script com uma mensagem de erro

erro() {

	echo ${msg_erro[$1]}
	echo "uso: cn.sh nomedoseuscript"
	exit $1

       }

# Valida o número de parâmetros

[[ $# -ne 1 ]] && erro 1

# Valida o nome do novo projeto

[[ $1 =~ ^[-_0-9a-z]+$ ]] || erro 2

# Verifica se existe uma pasta/arquivo com o nome do projeto no diretório

[[ -a $1 ]] && erro 3


# PROCEDIMENTOS DE CRIAÇÃO DO NOVO PROJETO

# String do modelo a ser inserido novo script

modelo="#!/usr/bin/env bash

# -----------------------------------------------------------------------
# Projeto   : $1
# Arquivo   : $1.sh
# Descrição :
# Versão    : 0.0.0
# Data      : $(date '+%d/%m/%Y - %R')
# Autor     : Alan Fernandes <4lan7ernandes@proton.me>
# Licença   : GNU/GPL v3.0
# -----------------------------------------------------------------------
Uso:
# -----------------------------------------------------------------------

"
# Pastas e arquivos de destino

caminho_destino=$HOME/Documentos/codigos/
caminho_projeto=$caminho_destino/$1
arquivo_destino=$caminho_projeto/$1.sh
arquivo_symlink=$HOME/bin/$1

# Cria a pasta de destino

mkdir -p $caminho_projeto

# Cria o arquivo de destino

echo "$modelo" >> $arquivo_destino

# Torna o arquivo destino executável
chmod +x $arquivo_destino

# Cria uma ligação simbólica para o novo script
ln -s $arquivo_destino $arquivo_symlink

vim $arquivo_destino
