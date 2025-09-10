---
title: (备忘) Hexo+Next 配置
date: 2025-09-08 20:00:59
tags: 
    - Hexo
    - Next
categonies:
    - 备忘
---

这是第N次配置 Hexo 了,轻车熟路,知道自己要干什么,记录一下,以备不时之需。

<!--more-->
## 依赖软件

### 1. Nodejs

### 2. Git

## Hexo

### 安装

```bash
# 安装 Hexo 工具
npm install hexo-cli -g
# 找个空白文件夹
hexo init blog
# 进入 blog 文件夹
cd bolg
# 初始化，安装依赖
npm install
```
### 命令

```bash
# 开始写作
hexo new 文章名
# 生成静态文件
hexo generate
# 启动服务器（本地可用于预览）
hexo serve
```
### Hexo 配置 (根目录下 `_config.yml` )

- 主要用于个性化配置，
- 参考: [配置 | Hexo](https://hexo.io/zh-cn/docs/configuration)

## Next 主题

NexT：
- [next-theme/hexo-theme-next: 🎉 Elegant and powerful theme for Hexo.](https://github.com/next-theme/hexo-theme-next)
应用主题步骤（Hexo > 5.0）
```bash
# 进入 blog 文件夹
cd bolg
# 下载主题
git clone https://github.com/next-theme/hexo-theme-next themes/next
```
### 个性化 Next 配置 (以根目录下 `_config.next.yml` 为主)
```bash
# 为防止冲突覆盖，不建议直接修改配置文件，接下来的修改都在 _config.next.yml
cp themes/next/_config.yml _config.next.yml
```
- 配置参考: [Getting Started | NexT](https://theme-next.js.org/docs/getting-started/)
安装完成后，修改 `_config.yml` 内的 `theme` 设定为 next，即可应用主题。

>Tips: 
> Hexo 和 Next 提供的定制化已经满足需求,目前并未引入其他外部插件。
> 调整样式,读起来舒服就行。