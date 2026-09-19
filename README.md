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
