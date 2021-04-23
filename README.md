# Ubiquous-Quizz-Builder
Bem vindo ao repositório da aplicação Ubiquous Quiz Builder. Esta aplicação faz parte de uma plataforma com uma componente Web onde permite a utilizadores criarem questionarios, visualizarem as suas estatisticas e tambem fazer a gestão dos mesmos no caso dos administradores.
A componente atual a ser desenvolvida neste repositórioé uma aplicação que nos permite responder aos questionarios criados na plataforma Web.

## Como correr o projeto?

Abra o AndroidStudio. Caso esteja com um projeto aberto, vá a "File" > "Close Project" e agora na janela inicial selecione "Get from Version Control", e cole o link: https://github.com/diogo19o/Ubiquous-Quizz-Builder.git

Pressione "Clone", agora que já tem o projeto no seu dispositivo, precisamos de ir buscar as dependencias utilizadas. Pode fazer isso por:
* Abrir o terminal e escrever o seguinte comando "flutter pub get"
* Ou abrir um dos ficheiros ".dart" denro da pasta "lib" e no canto superior direito clique em "Get Dependencies"


## Web services:

### Esta aplicação vai buscar informação à base de dados por meio de Web services

* Registar nova conta
* Autenticar Utilizador
* Receber questionários
* Receber resultados de um questionário
* Receber perguntas de um questionário
* Receber respostas a uma pergunta
* Receber questionários de um utilizador
* Enviar resposta a uma pergunta

## Requisitos

### Funcionais:
- [x] Efetuar login.
- [ ] Registar uma conta.
- [ ] Três modos de jogo (Clássico, Contra-relógio e Morte súbita).
- [ ] Modo questionário que só pode ser respondido uma vez por pessoa.
- [x] Lista de quizzes e questionários ativos.
- [ ] Sistema de filtragem/ordenação das listas.
- [ ] Mostrar o resultado no final de responder a cada quizz.
- [ ] Guardar pontuações obtidas nos questionários como também o número de quizzes respondidos.
- [ ] Sistema de ranking nos diferentes modos de jogo.


### Não Funcionais:
- [x] Aplicação desenvolvida em Flutter
- [x] Aplicação disponivel para Android e IOS
- [x] Ligação à internet 
