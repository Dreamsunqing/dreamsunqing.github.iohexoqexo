---
abbrlink: ''
categonies: null
categories: []
date: '2025-04-15T12:38:32.553923+08:00'
tags:
- Docker
title: window 下 docker 开机自启 指定容器
updated: '2025-09-15T12:38:32.836+08:00'
---
window 下 docker 开机自启 指定容器

需要docker desktop

<!--more-->

# 正确的重启策略选项：

- `no`：默认值，不自动重启容器。
- `on-failure`：仅在容器退出状态码非0时重启。
- `always`：无论退出状态如何，总是重启容器。
- `unless-stopped`：总是重启容器，除非容器被手动停止。
  修改现有容器的重启策略
  你可以使用 `docker update` 命令来修改现有容器的重启策略。假设你的容器ID为 `ef072d62e58c49063c7eb0a2fbd9040d9caea3d22901d12f493191b9b0880145`，你可以使用以下命令将其重启策略设置为 `always`：

```bash
docker update --restart=always ef072d62e58c49063c7eb0a2fbd9040d9caea3d22901d12f493191b9b0880145
```

完整配置流程

1. 确保Docker Desktop开机自启：
   - 打开Docker Desktop。
   - 进入 `Settings` -> `General`。
   - 勾选 `Start Docker Desktop when you log in` 选项。
2. 修改容器的重启策略：
   - 使用 `docker update` 命令将容器的重启策略设置为 `always`。
     ```bash
     docker update --restart=always ef072d62e58c49063c7eb0a2fbd9040d9caea3d22901d12f493191b9b0880145
     ```
3. 验证重启策略：
   - 你可以通过以下命令查看容器的详细信息，确认重启策略是否已更改：
     ```bash
     docker inspect ef072d62e58c49063c7eb0a2fbd9040d9caea3d22901d12f493191b9b0880145 | grep RestartPolicy
     ```
   - 你应该能看到类似以下的输出：
     ```json
     "RestartPolicy": {
         "Name": "always",
         "MaximumRetryCount": 0
     }
     ```

通过以上步骤，你可以确保指定的容器在Windows系统启动时自动启动，并且始终处于运行状态。
