@echo off
chcp 65001 >nul
cd /d "%~dp0"
if not exist .env (
  echo ERRO: Copie .env.example para .env e preencha os dados do seu bot.
  pause
  exit /b 1
)
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js nao encontrado. Instale o Node.js 20 ou superior.
  pause
  exit /b 1
)
if not exist node_modules (
  echo Instalando dependencias...
  call npm install
  if errorlevel 1 (
    echo Falha ao instalar dependencias.
    pause
    exit /b 1
  )
)
echo Iniciando BR ARENA Bot...
call npm start
pause
