# ============================================================
# git-init-setup.ps1 — 최초 1회 실행: Git 저장소 초기화
# ============================================================

$VaultPath = "C:\Claude\YJWOO Life"
$RemoteUrl = "https://github.com/yjwoo59/yjwoo-life.git"

Write-Host ""
Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   YJWOO Life Git 초기화              ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Push-Location $VaultPath

# .gitignore 생성
$gitignore = @"
# Obsidian
.obsidian/workspace.json
.obsidian/cache

# Windows
Thumbs.db
desktop.ini

# 임시 파일
*.tmp
~$*
"@

if (-not (Test-Path ".gitignore")) {
    $gitignore | Out-File -Encoding UTF8 ".gitignore"
    Write-Host "✅ .gitignore 생성" -ForegroundColor Green
}

# Git 초기화
if (-not (Test-Path ".git")) {
    git init
    Write-Host "✅ git init 완료" -ForegroundColor Green
} else {
    Write-Host "ℹ️  이미 Git 저장소입니다" -ForegroundColor Gray
}

# Remote 설정
$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    git remote set-url origin $RemoteUrl
    Write-Host "✅ Remote URL 업데이트: $RemoteUrl" -ForegroundColor Green
} else {
    git remote add origin $RemoteUrl
    Write-Host "✅ Remote 추가: $RemoteUrl" -ForegroundColor Green
}

# 브랜치 이름 main으로 설정
git branch -M main

# 최초 커밋
$status = git status --porcelain
if ($status) {
    git add -A
    git commit -m "init: YJWOO Life harness setup"
    Write-Host "✅ 최초 커밋 완료" -ForegroundColor Green
}

# Push
Write-Host ""
Write-Host "GitHub에 push합니다..." -ForegroundColor Yellow
git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 완료! GitHub에 업로드됐습니다." -ForegroundColor Green
    Write-Host ""
    Write-Host "이제 scripts\start-sync.bat 을 실행하면 자동 동기화가 시작됩니다." -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠️  Push 실패. GitHub 로그인 상태를 확인하세요." -ForegroundColor Red
    Write-Host "   → git credential manager 또는 GitHub CLI 로그인 필요" -ForegroundColor Yellow
}

Pop-Location
Write-Host ""
pause
