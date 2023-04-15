# 爱收藏 - 简介
- 一个用于收藏网址的平台
- 采用微服务架构，前后端分离
- docker一键部署
## 展示
#### 主页
<img decoding="async" src="https://raw.githubusercontent.com/leanfish2011/ishou-resource/gh-pages/img/home.jpg" width="80%">

#### 后台管理
<img decoding="async" src="https://raw.githubusercontent.com/leanfish2011/ishou-resource/gh-pages/img/manage.jpg" width="80%">

## 设计
#### 架构设计
<img decoding="async" src="https://img2022.cnblogs.com/blog/319088/202209/319088-20220924150239657-532536027.png" width="80%">

## 代码
|  服务   | 代码  | 备注  |
|  ----  | ----  | ----  |
| 前端界面  | [ishou-web](https://github.com/leanfish2011/ishou-web) | 界面展示 |
| 注册中心  | [eureka_server](https://github.com/leanfish2011/eureka_server) | 用于服务注册发现 |
| 权限中心  | [auth](https://github.com/leanfish2011/auth) | 用户注册登录等管理功能 |
| 网站发布  | [ishou-service-site](https://github.com/leanfish2011/ishou-service-site) | 网址发布等功能管理 |
| 系统管理  | [ishou-service-system](https://github.com/leanfish2011/ishou-service-system) | 系统全局功能管理 |
| 公共后端  | [spring-dev-parent](https://github.com/leanfish2011/spring-dev-parent) | 后端开发公共服务 |
| 资料管理  | [ishou-resource](https://github.com/leanfish2011/ishou-resource) | 系统资料 |
| 留言板  | [ishou_message](https://github.com/leanfish2011/ishou_message) | 用github issues功能实现的留言板 |

## 部署
> 一键部署
#### 部署说明：
1. 服务器安装好ubuntu操作系统
2. 服务器安装好docker。命令：sudo apt-get update && sudo apt install docker.io
3. 拷贝ishou_deploy.sh、镜像tar包到服务器（镜像tar包较大，另外存储，联系我获取，leanfish2011@163.com）
4. 服务器上执行./ishou_deploy.sh
5. 浏览器输入 http://ip 访问系统
6. 浏览器输入 http://ip:9000 访问镜像管理界面
