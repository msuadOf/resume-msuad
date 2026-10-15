# 中文个人简历

基于 [kody1126/Chinese-resume-template-work](https://github.com/kody1126/Chinese-resume-template-work) 定制，保留原项目 MIT 许可证。

## 四种简历

版本名为 `resume-{frontier|general}-{arch|full}`，两个维度独立选择：

| 维度 | 选项 | 内容 |
| --- | --- | --- |
| 表达侧重 | `frontier` | 保留体系结构、RTL、ISA、虚拟化和软硬件协同的技术细节 |
| 表达侧重 | `general` | 用更通用的语言说明职责、开发工作和阶段成果 |
| 经历范围 | `arch` | 现有体系结构相关经历：开源芯片研究院、NACRE、CPU Fuzzing、一生一芯、存储控制器及 JPEG-LS IP |
| 经历范围 | `full` | 在 arch 的基础上，参考原始 Word 资料补回电力电子电赛、Cortex-M0 无线 SoC、电磁循迹小车、校园经历，以及单片机和 PCB 技能 |

四个版本共用自动单页排版：先测量正文高度，在 10–11pt 字号和 11.5–16.04pt 行距范围内选取能放入一页的最大设置，再把剩余高度均匀分配到栏目间。字号和行距上限不超过 Git 历史中的 11pt 正文及 1.18 倍行距，文字不会被拉伸。两种表达侧重使用相同的事实范围。

缩放范围在 `tex/resume.tex` 中通过 `resumeminfontsize`、`resumemaxfontsize`、`resumeminbaseline`、`resumemaxbaseline` 调整；也可在入口文件引用共享模板前用 `\def` 覆盖。程序将字号上限限制为 11pt、行距上限限制为 16.04pt；如果最低设置仍放不下，会报告错误，避免静默溢出或生成多余页面。姓名独立使用 32pt 字号，在页眉左侧区域居中。

## TeX 复用结构

```text
resume-frontier-arch.tex  ┐
resume-frontier-full.tex  ├─ 设置 resumeaudience / resumescope
resume-general-arch.tex  │
resume-general-full.tex  ┘
    └─ tex/resume.tex              版本判断、章节顺序、条件纳入与分页
        ├─ tex/preamble.tex        共享字体、颜色、页边距和排版命令
        └─ tex/content/*.tex       按经历拆分的正文
```

四个入口文件只设置两个选项并通过 `\input` 引用共享模板，不复制正文。`tex/content/profile.tex` 统一维护个人信息和教育背景；其他文件按实习、科研、具体项目、校园经历和技能拆分。某条经历需要不同措辞时，在同一内容文件内使用 `\ifresumefrontier ... \else ... \fi`。完整经历与技能补充通过 `\ifresumefull` 控制。

修改某条经历只需编辑对应的内容文件；修改章节顺序或分页只需编辑 `tex/resume.tex`；修改字体、颜色或边距只需编辑 `tex/preamble.tex`。

## 构建

安装 MacTeX 或包含 XeLaTeX 的 TeX Live 后，在仓库目录执行：

```bash
./build.sh                        # 编译四种版本
./build.sh resume-frontier-arch    # 只编译一个版本
./build.sh resume-general-full
```

脚本对每个版本编译两遍，在仓库根目录生成同名 PDF，成功后清理中间文件，失败时保留日志。也可以在仓库根目录直接运行 `xelatex resume-frontier-arch.tex` 等命令。

编辑时可启动自动监听，无需安装额外工具：

```bash
./watch.sh                        # 监听修改并更新全部版本
./watch.sh resume-frontier-full   # 只更新指定版本
```

监听脚本启动时先编译一次，之后每秒检查 TeX 源文件、字体和 `build.sh` 的内容变化，合并短时间内的连续保存后重新编译。新增或删除源文件也会触发更新；生成的 PDF 和日志不会触发循环编译。编译失败时继续监听，修正并保存后自动重试；编译过程中保存的修改会在本次编译结束后再次触发更新。按 `Ctrl+C` 停止。两个脚本均可从其他目录通过路径启动。

主页下载链接直接使用 `resume-frontier-arch.pdf`。旧的 `work-resume-frontier.tex` 和 `work-resume-general.tex` 分别指向对应的 arch 版，也不再维护独立正文。

字体随项目放在 `fonts/` 中，所有平台按同一文件路径加载，不再使用系统字体或自动回退。中文使用 Fandol 宋体、黑体与楷体；西文使用 TeX Gyre Termes、Heros 和 Cursor。复制整个项目到 macOS、Linux、Windows 或 Overleaf 后，使用 XeLaTeX 构建即可，无需额外安装字体。字体文件、原始许可、校验值与来源见 [fonts/README.md](fonts/README.md)。

字体固定后，字形、字宽与中文字距不再随系统变化；若需要严格复现排版，还应统一 TeX Live/XeLaTeX 和宏包版本。不同构建的 PDF 时间戳等元数据仍可能不同，因此这里保证的是统一字体输入，并不保证 PDF 文件逐字节相同。

`source-resume.docx` 是原始资料，仅本地保留，已忽略。临时文件与配色预览不纳入版本管理。本仓库公开，简历 PDF 和源文件中的个人联系方式也随之公开。

## 个人主页（GitHub Pages）

仓库根目录的 `index.html` 是默认英文主页，`zh/index.html` 是中文版。两页共用 `styles.css`，通过页面顶部的语言链接切换，无需构建工具或 JavaScript。页面公开邮箱和 GitHub 账号，没有展示简历里的电话和出生日期。页面的信息结构参考了 [Leonid Keselman 的个人主页](https://github.com/leonidk/leonidk.github.io)，样式和内容在本仓库中独立实现。

本地预览：在仓库目录运行 `python3 -m http.server 8000`，然后打开 `http://localhost:8000/`。

推送到 `main` 后，GitHub Actions 会使用 XeLaTeX 编译四种简历，再将英文主页、中文主页和新生成的 PDF 一起发布到 GitHub Pages：[英文主页](https://blog.msuad.top/resume-msuad/)和[中文主页](https://blog.msuad.top/resume-msuad/zh/)。两个主页顶部都提供 PDF 下载链接。也可以在 Actions 中手动运行部署流程。

仓库中的四份 PDF 是便于直接查看的本地编译版本；线上下载文件以 Actions 在部署时从对应 TeX 入口编译的结果为准。发布流程需要将仓库的 Pages 构建来源设为 GitHub Actions。
