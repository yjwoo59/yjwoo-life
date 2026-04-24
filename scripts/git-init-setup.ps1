# ============================================================
# git-init-setup.ps1 — 최초 1회 실행: Git 저장소 초기화
# ============================================================

$VaultPath = "C:\Claude\YJWOO Life"
$RemoteUrl = "https://yjwoo59@github.com/yjwoo59/yjwoo-life.git"

Write-Host ""
Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   YJWOO Life Git 초기화              ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Push-Location $VaultPath

# Remote URL 업데이트
git remote set-url origin $RemoteUrl
Write-Host "✅ Remote URL 설정: $RemoteUrl" -ForegroundColor Green

# 브랜치 이름 main으로 설정
git branch -M main

# Push
Write-Host ""
Write-Host "GitHub에 push합니다 (yjwoo59 계정으로 로그인 필요)..." -ForegroundColor Yellow
git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 완료! GitHub에 업로드됐습니다." -ForegroundColor Green
    Write-Host "이제 scripts\start-sync.bat 을 실행하면 자동 동기화가 시작됩니다." -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠️  Push 실패. 위 오류 메시지를 확인하세요." -ForegroundColor Red
}

Pop-Location
Write-Host ""
pause
