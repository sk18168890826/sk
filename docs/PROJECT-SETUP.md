# 项目本地开发环境搭建（Node.js 示例）

本文件描述如何在本地准备和运行本项目（基于 Node.js）。更多贡献流程请参阅仓库根目录的 CONTRIBUTING.md。

先决条件
- Git
- Node.js >= 18（检查 node -v）
- npm 或 pnpm（示例使用 npm）
- 可选：Docker

获取代码
```bash
git clone https://github.com/sk18168890826/sk.git
cd sk
``` 

切换到开发分支（可选，如果你已经在 feature/add-project-setup 分支则跳过）
```bash
git checkout feature/add-project-setup
```

安装依赖
```bash
npm ci    # CI/干净安装
# 或
npm install
```

环境变量
```bash
cp .env.example .env
# 编辑 .env 填入实际值
```

常用命令（根据 package.json scripts 或 Makefile）
- 启动开发服务器（热重载）：npm run dev
- 构建：npm run build
- 运行测试：npm test
- 运行 lint：npm run lint

数据库 & 迁移（如适用）
如果项目使用数据库，请参考项目具体的迁移命令，例如：

```bash
npm run migrate
```

Docker（可选）
- 使用 Docker 运行开发环境可以保证一致性，通常需提供 Dockerfile 与 docker-compose.yml。

故障排查
- 依赖安装失败：删除 node_modules 和 package-lock.json 后重试。
- 启动错误：检查 .env 中必需变量是否已配置。

更多细节请阅读 CONTRIBUTING.md 中的快速上手节与仓库根 README。
