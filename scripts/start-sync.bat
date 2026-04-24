@echo off
chcp 65001 >nul
title YJWOO Life — Auto Git Sync

echo.
echo  ╔══════════════════════════════════════╗
echo  ║   YJWOO Life  Auto Git Sync          ║
echo  ║   파일 변경 시 자동 commit + push    ║
echo  ╚══════════════════════════════════════╝
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0auto-sync.ps1"

echo.
pause
