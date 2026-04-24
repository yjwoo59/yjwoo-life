param(
    [string]$VaultPath  = "C:\Claude\YJWOO Life",
    [int]   $DebounceMs = 5000,
    [string]$CommitMsg  = "auto: sync {datetime}"
)

if (-not (Test-Path "$VaultPath\.git")) {
    Write-Host "No git repository found: $VaultPath" -ForegroundColor Red
    exit 1
}

Write-Host "Auto-sync started" -ForegroundColor Green
Write-Host "Path   : $VaultPath" -ForegroundColor Cyan
Write-Host "Delay  : $DebounceMs ms" -ForegroundColor Cyan
Write-Host "Stop   : Ctrl+C" -ForegroundColor Gray
Write-Host ""

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path                  = $VaultPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents   = $true
$watcher.NotifyFilter          = [System.IO.NotifyFilters]::LastWrite `
                               -bor [System.IO.NotifyFilters]::FileName `
                               -bor [System.IO.NotifyFilters]::DirectoryName

$ignorePatterns = @('\.git\\', '\.obsidian\\', '\.tmp$', '~\$')

$timer           = New-Object System.Timers.Timer
$timer.Interval  = $DebounceMs
$timer.AutoReset = $false

function Invoke-GitSync {
    $dt  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $msg = $CommitMsg -replace '\{datetime\}', $dt

    Push-Location $VaultPath
    try {
        $status = git status --porcelain 2>&1
        if (-not $status) {
            Write-Host "[$dt] No changes" -ForegroundColor Gray
            return
        }

        Write-Host "[$dt] Changes detected - committing..." -ForegroundColor Yellow

        git add -A 2>&1 | Out-Null

        git commit -m $msg 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[$dt] Commit failed" -ForegroundColor Red
            return
        }

        git push 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[$dt] Push failed - check network" -ForegroundColor Red
            return
        }

        Write-Host "[$dt] Push OK: $msg" -ForegroundColor Green
    }
    finally {
        Pop-Location
    }
}

Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {
    Invoke-GitSync
} | Out-Null

$onChange = {
    $path = $Event.SourceEventArgs.FullPath
    foreach ($pattern in $ignorePatterns) {
        if ($path -match $pattern) { return }
    }
    $timer.Stop()
    $timer.Start()
}

Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Created -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Deleted -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $onChange | Out-Null

try {
    while ($true) {
        Wait-Event -Timeout 1
        [System.GC]::Collect()
    }
}
finally {
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
    $timer.Dispose()
    Write-Host "Auto-sync stopped" -ForegroundColor Gray
}
