# Contributing to sk

感谢你想为本项目做出贡献！请按下面步骤来配置本地开发环境并提交变更。

1) 先决条件
- Git
- Node.js >= 18
- npm 或 pnpm
- 可选：Docker

2) 克隆仓库
```bash
git clone https://github.com/sk18168890826/sk.git
cd sk
``` 

3) 安装依赖（示例：Node.js）
```bash
npm install
```

4) 配置环境变量
- 复制模板：
```bash
cp .env.example .env
```
- 根据需要修改 .env

5) 启动开发服务器
```bash
npm run dev
```

6) 运行测试 & lint
```bash
npm test
npm run lint
```

7) 提交与 PR 规范
- 创建分支：`feature/描述` 或 `fix/描述`
- 编写清晰的 commit message（首行 50 字内）
- 提交并在 GitHub 上发 PR，描述变更目的与影响
- 关联 issue（如适用）

感谢你的贡献！如果遇到问题，请在 issue 中描述复现步骤与错误信息。
