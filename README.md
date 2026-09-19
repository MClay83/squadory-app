# squadory-app (deploy web)

Gerar: `cd mobile && npm run export:web` (gera `../../../web/squadory-app/dist`).
Publicar: rodar `deploy.bat` nesta pasta (espelha `dist` em `docs` e publica; faz `git init` na primeira vez, commit e push para `MClay83/squadory-app`).
DNS: registro `CNAME app -> mclay83.github.io` no provedor do dominio; no GitHub, repositorio `squadory-app` -> Settings -> Pages -> Source "Deploy from a branch", branch `main`, pasta `/docs`, custom domain `app.squadory.com` (ativar "Enforce HTTPS" quando o certificado sair).
