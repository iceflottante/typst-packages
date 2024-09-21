set windows-shell := ["powershell.exe", "-c"]

# canary recipe
[private]
default:
  @just --list

_namespace := "local"
_package_name := "minimal-styling"
_package_version := "0.1.0"

_package_install_path := data_local_directory() / "typst" / "packages" / _namespace / _package_name / _package_version

# to be compatiable with path with space
# for example, make `/Users/{{username}}/Library/Application Support/typst/packages/local/...`
#             to be `"/Users/{{username}}/Library/Application Support/typst/packages/local/..."`
# be careful, `/Users/{{username}}/Library/Application\ Support/typst/packages/local/...` is not supported by just `path_exists`
_package_install_path_string := '"' + _package_install_path + '"'

_package_install_command := "git clone --depth 1 https://github.com/icyzeroice/typst-template-minimal-styling.git" + ' ' + _package_install_path_string
_package_update_command := "cd " + _package_install_path_string + ";git pull"

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
