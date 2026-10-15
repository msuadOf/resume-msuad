# 中文个人简历

基于 [kody1126/Chinese-resume-template-work](https://github.com/kody1126/Chinese-resume-template-work) 定制，保留原项目 MIT 许可证。

## 四种简历

版本名为 `resume-{frontier|general}-{arch|full}`，两个维度独立选择：

| 维度 | 选项 | 内容 |
| --- | --- | --- |
| 投递对象与表达侧重 | `frontier` | 面向大厂、私企的技术岗位；突出技术能力，保留体系结构、RTL、ISA、虚拟化和软硬件协同等实现细节 |
| 投递对象与表达侧重 | `general` | 面向国企、其他行业公司的投递场景；减少专业术语和实现细节，突出个人职责、完成的工作与具体成果 |
| 经历范围 | `arch` | 体系结构相关经历：开源芯片研究院、NACRE、CPU Fuzzing、QEMU 训练营、一生一芯，以及集成电路竞赛中的存储控制器、JPEG-LS IP 和 Cortex-M0 无线 SoC |
| 经历范围 | `full` | 在 arch 的基础上，补充电力电子电赛、电磁循迹小车、校园经历，以及单片机和 PCB 等技能 |

版本选择示例：向大厂或私企投递处理器、体系结构等技术岗位时使用 `frontier-arch`；需要展示更完整的技术经历时使用 `frontier-full`。向国企或其他行业公司投递时，根据岗位相关性选择 `general-arch` 或 `general-full`。`arch/full` 决定展示哪些经历，`frontier/general` 决定如何表述，两个维度互不替代。

维护措辞时遵循以下原则：

- `frontier` 说明具体做了什么、采用哪些技术、如何验证以及取得什么结果；技术名词用于解释个人能力，避免只罗列工具和缩写。
- `general` 优先让读者理解工作目标、个人职责和完成情况，保留必要的技术关键词与可核实成果，减少型号、接口和实现机制的展开。
- 两种版本使用相同的事实与贡献边界，不能因压缩表述而把“参与”改成“独立完成”，也不能添加未经确认的指标或成果。适用对象是本项目的投递策略，实际技术深度仍应结合岗位要求判断。
- 公共技能与荣誉继续共用一套描述；经历中的措辞按需分支，电子与嵌入式补充技能等按 `arch/full` 控制。

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

四个入口文件只设置两个选项并通过 `\input` 引用共享模板，不复制正文。`tex/content/profile.tex` 统一维护个人信息和教育背景；其他文件按实习、科研、具体项目、校园经历和技能拆分。某条经历需要不同措辞时，在同一内容文件内使用 `\ifresumefrontier ... \else ... \fi`：前一分支面向大厂、私企，后一分支面向国企、其他行业公司。完整经历与技能补充通过 `\ifresumefull` 控制。

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

## 自动发布简历（GitHub Releases）

`.github/workflows/release-resume.yml` 在推送 `resume-*` 标签时自动编译四个版本的 PDF，并上传到同名 GitHub Release，保留各版本的下载记录。附件从该标签对应的源码重新编译，不直接使用仓库中已有的 PDF。

先提交并推送需要发布的简历内容和工作流，再创建版本标签：

```bash
git tag -a resume-2026.10.15 -m "简历 2026.10.15"
git push origin resume-2026.10.15
```

同一天需要再次留档时可使用新标签，例如 `resume-2026.10.15-2`。

也可以在 GitHub 仓库的 **Actions → Release résumé PDFs → Run workflow** 中手动发布：选择分支并填写 `resume-` 开头的 `tag`。如果标签已经存在，编译该标签对应的提交；如果标签不存在，编译所选分支在触发时的提交，并在成功发布时创建标签。手动触发入口需要先将工作流推送到默认分支。

Release 附带四个 PDF：`resume-frontier-arch.pdf`、`resume-frontier-full.pdf`、`resume-general-arch.pdf`、`resume-general-full.pdf`。重跑同一标签时更新同名附件，不创建重复 Release；只有四份 PDF 均成功生成后才执行发布。流程使用 GitHub 自动提供的 `GITHUB_TOKEN`，不需要额外配置个人访问令牌。

发布结果见 [GitHub Releases](https://github.com/msuadOf/resume-msuad/releases)。普通 `main` 分支推送继续只更新 Pages；发布带版本号的 Release 使用标签或手动触发。

## 个人主页（GitHub Pages）

仓库根目录的 `index.html` 是默认英文主页，`zh/index.html` 是中文版。两页共用 `styles.css`，通过页面顶部的语言链接切换，无需构建工具或 JavaScript。页面公开邮箱和 GitHub 账号，没有展示简历里的电话和出生日期。页面的信息结构参考了 [Leonid Keselman 的个人主页](https://github.com/leonidk/leonidk.github.io)，样式和内容在本仓库中独立实现。

本地预览：在仓库目录运行 `python3 -m http.server 8000`，然后打开 `http://localhost:8000/`。

推送到 `main` 后，GitHub Actions 会使用 XeLaTeX 编译四种简历，再将英文主页、中文主页和新生成的 PDF 一起发布到 GitHub Pages：[英文主页](https://blog.msuad.top/resume-msuad/)和[中文主页](https://blog.msuad.top/resume-msuad/zh/)。两个主页顶部都提供 PDF 下载链接。也可以在 Actions 中手动运行部署流程。

仓库中的四份 PDF 是便于直接查看的本地编译版本；线上下载文件以 Actions 在部署时从对应 TeX 入口编译的结果为准。发布流程需要将仓库的 Pages 构建来源设为 GitHub Actions。
