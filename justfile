set windows-shell := ["powershell.exe", "-c"]

# canary recipe
default:
  @echo "hello, CLI!"
  @just --list

_namespace := "local"
_package_name := "minimal-styling"
_package_version := "0.1.0"

# to be compatiable with path with space
# for example, make `/Users/{{username}}/Library/Application Support/typst/packages/local/...`
#             to be `/Users/{{username}}/Library/Application\ Support/typst/packages/local/...`
_package_install_path := replace(data_local_directory(), ' ', '\ ') / "typst" / "packages" / _namespace / _package_name / _package_version

_package_install_command := "git clone --depth 1 https://github.com/icyzeroice/typst-template-minimal-styling.git" + " " + _package_install_path
_package_update_command := "cd " + _package_install_path + ";git pull"

_package_sync_command := if path_exists(_package_install_path) == "false" {
  _package_install_command
} else {
  _package_update_command
}

# https://github.com/typst/packages?tab=readme-ov-file#local-packages
sync:
  @echo {{_package_install_path}}
  @echo {{_package_sync_command}}
  {{_package_sync_command}}
