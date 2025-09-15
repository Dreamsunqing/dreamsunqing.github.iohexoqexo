---
abbrlink: ''
categonies: null
categories: []
date: '2025-07-12T12:05:53.147885+08:00'
tags: []
title: 记一次安装 mongoDB
updated: '2025-09-15T12:05:53.349+08:00'
---
**日期**: 2025年7月12日  

> **主题**: Ubuntu系统下MongoDB安装过程记录

<!--more-->

## 安装过程

### 方法一：直接安装（失败）

1. **尝试直接安装**

   ```
   sudo apt install mongodb-org-server
   ```

**结果**: 找不到包

### 方法二：使用官方仓库安装

#### 1. 导入密钥

```bash

wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

```

#### 2. 添加存储库

```bash

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

```

#### 3. 更新包列表

```bash

sudo apt update

```

#### 4. 安装MongoDB

```bash

sudo apt install mongodb-org-server

```

## 遇到的问题

### 错误信息

```

!err: libssl>=1.1.1

这个包版本需要大于1.1.1

```

> **说明**: libssl包是OpenSSL库的安全套接字层实现，MongoDB需要特定版本的libssl支持

## 解决方案

### 1. 尝试直接安装libssl

```bash

sudo apt install libssl

```

**结果**: 错误，没找到

### 2. 尝试修复依赖

```bash

sudo apt -fix-broken install

```

**结果**: 未找到冲突

### 3. 查找解决方案

- **参考**: [Packages for Linux and Unix - pkgs.org](https://pkgs.org/)
- **方案**: 手动下载libssl1.1.1包

#### 下载链接

- **ARM64架构**: http://ftp.de.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_arm64.deb
- **AMD64架构**: http://ftp.de.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb

#### 安装步骤

```bash

# 下载包（根据架构选择）

sudo wget "http://ftp.de.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb"

  

# 安装包

sudo dpkg -i libssl1.1_1.1.1w-0+deb11u1_amd64.deb

```

### 4. 重新安装MongoDB

```bash

sudo apt install mongodb-org-server

```

**结果**: 安装成功！

## 经验总结

> **重要提醒**: 在下载依赖包时，一定要注意选择正确的架构版本

> - 如果机器是AMD64架构，不要下载ARM64的包

> - 可以通过 `uname -m` 命令查看系统架构

> - 错误信息会提示"您的机器是amd64，无法使用arm64的包"

## 安装截图

> 后续添加

![MongoDB安装成功截图](Pasted%20image%2020250712223246.png)

---

## 技术要点

### libssl包说明

- **作用**: 提供SSL/TLS加密支持
- **版本要求**: MongoDB需要libssl>=1.1.1
- **架构匹配**: 必须与系统架构一致

### 安装流程总结

1. 添加MongoDB官方仓库
2. 导入GPG密钥
3. 更新包列表
4. 解决依赖问题（libssl）
5. 安装MongoDB服务

### 常见问题

- **包找不到**: 需要添加官方仓库
- **依赖冲突**: 需要手动安装特定版本的依赖包
- **架构不匹配**: 确保下载的包与系统架构一致
