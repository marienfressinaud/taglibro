# Comment contribuer à Taglibro ?

Réponse courte : vous ne pouvez pas !

Réponse longue : bien que Taglibro soit un logiciel libre, le projet n'en est
pas pour autant communautaire. C'est-à-dire que je suis seul maître à bord et
je souhaite le rester (pour le moment en tout cas). Taglibro est prévu pour
répondre à des besoins personnels très spécifiques et c'est pourquoi je ne
prendrais probablement pas en compte vos demandes. Le mieux est donc de forker
le projet si vous souhaitez le faire « vivre ».

Pour être plus précis, vous pouvez contribuer… à condition de suivre la roadmap
disponible sur https://github.com/marienfressinaud/taglibro/projects. Si vous
souhaitez développer une fonctionnalité il faudra impérativement en parler sur
le ticket correspondant et que celui-ci fasse parti du projet en cours (MVP
pour le moment).

Aussi, si vous souhaitez corriger un bug, compléter la documentation ou
améliorer la suite de tests, je pourrai problablement considérer des pull
requests… Mais à condition que le code soit clair, respecte des règles de code
que je n'ai pas (encore) définies mais que je saurais vous indiquer et que vos
commits soient bien écrits.

Pour cela, il est recommandé de configurer Git pour qu'il prenne en compte le
message de template de commit fourni dans `.gitmessage`. Pour cela, éditez le
fichier `.git/config`:

```
...
[commit]
  template: .gitmessage
```

Ce message force la structure du message de commit pour le rendre plus
explicite.
