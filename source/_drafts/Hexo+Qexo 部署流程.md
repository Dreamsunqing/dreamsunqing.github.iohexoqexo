---
abbrlink: ''
categonies: null
categories: []
date: '2025-09-15T09:23:26.860066+08:00'
tags: []
title: Hexo + Qexo 个人网站 部署流程
updated: '2025-09-15T09:23:27.484+08:00'
---
# Hexo + Qexo 个人网站 部署流程

> **观前提示**：
> 完全没接触过的小白来说阅读起来会感觉比较吃力
> 需要掌握一些基础的技能，但用不到很深。
> 个人备忘使用
> 涉及到的知识有：
> Linux基础，Github操作，Git 版本控制，Nodejs以及npm包管理命令，Docker基础

这里提供思路，旨在简化Hexo命令操作，做到以后不用代码就可以更新网站

<!--more-->

## 第一部分 Hexo

### 1. 需要安装的东西#

这是一些**必备**的东西：

1. Nodejs
   - 不仅仅是一个运行时
   - 好用的包管理工具
2. Hexo 文档
   - 官网：[Hexo](https://hexo.io/zh-cn/)
   - 文档：[文档 | Hexo](https://hexo.io/zh-cn/docs/)

### 2. 安装 Hexo

> 看到这里应该准备好上面的东西了，下面就不多说废话了
> 再提一句，文档是个好东西，打开就不用关了，随时查。

```shell
# 安装 Hexo 工具
npm install hexo-cli -g
# 找个合适的文件夹
hexo init blog
# 进入 blog 文件夹
cd bolg
# 初始化，安装依赖
npm install
# 启动服务
hexo server
```

不出意外，应该可以看到Hexo的Hello World页面了

#### 配置

> 小徐又重新啃了边文档，结合AI，中文注释了一份的 ‘\_config.yml’
> 暂时没想好如何展示

- 详情参考：
  - [配置 | Hexo](https://hexo.io/zh-cn/docs/configuration)

### 3. 主题

> 外观这方面见仁见智，小徐用的是 Next，同样啃了一边文档，中文注释一份 ‘\_config.next.yml’
> 官方预览兼文档：[NexT - Theme for Hexo](https://theme-next.js.org/)
> github链接：[next-theme/hexo-theme-next: 🎉 Elegant and powerful theme for Hexo.](https://github.com/next-theme/hexo-theme-next)

这里指路挑选主题页面：

- 主题：[Themes | Hexo](https://hexo.io/themes/)

## 第二部分 Qexo

### 1. 需要安装的东西

1. docker
   - 容器化平台
   - 解决了程序员”环境不一致“的世纪难题
2. Qexo
   - 官网文档：[Qexo 文档](https://oplog.cn/qexo/start.html)

### 2. 部署 Qexo

> 同样的看到这里，默认装好了Docker，用不到多少命令，倒是装上配好能运行，就超过相当一部分人了。

```shell
# 一键部署
docker run -d \
    --restart=unless-stopped \
    -v $(pwd)/db:/app/db \
    -p 8000:8000 \
    -e TIMEOUT=600 \
    --name="qexo" \
    abudulin/qexo:latest
```

如果一切正常，没有报错，那么此时打开 [这个页面](http://localhost:8000) 就可以看到 Qexo 的引导界面了

## 第三部分 部署并实现自动化

### 1. 需要准备的东西

1. Git
   - 版本管理
   - 附赠一个好用的类Linux命令行
2. Github 账号
   - 程序员必备
   - 世界最大的代码平台

### 2. 初始化 github 仓库

> 这里还是默认读者会 Github 基础操作，就不多说了，主要讲思路

#### 源码仓库 用于让 Qexo 识别并编辑

1. 创建新仓库，记住仓库名，后续会用。
   1. 用来让 Qexo 识别，为后续的自动化做准备

#### github page 仓库 真正的静态页面，用于访问

1. 创建新仓库，名称应该是：username.github.io
   1. 用来存放 hexo g 后的 public 文件，真正的页面

### 3. 流程研究

1. 上传仓库
   - Qexo 仓库
   - Hexo 仓库（username.github.io)
2. 初始化 Qexo
   - 根据 Qexo 提示，填写相关信息，来链接上Github仓库。
3. Hexo 安装 deploy 插件-[hexo-deployer-git](https://github.com/hexojs/hexo-deployer-git)。

```bash
 npm install hexo-deployer-git --save
```

4. 编辑 **_config.yml** （示例值如下所示）：

```bash
deploy:  
  type: git  
  repo: <repository url> # git@uname/uname.github.io  填写仓库名
  branch: [branch]  # 填写主分支名，一般是main
```

5. 此时一切已经配置完毕，不出意外的话，可以很大程度减少操作

```bash
# 推送到Github仓库
hexo deploy
```

### 4. 真正实现一键部署

> 复盘一下：
> 现在 Qexo 已经识别到 Github 仓库（线上Qexo），在 Qexo 编辑后，直接就更新仓库了。
> 接下来要用 hexo deploy 更新 （线上Hexo），可是Qexo编辑后本地仓库并没有更新，而 Hexo deploy 不能直接在线上仓库运行，所以需要设备中转。
> 那么思路就很清楚了。

1. Qexo 编辑 => 更新 github 线上仓库 （更新线上）
2. 最新仓库 => 拉取并合并到本地 （更新本地）
3. Hexo 命令推送
4. 编写脚本，并且设置定时任务（以后就可以直接无脑在Qexo中写文了）
   - 注意：脚本要一起上传到仓库，不然更新后，脚本就没有嘞。

```bat
echo 🚀 开始执行部署流程...
echo 当前目录: %cd%
echo 当前时间: %date% %time%

git pull origin main --force & hexo clean & hexo g & hexo deploy & echo Deploy Success! & pause
```

> 亲爱的：
> 感谢您能看到这里，如果你一步步跟到这里来，已经能感受到你对计算机相关知识深深的的热爱了，请坚持您的热爱！

## 第四部分 补充知识（ToDo：催更联系 dream_demo@outlook.com）

### 1. 踩过的坑

### 2. 自定义域名

### 3. Windows 设置定时任务，更新网站

### 4. Qexo 链接 本地 Hexo

### 5. 服务器部署并设置定时任务(真正的解放设备，随时随地任何设备访问写文，毕竟 Qexo 就是个网页嘛)
