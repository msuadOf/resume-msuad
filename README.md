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

仓库根目录的 `index.html` 是默认英文主页，`zh/index.html` 是中文版。两页共用 `styles.css`，通过页面顶部的语言链接切换，无需构建工具或 JavaScript。页面公开邮箱和 GitHub 账号，没有展示简历里的电话和出生日期。页面的信息结构参考了 [Leonid Keselman 的个人主页](https://github.com/leonidk/leonidk.github.io)，样式和内容在本仓库中独立实现。

本地预览：在仓库目录运行 `python3 -m http.server 8000`，然后打开 `http://localhost:8000/`。

公开版本位于 [msuadOf/personal-homepage](https://github.com/msuadOf/personal-homepage)。当前 GitHub 方案不支持从本私有仓库直接启用 Pages；更新网页时，将 `index.html`、`styles.css` 和 `zh/index.html` 同步到该公开仓库并推送 `main`，GitHub Pages 会从公开仓库根目录发布。简历 PDF 和 LaTeX 源文件不在公开仓库中。
