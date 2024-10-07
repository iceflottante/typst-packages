$IsTargetPsVersion = $PSVersionTable.PSVersion.Major -ge 7 -or ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -ge 4 )

if (-not $IsTargetPsVersion) {
  throw "Need PowerShell >= 7.4 (>= .Net 8.0)"
}


# https://docs.rs/dirs/latest/dirs/index.html
# https://learn.microsoft.com/en-us/dotnet/api/system.environment.specialfolder?view=net-8.0
$SourcePath = "./packages"
# $LocalInstallPath = "./local"
$LocalInstallPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData) + '/typst/packages/local'

function Copy-Typst-Private-Package {
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


$TypstPackageNames = Get-ChildItem $SourcePath
foreach ($TypstPackageName in $TypstPackageNames) {
    # Write-Output $TypstPackageName | Format-List
    Copy-Typst-Private-Package -Name $TypstPackageName.Name -Version "0.1.0"
}