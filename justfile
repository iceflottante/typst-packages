# set windows-shell := ["powershell.exe", "-c"]
set windows-shell := ["nu", "-c"]

# canary recipe
[private]
default:
  @just --list

local:
  # pwsh deploy.ps1
  nu deploy.nu
  
[doc("save and sync to the cloud")]
s:
  git add -A
  npx gitmoji-cli -c
  git push origin
