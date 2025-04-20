set windows-shell := ["powershell.exe", "-c"]

# canary recipe
[private]
default:
  @just --list

[unix]
local:
  pwsh deploy.ps1

[windows]
local:
  powershell -ExecutionPolicy ByPass -c "irm ./deploy.ps1 | iex"


commit:
  git add -A
  npx gitmoji-cli -c
  git push origin
