# 中文个人简历

基于 [kody1126/Chinese-resume-template-work](https://github.com/kody1126/Chinese-resume-template-work) 定制，保留原项目 MIT 许可证。

## 构建

安装 MacTeX 或包含 XeLaTeX 的 TeX Live 后，在仓库目录执行 `./build.sh`。

脚本编译两遍，生成 `work-resume.pdf`，成功后清理中间文件；失败时保留日志。

## 文件与版本管理

- `work-resume.tex`：正文与排版配置。
- `work-resume.pdf`：最新编译结果，与源文件一起提交。
- `build.sh`：构建脚本。
- `fonts/`：可选自定义字体目录。
- `source-resume.docx`：原始资料，仅本地保留，已忽略。

字体默认使用 macOS 华文系列与 Times New Roman；其他环境需安装源文件指定的 Noto CJK 字体，或提供已授权的自定义字体。

临时文件与配色预览不纳入版本管理。仓库包含个人联系方式，建议使用私有远程仓库。

## 个人主页（GitHub Pages）

仓库根目录的 `index.html` 是默认英文主页，`zh/index.html` 是中文版。两页共用 `styles.css`，通过页面顶部的语言链接切换，无需构建工具或 JavaScript。页面公开邮箱和 GitHub 账号，没有展示简历里的电话和出生日期；部署流程只会上传这三个网页文件，不会上传简历 PDF 或源文件。页面的信息结构参考了 [Leonid Keselman 的个人主页](https://github.com/leonidk/leonidk.github.io)，样式和内容在本仓库中独立实现。

本地预览：在仓库目录运行 `python3 -m http.server 8000`，然后打开 `http://localhost:8000/`。

发布到 GitHub Pages：

1. 将本次网页文件和 `.github/workflows/pages.yml` 提交并推送到 `main`。
2. 在 GitHub 仓库的 **Settings → Pages → Build and deployment** 中，将 **Source** 设为 **GitHub Actions**。
3. 工作流完成后，页面地址通常是 `https://msuadof.github.io/resume-msuad/`。如仓库名或账号发生变化，以 Pages 设置页显示的地址为准。

GitHub Pages 网站始终面向互联网公开，即使仓库本身是私有的。发布前可按需调整网页中的项目表述和公开邮箱。
