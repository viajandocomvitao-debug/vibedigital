@echo off
echo Enviando atualizacoes para o GitHub...
git add .
git commit -m "atualizacao automatica"
git push
echo Site atualizado com sucesso!
pause
