# Vem de Vagas
### Tabela de Conteúdos
  * [Descrição](#Descrição)
    * [Principais funcionalidades](#Principais-funcionalidades)
  * [Como rodar a aplicação](#Como-rodar-a-aplicação)
    * [Pré-requisitos](#Dependências-inicias)
    * [Instalação, Execução e Teste](#Instalação-Execução-e-Teste)
  * [Linguagens, Dependências e Libs usadas](#Linguagens-Dependências-e-Libs-usadas)
  * [Links de ferramentas externas usadas](#Links-de-ferramentas-externas-usadas)
## Descrição
<p align="justify"> Plataforma simples de oferta e busca de vagas para a área de tecnologia, desenvolvida em Ruby on Rails, como parte do treinamento da turma 5 do programa <a href="https://www.treinadev.com.br">Treinadev</a> da <a href="https://campuscode.com.br">Campus Code</a>.</p>

![Badge](https://img.shields.io/static/v1?label=ruby&message=2.7.2&color=red&style=for-the-badge&logo=ruby)
![Badge](https://img.shields.io/static/v1?label=ruby+on+rails&message=6.1.2&color=red&style=for-the-badge&logo=ruby+on+rails)
![Badge](https://img.shields.io/static/v1?label=bootstrap&message=5.0.0&color=blueviolet&style=for-the-badge&logo=bootstrap)
![Badge](https://img.shields.io/static/v1?label=sqlite&message=3.31.1&color=blue&style=for-the-badge&logo=sqlite)
[![License](https://img.shields.io/badge/license-mit-green.svg?style=for-the-badge)](LICENSE.md)
> Status do Projeto: Em desenvolvimento :warning: :construction_worker:

### Principais funcionalidades
- [ ] Funcionário cria conta associada a uma empresa
- [ ] Funcionário cria vagas
- [ ] Funcionário avalia candidaturas
- [ ] Candidato cria conta
- [ ] Candidato se candidata a uma vaga
- [ ] Candidato avalia proposta
- [ ] Vaga é finalizada

## Como rodar a aplicação
### Pré-requisitos:
+ Ruby - 2.7.2
+ Node
+ Yarn
+ Git
+ SQlite

### Instalação, Execução e Teste
Clone o repositório do Github
```
$ git clone https://github.com/matheusma37/vem-de-vagas.git
```
ou
```
$ git clone git@github.com:matheusma37/vem-de-vagas.git
```
Entre no repositório
```
$ cd vem-de-vagas/
```
Instale as dependências
```
$ bin/setup
```
Faça a migração do banco de dados
```
$ rails db:migrate
```
Teste o projeto
```
$ bundle exec rspec
```
Para executar o servidor, rode
```
$ rails s
```

## Linguagens, Dependências e Libs usadas
+ [Capybara](https://github.com/teamcapybara/capybara)
+ [Devise](https://github.com/heartcombo/devise)
+ [Simplecov](https://github.com/simplecov-ruby/simplecov)
+ [Shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)

## Links de ferramentas externas usadas
+ [Quadro Trello](https://trello.com/b/50tmKggf/vem-de-vagas)
+ [Telas Figma](https://www.figma.com/file/vfUotRBP88yCW6j6nDUfF2/Vem-de-Vagas?node-id=0%3A1)