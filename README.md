# Taglibro

Ceci est une version préliminaire de Taglibro, un réseau social anonyme sous
forme de "journal intime".

Pour le moment je mets encore en place les différents outils de développement
et de déploiement donc les choses vont pas mal bouger.

Si vous souhaitez lancer l'application malgré tout, assurez-vous d'avoir Ruby
2.3 installé sur votre PC et de cloner le dépôt de Taglibro dans votre espace
de travail. Ensuite, lancez ces quelques commandes :

```bash
$ bin/bundle install
$ bin/rails s
```

L'application devrait se lancer sur http://localhost:3000.

Il reste à documenter :

- la configuration
- la création et initialisation de la base de données
- la phase de déploiement
- les différentes manières de contribuer

Pour ce qui est du suivi du projet, tout se passe pour le moment sur GitHub :
https://github.com/marienfressinaud/taglibro/projects/1 (i.e. projet MVP).

## Développement

### Configuration de PostgreSQL

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

### Messages de commit

Afin de garder un historique clair et de pouvoir générer un changelog
facilement, il est recommandé de configurer Git pour qu'il prenne en compte le
message de template de commit fourni dans `.gitmessage`. Pour cela, éditez le
fichier `.git/config`:

```
...
[commit]
  template: .gitmessage
```

Ce message force la structure du message de commit pour le rendre plus
explicite.

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
