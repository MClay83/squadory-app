@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================
echo   Squadory App - Deploy para o GitHub Pages
echo ============================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Git nao encontrado no PATH.
  echo Instale o Git for Windows: https://git-scm.com/download/win
  echo.
  pause
  exit /b 1
)

if not exist ".git" (
  echo Primeira execucao: inicializando o repositorio...
  git init
  git branch -M main
  git remote add origin https://github.com/MClay83/squadory-app.git
)

REM garante identidade e remote corretos
git config user.name  >nul 2>nul || git config user.name  "Marcelo Clay"
git config user.email >nul 2>nul || git config user.email "marcelo@grupoflow.media"
git remote set-url origin https://github.com/MClay83/squadory-app.git 2>nul || git remote add origin https://github.com/MClay83/squadory-app.git

set "MSG=%~1"
if "%MSG%"=="" set "MSG=Atualizacao do app Squadory"

echo.
echo Espelhando dist em docs para publicacao...
robocopy dist docs /MIR /NFL /NDL /NJH /NJS
if errorlevel 8 (echo [ERRO] robocopy falhou & pause & exit /b 1)
copy /Y docs\index.html docs\404.html
copy /Y CNAME docs\CNAME
REM .nojekyll e obrigatorio: sem ele o GitHub Pages roda o Jekyll, que ignora
REM a pasta _expo (comeca com sublinhado) e o app abre em branco.
type nul > docs\.nojekyll

echo.
echo Registrando alteracoes...
git add -A
git commit -m "%MSG%"
if errorlevel 1 echo (Nada novo para enviar, seguindo para o push...)

echo.
echo Enviando para o GitHub...
git push -u origin main
if errorlevel 1 (
  echo.
  echo [ATENCAO] O push falhou. Se pediu login do GitHub, aprove e rode de novo.
  echo.
  pause
  exit /b 1
)

echo.
echo === Concluido! Configure o GitHub Pages (Settings - Pages) para publicar a partir da pasta docs. ===
echo.
pause
