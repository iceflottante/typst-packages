$IsTargetPsVersion = $PSVersionTable.PSVersion.Major -ge 7 -or ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -ge 4 )

if (-not $IsTargetPsVersion) {
  throw "Need PowerShell >= 7.4 (>= .Net 8.0)"
}


# https://docs.rs/dirs/latest/dirs/index.html
# https://learn.microsoft.com/en-us/dotnet/api/system.environment.specialfolder?view=net-8.0
$SourcePath = "./packages"
# $LocalInstallPath = "./local"
$LocalInstallPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData) + '/typst/packages/local'

function Copy-Typst-Local-Package {
    param (
        $Name,
        $Version
    )

    $dst_name = "$LocalInstallPath/$Name"
    $dst = "$LocalInstallPath/$Name/$Version"

    if (Test-Path -Path $dst) {
        Remove-Item -Recurse $dst -Force
        Write-Output "🔥 remove legacy $dst"
    } elseif (-not (Test-Path -Path $dst_name)) {
        New-Item -Path $LocalInstallPath -Name $Name -ItemType "directory"
    }
    New-Item -Path $dst_name -Name $Version -ItemType "directory"
    
    $src = "$SourcePath/$Name/*"

    Copy-Item -Path $src -Destination $dst -Recurse
    Write-Output "✅ install $src to $dst"
}

function Get-Typst-Package-Version {
  param (
    $Name
  )
  
  $toml_filepath = "$SourcePath/$Name/typst.toml"
  
  Select-String -Path $toml_filepath -Pattern "version" -SimpleMatch | Out-String -Stream | Select-String -Pattern "\d+\.\d+\.\d+" | ForEach-Object { $_.Matches[0].Value }
}


$TypstPackageNames = Get-ChildItem $SourcePath
foreach ($TypstPackageName in $TypstPackageNames) {
    $TypstPackageVersion = $(Get-Typst-Package-Version -Name $TypstPackageName.Name)
    Copy-Typst-Local-Package -Name $TypstPackageName.Name -Version $TypstPackageVersion
}
