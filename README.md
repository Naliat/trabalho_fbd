# Configuração do Ambiente

Este guia fornece instruções detalhadas para configurar e executar o projeto em ambientes Windows e Linux.

## Pré-requisitos

Antes de iniciar, certifique-se de que as seguintes ferramentas estão instaladas no seu sistema:

- **Python 3.6+**: Para executar o projeto. [Download Python](https://www.python.org/downloads/).
- **pip**: O gerenciador de pacotes do Python. Geralmente, ele vem instalado com o Python.
- **Git**: Para clonar o repositório do projeto, se necessário. [Download Git](https://git-scm.com/downloads).

---

## Instruções para Windows

1. **Instale o Python 3.6+**:
   - Baixe e instale a versão mais recente do Python para Windows. Durante a instalação, certifique-se de marcar a opção "Add Python to PATH".

2. **Verifique o `pip`**:
   - O `pip` deve estar instalado junto com o Python. Para confirmar, execute:
     ```bash
     pip --version
     ```

3. **Crie um ambiente virtual (`venv`)**:
   - Navegue até a pasta do projeto e execute o seguinte comando para criar um ambiente virtual:
     ```bash
     python -m venv myvenv
     ```

4. **Ative o ambiente virtual**:
   - Para ativar o ambiente virtual, execute:
     ```bash
     myvenv\Scripts\activate
     ```

5. **Instale as dependências do projeto**:
   - Com o ambiente virtual ativo, instale as dependências necessárias usando o arquivo `requirements.txt`:
     ```bash
     pip install -r requirements.txt
     ```

6. **Execute a aplicação**:
   - Agora, você pode executar a aplicação utilizando:
     ```bash
     python ./main.py
     ```

7. **Verifique e teste a aplicação**:
   - Revise o código no arquivo `./main.py` e teste as funcionalidades para garantir que tudo esteja funcionando corretamente.

---

## Instruções para Linux

1. **Instale o Python 3.6+**:
   - Utilize o gerenciador de pacotes da sua distribuição para instalar o Python, caso ainda não esteja instalado:
     ```bash
     sudo apt-get update
     sudo apt-get install python3 python3-venv python3-pip
     ```

2. **Crie um ambiente virtual (`venv`)**:
   - Navegue até a pasta do projeto e execute:
     ```bash
     python3 -m venv myvenv
     ```

3. **Ative o ambiente virtual**:
   - Para ativar o ambiente virtual, utilize o comando:
     ```bash
     source myvenv/bin/activate
     ```

4. **Instale as dependências do projeto**:
   - Com o ambiente virtual ativo, instale as dependências necessárias:
     ```bash
     pip install -r requirements.txt
     ```

5. **Execute a aplicação**:
   - Rode a aplicação com o comando:
     ```bash
     python3 ./main.py
     ```

6. **Verifique e teste a aplicação**:
   - Revise o código no arquivo `./main.py` e faça os testes necessários para garantir que a aplicação funcione como esperado.

---

## Dependências obrigatórias

Para garantir que o projeto funcione corretamente, você deve ter:

- **Python 3.6 ou superior**
- **pip** para instalação de pacotes Python
- **Git** caso precise clonar o repositório
- **Todas as bibliotecas listadas em `requirements.txt`** para que todas as funcionalidades da aplicação sejam executadas corretamente.
