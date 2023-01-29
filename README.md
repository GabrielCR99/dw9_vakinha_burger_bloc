<p align="center">
    <img src="assets\images\logo.png" width="100" alt="Logo App Vakinha Burger"/>
</p>

<h1 align="center">Vakinha Burger</h1>

---

<h2>Tópicos 📋</h2>

   <p>

   - [📖 Sobre](#-sobre)
   - [📱 Preview](#-preview)
   - [📦 Assets](#-assets)
   - [🛠️ Funcionalidades e Tecnologias Estudadas](#%EF%B8%8F-funcionalidades-e-tecnologias-estudadas)
   - [🤯 Desafios e Aprendizados ao longo do caminho](#-desafios-e-aprendizados-ao-longo-do-caminho)
   - [🤔 Como usar](#-como-usar)
   - [💪 Como contribuir](#-como-contribuir)
   - [📝 Licença](#-licença)

   </p>

---

<h2>📖 Sobre</h2>

<p>
    Projeto desenvolvido na Dart Week | 9ª Edição, um evento de lançamento para a <a href="http://academiadoflutter.com.br/">Academia do Flutter (ADF)</a>, do <a href="https://github.com/rodrigorahman">Rodrigo Rahman</a>.<br><br>
    Nesse tempo de Pré-Acesso que obtive por ser um aluno da ADF (desde Fevereiro/2022), consegui entender com mais facilidade certos conceitos que ainda estavam confusos para mim, como a parte do <a href="https://pub.dev/packages/bloc">BLoC</a>.<br>
    Também, aprendi a base dos testes com o mesmo (este por conta própria, como forma de me desafiar a buscar mais conhecimento). Contei também com a ajuda da comunidade, que prontamente nos ajuda a trilhar o melhor caminho.<br>
</p>

---

<h2>📱 Preview</h2>

   <p align="center">
      <img src=".github/Vakinha-Burger-Demo.gif" width="400" alt="Vakinha Burger Demonstração">
   </p>

---

<h2>📦 Assets</h2>

- UI Design criado para o evento: <a href="https://www.figma.com/file/02eLp1LEMaZNbolCNBSyKA/Delivery-App?node-id=0%3A1">**Vakinha Burger**</a>
---   

<h2>🛠️ Funcionalidades e Tecnologias Estudadas</h2>

- Consulta da API usando o package Dio
- BLoC como Gerenciamento de Estado
- Fluxo de Login e Logout com a aplicação
- Persistência de dados com o SharedPreferences
- Pattern Matching com match
- Extensions
- Slivers
- RefreshToken (módulo extra)
- Providers
- Mixins
- Singleton
- Teste de BLoC
- Telas: 
  - Splash (tela inicial do app para transição)
  - Home (tela principal do app, lista todos os produtos disponíveis e que serve de fluxo inicial para as demais telas descritas abaixo)
  - Login (onde possui o fluxo de login)
  - Register (onde possui o fluxo de cadastro)
  - ProductDetail (detalhe da página do produto, onde temos mais componentes descritivos a respeito do produto)
  - Order (onde podemos escolher a forma de pagamento e finalizar nosso pedido)
   </p>

---

<h2>🤯 Desafios e Aprendizados ao longo do caminho</h2>

   <p>
   Como esse foi um "remake" de um Dart Week que já ocorreu (Vakinha Burger 6ª Edição com GetX), obtive um maior aproveitamento de código. Posso dizer com clareza que aprendi muito com o uso de um package para pattern matching, o <a href="https://pub.dev/packages/match">match</a>. O BLoC combinado com esse package e o ensinamento do Rodrigo Rahman, fica extremamente mais simples e divertido de enteder e desenvolver.<br>
   Aprendi também como começar os testes com bloc, algo que eu há tempos marquei para estudar, e finalmente consegui a introdução dos mesmos nesse DW, me desafiando (inclusivei irei incrementá-los).<br>
   Por mais que estes demoraram um tempo até eu entender o que de fato estava ocorrendo e o porquê não estavam passando à priori, foi extremamente satisfatório poder ler "2/2 tests passed(100%)".<br>
   Espero estar sempre aprendendo novas tecnologias com o Rahman e a comunidade incrivel de Flutter!
   </p>

---

<h2>🤔 Como usar</h2>

   ```
   É necessário ter o Flutter instalado. Para configurar o ambiente de desenvolvimento na sua máquina:
   https://flutter.dev/docs/get-started/install

   O aplicativo consome os dados do backend desenvolvido pela comunidade ADF chamado json_rest_server:
   https://pub.dev/packages/json_rest_server

   - Clone o repositório:
   $ git clone https://github.com/GabrielCR99/dw9_vakinha_burger_bloc dw9_vakinhar_burger_bloc

   - Entre no diretório:
   $ cd dw9_vakinhar_burger_bloc

   - Instale as dependências:
   $ flutter pub get

   - Instale o json_rest_server
   $ dart pub global activate json_rest_server

   - Crie um diretório do backend utilizando o json_rest_server
   $ json_rest_server create .\backend

   - Entre no diretório:
   $ cd backend

   - Para inicializá-lo, execute o comando:
   $ jrs run

   - Em outro terminal, no diretório raiz do projeto, execute:
   $ flutter run
   ```

---

<h2>💪 Como contribuir</h2>

   ```
   - Gosto bastante de seguir a seguinte Style Guide de Commits 😊:
   https://udacity.github.io/git-styleguide/

   - Dê um fork no projeto 

   - Cria uma nova branch com suas mudanças:
   $ git checkout -b my-feature

   - Salve suas mudanças e faça uma mensagem de commit message sobre suas alterações:
   $ git commit -m "feat: My new feature"

   - Envie suas mudanças:
   $ git push origin my-feature
   ```

---

<h2>📝 Licença</h2>

<p>
   Esse repositório está sobre a Licença MIT, e você pode vê-la no arquivo <a href="https://github.com/felipecastrosales/app_filmes/blob/master/LICENSE">LICENSE</a> para mais detalhes. 😉
</p>

---

   >Esse projeto foi desenvolvido com ❤️ por **[@Gabriel Roveri](https://www.linkedin.com/in/gabriel-roveri/)**, com o instrutor **[@Rodrigo Rahman](https://br.linkedin.com/in/rodrigo-rahman)**, no evento #DartWeek da **[Academia do Flutter](https://instituto.academiadoflutter.com.br)**.<br>
   Se isso te ajudou, dê uma ⭐, e contribua, isso irá me ajudar também 😉

---

   <div align="center">

   [![Linkedin Badge](https://img.shields.io/badge/-Gabriel%20Roveri-292929?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/gabriel-roveri/)](https://www.linkedin.com/in/gabriel-roveri/)

   </div>