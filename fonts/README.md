# 固定字体

本目录保存构建用的原始 OpenType 字体文件。`tex/preamble.tex` 显式按文件路径加载，不依赖操作系统安装的字体；缺失文件时构建报错，不会静默回退。上传 Overleaf 或复制项目时请保留整个目录。

| 用途 | 字体 | 文件 |
| --- | --- | --- |
| 中文正文 | Fandol Song | `FandolSong-Regular.otf` |
| 中文粗体、无衬线与等宽字体 | Fandol Hei | `FandolHei-Regular.otf`、`FandolHei-Bold.otf` |
| 中文斜体 | Fandol Kai | `FandolKai-Regular.otf` |
| 西文正文及数字 | TeX Gyre Termes | `texgyretermes-*.otf` |
| 西文无衬线字体 | TeX Gyre Heros | `texgyreheros-*.otf` |
| 西文等宽字体 | TeX Gyre Cursor | `texgyrecursor-*.otf` |

三个西文字体家族均包含常规、粗体、斜体和粗斜体。项目符号也使用西文字体中的字符，避免额外依赖数学字体。

字体从本机 TeX Live 2026 的 `texmf-dist/fonts/opentype/public/` 原样复制，未修改字体文件。Fandol 为 0.3 版；各 TeX Gyre 字体的版本和作者见 `licenses/README-TeX-Gyre-*.txt`。

Fandol 的原始 GPL 许可及字体例外、作者说明保存在 `licenses/Fandol-COPYING.txt` 与 `licenses/Fandol-README.txt`；TeX Gyre 的 GUST Font License、作者说明与清单也保存在 `licenses/`。字体遵循各自许可，不随项目代码改用 MIT 许可。

`SHA256SUMS` 记录每个字体文件的 SHA-256；可在本目录运行 `shasum -a 256 -c SHA256SUMS` 检查文件是否改变。更新字体时应同步更新许可、来源和校验值，并重新检查四份简历的排版。

统一字体能消除系统字体选择造成的字形与字宽差异。严格复现仍需相同的 TeX Live、XeLaTeX 和宏包版本；本目录不保证 PDF 时间戳或文件哈希一致。
