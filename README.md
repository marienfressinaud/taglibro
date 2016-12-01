# Taglibro

Ceci est une version préliminaire de Taglibro, un réseau social anonyme sous
forme de "journal intime".

Ce projet est avant tout personnel et à titre d'essai.

Si vous souhaitez lancer l'application malgré tout, assurez-vous d'avoir Ruby
2.3 installé sur votre PC et de cloner le dépôt de Taglibro dans votre espace
de travail. Ensuite, lancez ces quelques commandes :

```bash
$ bundle install
$ bundle exec rails db:setup
$ bundle exec rails s
```

L'application devrait se lancer sur http://localhost:3000.

Si vous rencontrez le moindre soucis, plus d'informations sont disponibles dans
la suite de ce README.

Si vous comptez contribuer, assurez-vous d'avoir lu le fichier `CONTRIBUTING.md`.

## Initialisation de la base de données

La base de données utilisée étant PostgreSQL, assurez-vous qu'une telle base
fonctionne sur votre ordinateur.

La configuration présente dans `config/database.yml` implique que nous nous
basons sur le nom de l'utilisateur Linux actuellement connecté. Pour configurer
Postgres, il suffit de suivre les instructions suivantes (testé sous Fedora 24,
les instructions peuvent varier selon les distributions) :

```bash
$ whoami
john_doe
$ sudo -u postgres psql postgres
postgres=# CREATE ROLE john_doe WITH SUPERUSER LOGIN;
postgres=# \q
$ sudo vim /var/lib/pgsql/data/pg_hba.conf
# IPv4 local connections:
- host    all             all             127.0.0.1/32            ident
+ host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
- host    all             all             ::1/128                 ident
+ host    all             all             ::1/128                 trust
$ sudo systemctl restart postgresql
```

Une fois que votre base de données est configurée, il ne vous reste plus qu'à
l'initialiser avec la commande suivante :

```bash
$ bundle exec rails db:setup
```

## Tests

Les tests sont écrits à l'aide de [RSpec](http://rspec.info/). Pour lancer la
suite de tests, exécutez simplement :

```bash
$ bundle exec rspec
```

Les bibliothèques suivantes sont aussi utilisées :

- [Timecop](https://github.com/travisjeffery/timecop) pour tester facilement
  les fonctionnalités basées sur le temps
- [FactoryGirl](https://github.com/thoughtbot/factory_girl) pour ne pas se
  prendre la tête lors de la création des modèles

La suite de tests est automatiquement exécutée [sur Travis](https://travis-ci.org/marienfressinaud/taglibro)
dès lors que des commits sont poussés sur une branche. Les « pull requests »
doivent impérativement passer les tests pour pouvoir être mergées.

## Déploiement

Taglibro est actuellement automatiquement déployé sur la plateforme Heroku. Son
utilisation est pas conséquent **vivement déconseillée**. En effet, les données
sont stockées sur les serveurs d'Amazon, connu pour son appétit toujours
insatiable en données. Si vous souhaitez utiliser Taglibro, je ne peux que vous
conseiller de l'installer chez vous.

Pour se faire, voici un bout de documentation probablement incomplète vu que je
ne l'ai pas testée moi-même !

Tout d'abord, assurez-vous d'avoir une base de données PostgreSQL accessible
par l'application (des indications sont données plus haut).

Aussi, assurez-vous d'avoir Ruby 2.3 installé sur votre machine avec la gem
`bundler` puis exécutez les commandes suivantes :

```bash
$ git clone git@github.com:marienfressinaud/taglibro.git
$ cd taglibro
$ bundle install
$ bundle exec rails db:setup
$ bundle exec rails assets:precompile
```

Aussi, vérifiez que les variables d'environnement sont indiquées :

```
$ export RAILS_ENV=production
$ export HOSTNAME=<l'url vers votre application>
$ export RAILS_SERVE_STATIC_FILES=enabled
$ export DATABASE_URL=<l'url vers votre base de données… oui c'est orienté
"heroku" :(>
$ export SECRET_KEY_BASE=`RAILS_ENV=production bundle exec rake secret`
```

Ces variables d'environnement peuvent évidemment être mises dans un fichier
`.bashrc` ou similaire.

Dernier point (et non le moindre), Taglibro est actuellement prévu pour envoyer
les mails à l'aide de [Sendgrid](https://sendgrid.com/). Il vous faudra donc
vous créer un compte sur ce service et configurer ensuite taglibro en
renseignant les deux variables suivantes :

```bash
$ export SENDGRID_USERNAME=<nom d'utilisateur Sendgrid>
$ export SENDGRID_PASSWORD=<mot de passe Sendgrid>
```

Évidemment l'idéal serait de ne pas être dépendant de Sendgrid !

Ensuite il vous restera à configurer un proxy HTTP sur le port 80 et/ou 443
pour servir votre application Rails. Je conseille Nginx pour cela mais comme je
ne suis pas passé par cette étape, je vous renvoie vers de la documentation de
DigitalOcean qui est généralement pas mal : https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04
