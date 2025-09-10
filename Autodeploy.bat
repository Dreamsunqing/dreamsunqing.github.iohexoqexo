@echo off
:: 强制使用UTF-8无BOM编码（需用记事本另存为时选择）
chcp 65001

echo 🚀 开始执行部署流程...
echo 当前目录: %cd%
echo 当前时间: %date% %time%

git pull origin main --force & hexo clean & hexo g & hexo deploy & echo Deploy Success! & pause

