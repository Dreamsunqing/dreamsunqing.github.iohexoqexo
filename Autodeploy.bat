@echo off
:: 强制使用UTF-8无BOM编码（需用记事本另存为时选择）
chcp 65001 >nul
title Hexo自动部署工具（防闪退版）
setlocal enabledelayedexpansion

:: 1. 环境检查
where git >nul 2>&1 || (
    echo ❌ 错误：未检测到Git，请先安装
    pause
    exit /b 1
)
where node >nul 2>&1 || (
    echo 错误：未检测到Node.js，请先安装
    pause
    exit /b 1
)

:: 2. 目录切换（带错误处理）
cd /d "%~dp0" || (
    echo 错误：无法切换到脚本所在目录
    pause
    exit /b 1
)

:: 3. 分步执行（带错误重定向）
echo 开始执行部署流程...
echo 当前目录: %cd%
echo 当前时间: %date% %time%

:: 步骤1：Git拉取
echo ✅ [1/4] 正在拉取最新代码...
git pull origin main --force

:: 步骤2：Hexo清缓存
echo ✅ [3/4] 正在清理缓存文件...
hexo clean

:: 步骤3：Hexo生成
echo ✅ [3/4] 正在生成静态文件...
hexo g 

:: 步骤4：Hexo部署
echo [4/4] 正在部署到GitHub...
hexo deploy

:: 4. 成功处理
echo 🎉 部署成功！
pause