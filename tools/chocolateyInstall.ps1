try {
  $name  = "visualstudio-contextmenu"
  $binPath = "$env:LOCALAPPDATA\$name"
  $tools = Split-Path $MyInvocation.MyCommand.Definition
  $reg   = Join-Path $tools "build_solution_vs2010.reg"

  # Install bat files to a location

  New-Item $binPath -ItemType Directory -Force | Out-Null
  Copy-Item "$tools\$name\*" $binPath -Force

  # Write the .sln context menu to the registry
  Write-Host "Adding context menus for .sln files." -ForegroundColor DarkYellow
  regedit /s $reg

  # Write the directory context menu to the registry
  #Write-Host "Adding context menus for folders." -ForegroundColor DarkYellow
  #regedit /s $reg

  # Add to path
  Install-ChocolateyPath $binPath
  Write-Host "Build scripts have been installed to $binpath and have been added to your path." -ForegroundColor DarkYellow

  Write-ChocolateySuccess $name
} 
catch {
  Write-ChocolateyFailure $name $_.Exception.Message
  throw 
}