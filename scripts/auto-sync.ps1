# ============================================================
# auto-sync.ps1 — YJWOO Life 자동 Git 동기화
# 파일 변경 감지 → 자동 commit + push
# ============================================================

param(
    [string]$VaultPath   = "C:\Claude\YJWOO Life",
    [int]   $DebounceMs  = 5000,   # 변경 후 대기 시간 (ms) — 연속 저장 묶음 처리
    [string]$CommitMsg   = "auto: sync {datetime}"
)

# ── 초기 확인 ──────────────────────────────────────────────
if (-not (Test-Path "$VaultPath\.git")) {
    Write-Host "❌ Git 저장소가 없습니다: $VaultPath" -ForegroundColor Red
    Write-Host "   먼저 git init 후 remote를 설정하세요." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   cd `"$VaultPath`"" -ForegroundColor Cyan
    Write-Host "   git init" -ForegroundColor Cyan
    Write-Host "   git remote add origin [GitHub URL]" -ForegroundColor Cyan
    exit 1
}

Write-Host "✅ 자동 동기화 시작" -ForegroundColor Green
Write-Host "   감시 경로 : $VaultPath" -ForegroundColor Cyan
Write-Host "   대기 시간 : $DebounceMs ms" -ForegroundColor Cyan
Write-Host "   중지      : Ctrl+C" -ForegroundColor Gray
Write-Host ""

# ── FileSystemWatcher 설정 ──────────────────────────────────
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path                  = $VaultPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents   = $true
$watcher.NotifyFilter          = [System.IO.NotifyFilters]::LastWrite `
                               -bor [System.IO.NotifyFilters]::FileName `
                               -bor [System.IO.NotifyFilters]::DirectoryName

# 무시할 경로 패턴 (.git, .obsidian 내부 변경은 무시)
$ignorePatterns = @('\.git\\', '\.obsidian\\', '\.tmp$', '~$')

# ── 디바운스 타이머 ─────────────────────────────────────────
$timer = New-Object System.Timers.Timer
$timer.Interval   = $DebounceMs
$timer.AutoReset  = $false

# ── Git Push 함수 ───────────────────────────────────────────
function Invoke-GitSync {
    $dt  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $msg = $CommitMsg -replace '\{datetime\}', $dt

    Push-Location $VaultPath
    try {
        $status = git status --porcelain 2>&1
        if (-not $status) {
            Write-Host "[$dt] ℹ️  변경 없음 (이미 최신)" -ForegroundColor Gray
            return
        }

        Write-Host "[$dt] 📦 변경 감지 → commit + push 시작" -ForegroundColor Yellow

        git add -A 2>&1 | Out-Null

        $commitResult = git commit -m $msg 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[$dt] ⚠️  commit 실패: $commitResult" -ForegroundColor Red
            return
        }

        $pushResult = git push 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[$dt] ⚠️  push 실패: $pushResult" -ForegroundColor Red
            Write-Host "         → 원격 저장소 연결을 확인하세요" -ForegroundColor Gray
            return
        }

        Write-Host "[$dt] ✅ Push 완료: $msg" -ForegroundColor Green
    }
    finally {
        Pop-Location
    }
}

# ── 타이머 Elapsed → Git 실행 ───────────────────────────────
Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {
    Invoke-GitSync
} | Out-Null

# ── 파일 변경 이벤트 → 타이머 리셋 ────────────────────────
$onChange = {
    $path = $Event.SourceEventArgs.FullPath

    # 무시 패턴 체크
    foreach ($pattern in $ignorePatterns) {
        if ($path -match $pattern) { return }
    }

    # 타이머 리셋 (디바운스)
    $timer.Stop()
    $timer.Start()
}

Register-ObjectEvent -InputObject $watcher -EventName Changed -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Created -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Deleted -Action $onChange | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName Renamed -Action $onChange | Out-Null

# ── 실행 루프 ───────────────────────────────────────────────
try {
    while ($true) {
        Wait-Event -Timeout 1
        [System.GC]::Collect()   # 메모리 정리
    }
}
finally {
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
    $timer.Dispose()
    Write-Host ""
    Write-Host "🛑 자동 동기화 중지됨" -ForegroundColor Gray
}
