set windows-shell := ["powershell.exe", "-c"]

# canary recipe
[private]
default:
  @just --list

local:
  pwsh deploy.ps1
  
commit:
  git add -A
  npx gitmoji-cli -c
  git push origin