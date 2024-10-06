set windows-shell := ["powershell.exe", "-c"]

# canary recipe
[private]
default:
  @just --list

local:
  pwsh deploy.ps1