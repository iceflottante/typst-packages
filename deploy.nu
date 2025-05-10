# for testing
# let install_path = "./local"

let install_path = $env.APPDATA | path join "typst" "packages" "local"

let source_path = "./packages"

def copy-typst-local-package [package_name: string, package_version: string] {
    let package_path = ($install_path | path join $package_name)
    let package_version_path = ($package_path | path join $package_version)

    # Remove existing version directory if present
    if ($package_version_path | path exists) {
        rm -r $package_version_path
        print $"🔥 Removed legacy directory: ($package_version_path)"
    }

    # Ensure parent directory exists
    if not ($package_path | path exists) {
        mkdir $package_path
    }

    # Create target path
    mkdir $package_path
    
    # Copy package contents
    let src_dir = ($source_path | path join $package_name)
    cp -r $src_dir $package_version_path

    print $"✅ Installed ($src_dir) to ($package_version_path)"
}

def get-typst-package-version [name: string] {
    let toml_filepath = ($source_path | path join $name "typst.toml")
    open $toml_filepath | get package.version
}

# Main processing loop
let packages = (ls $source_path | where type == dir)
for $package in $packages {
    let name = ($package.name | path basename)
    let version = (get-typst-package-version $name)
    copy-typst-local-package $name $version
}
