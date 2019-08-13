# README

Projeto criado para o [desafio da Gympass](CHALLENGE.md)

## Instalação

### Instale as dependencias

```shell
$ bundle
```

## Uso da aplicação

O projeto tem um executavel na pasta bin que roda a aplicação e recebe o caminho para o arquivo de log como parametro

```shell
$ bin/analyze_race_log 'data_files/race.log'
```

## Testes

Para rodas todos os testes:
```shell
$ rspec
```

## Considerações

- A organização do projeto é influenciada pelo framework Rails.
- Criei uma base model para definir um schema basico dos atributos.

## Melhorias

- Melhorar o comando que roda a aplicação com help e opções.
