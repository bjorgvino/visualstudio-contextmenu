try {
  $name  = "visualstudio-contextmenu"

  $paths = @(
    "$env:LOCALAPPDATA\$name"
  )

  $paths | foreach {
    if (Test-Path $_) {
      Remove-Item $_ -Recurse -Force
    }

    Write-Host "'$_' has been removed." -ForegroundColor DarkYellow
  }

  # Remove context menu from registry
  Write-Host "Removing registry keys." -ForegroundColor DarkYellow
  reg delete "HKEY_CLASSES_ROOT\VisualStudio.Launcher.sln\Shell\vs_build_menu_anchor" /f
  reg delete "HKEY_CLASSES_ROOT\VisualStudio.Launcher.sln\vs_build_menu" /f
  reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\vs_build_menu_anchor" /f
  reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\vs_build_menu" /f
  Write-Host "Registry keys removed." -ForegroundColor DarkYellow

  # Done
  Write-ChocolateySuccess $name
} 
catch {
  Write-ChocolateyFailure $name $_.Exception.Message
  throw 
}