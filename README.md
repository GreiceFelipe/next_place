# README

* Ruby version 3.0.1

* Rails version 6.1.3

* postgresql

### Configurações

Para instalar todas as dependências do rails:

```
bundle

```

### Criar o banco de dados

```
rails db:create
```

### Configurar o banco de dados

```
rails db:migrate
```

### Preenchimento do banco utilizando o seed

```
rails db:seed
```
#### Para rodar o rspec 

```
rspec
```

#### Para rodar o projeto 

```
rails s
```

#### Routes 

```
users POST   /users users#create
user GET    /user show#users
POST   /user  update#users

places POST   /places places#create
find_places GET    /find_places  places#findplaces
list_places GET    /list_places places#listplaces
map_list_places GET    /map_list_places places#map_list_places
rate_places POST   /rate_places rate_places#create
rates_by_place GET    /rates_by_place   rate_places#rates_by_place

```


