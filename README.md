# Ubiquous-Quizz-Builder
Bem vindo ao repositório da aplicação Ubiquous Quiz Builder. Esta aplicação faz parte de uma plataforma com uma componente Web onde permite a utilizadores criarem questionarios, visualizarem as suas estatisticas e tambem fazer a gestão dos mesmos no caso dos administradores.  
A componente atual a ser desenvolvida neste repositório é uma aplicação que nos permite responder aos questionarios criados na plataforma Web.

Link para download da apicação:
https://www.mediafire.com/file/hcxvpqk6p18ji6g/Ubiquous-Quiz-Builder.apk/file

Link para a plataforma online (onde se pode criar os questionários):
https://php-ubiquous-quiz-builder.herokuapp.com/

Video demonstrativo da Plataforma Online e da aplicação:
https://youtu.be/U5lXcgpISiY

Repositório da plataforma Web:
https://github.com/diogo19o/php-ubiquous-quiz-builder

## Como correr o projeto?

Abra o AndroidStudio. Caso esteja com um projeto aberto, vá a "File" > "Close Project" e agora na janela inicial selecione "Get from Version Control", e cole o link: https://github.com/diogo19o/Ubiquous-Quizz-Builder.git

Pressione "Clone", agora que já tem o projeto no seu dispositivo, precisamos de ir buscar as dependencias utilizadas. Pode fazer isso por:
* Abrir o terminal e escrever o seguinte comando "flutter pub get"
* Ou abrir um dos ficheiros ".dart" denro da pasta "lib" e no canto superior direito clique em "Get Dependencies"

#### Null Safety Waring!
*****
Nota:  
Se por alguma razão ao dar run da app, acontecerem varios erros relativos a null safety. Por favor entre em contacto para o meu email: diogo.santos.novo@hotmail.com.  
Esta app não foi desenvolvida para a versão mais recente do Flutter que ja implementa null safety.
*****


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
- [x] Registar uma conta.
- [x] Três modos de jogo (Clássico, Contra-relógio e Morte súbita).
- [x] Modo questionário que só pode ser respondido uma vez por pessoa.
- [x] Lista de questionários por modo.
- [x] Sistema de filtragem/ordenação das listas.
- [x] Mostrar o resultado no final de responder a cada quizz.
- [x] Guardar pontuações obtidas nos questionários como também o número de quizzes respondidos.
- [x] Sistema de ranking nos diferentes modos de jogo.
- [x] Perguntas com imagens.


### Não Funcionais:
- [x] Aplicação desenvolvida em Flutter
- [x] Aplicação disponivel para Android e IOS
