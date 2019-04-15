# App Rails de To Do

Teste desenvolvido por Walter de Oliveira Neto

## Requerimento

```
Docker 2.0.0 (Versão recomendada)
```

## Instalação

Após instalar o docker, clone o repositório para a sua máquina.

```
git clone https://github.com/Worldpackers/todo.git
```

O próximo passo é configurar o arquivo '.env' que se encontra no diretório root do projeto.

Na primeira linha edite o campo 'USER_SYS' para o e-mail que deseja receber as notificações. Logo abaixo edite as configurações de SMTP, recomendo a utilização do serviço "https://mailtrap.io/".

```
#Usuário do sistema que receberá os emails de notificação
USER_SYS=EMAIL_DE_DESTINO

#Configuração do servidor SMTP para disparar os emails
SMTP_ADDRESS=smtp.mailtrap.io
SMTP_PORT=2525
SMTP_DOMAIN=smtp.mailtrap.io
SMTP_USER_NAME=c01fb3f276437e
SMTP_PASSWORD=093759cacdd450
SMTP_AUTHENTICATION=cram_md5
SMTP_ENABLE_STARTTLS_AUTO=true
```

Feito a edição salve o arquivo e execute o comando abaixo para criar a imagem no docker, todos os comandos são executados no root do projeto:

```
docker-compose build
```

Após o 'build' o próximo passo é subir o container, execute o seguinte comando:

```
docker-compose up
```

Com o servidor rodando, vamos criar o nosso banco de dados, abra uma nova janela no terminal e execute o seguinte comando:

```
docker-compose run web rake db:create db:migrate
```

Já podemos acessar o projeto no endereço:

```
http://localhost:3000
```

Para rodar os testes unitários execute o seguinte comando:

```
docker-compose run web rspec
```

Após criar uma 'task' e fecha-la pelo painel já podemos gerar nosso arquivo CSV.

Execute a rake task para gerar:

```
docker-compose run web rake export:tracking
```

Para visualizar os arquivos gerados basta acessar:

```
http://localhost:3000/tracking
```


===================

# App Rails de To Do

Nesse to-do list é possível:
* Adicionar uma tarefa (que é simplesmente um campo de texto)
* Editar uma tarefa
* Remover uma tarefa
* Marcar uma tarefa como completa

Quando um usuário marcar uma tarefa como completa:
* O sistema manda um email para o usuário com uma bela frase aleatória de "Parabéns" (inventa qualquer 5 frases aleatórias) pintada de uma cor hexadecimal aleatória também (inventa 5 e pega uma aleatoriamente)

* Além disso, também tem que enviar um evento para o sistema de tracking. Por simplicidade, o sistema de tracking é só uma tabelinha de eventos que tem um tipo de evento e um campo json em que você manda dados relevantes. No caso, guardar nesse campo json a cor e a frase aleatória do email de "Parabéns".

Algumas exigências dos usuários muito empolgados com o sistema:
* Usar o [Bootstrap](https://getbootstrap.com/) para o CSS
* Criar uma rake task que extrai um relatório CSV de todos os eventos com: usuário, cor hexadecimal, frase e a hora que foi marcada como completa (não vale simplesmente imprimir attributes ou o json. tem que ser cada um separado).

Faça o código exatamente como faria no dia-a-dia de trabalho. Não precisa inventar algo para impressionar : ) Só faça com o que está confortável.
