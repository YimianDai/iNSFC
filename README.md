# iNSFC - 2017 年国家自然基金 LaTeX 模板

对于高校教师和研究人员来说，国家自然科学基金（National Natural Science Foundation of China，NSFC）非常重要，写出能让所有专家都满意的本子也相当的耗时。对于平时只采用 LaTeX 格式投稿论文的老师来说，由于基金委只给出了 Word 模板，这种切换大致会有下面一些不方便：

+ 本子中很可能会用到以往小论文中的公式、图表以及参考文献，无法直接复制粘贴，要将一模一样的内容从 LaTeX 转换成 Word 需要不少时间；
+ Word 中对参考文献、图表、公式的交叉引用没有 LaTeX 来的方便。

很自然的，如果能有一个国家自然基金的 LaTeX 模板就好了，可以挤出更多的时间来关注内容，而非格式以及排列参考文献这种机械无聊的事情上。

### Prior work on NSFC template

目前知道的 NSFC 模板一共两个，一个是 NSFC 官方给出的 Word 模板，也是LaTeX 模板的仿制对象。青年基金和面上基金的模板是一模一样的，本文的 LaTeX 模板也只是针对青年和面上，毕竟其他模板还无缘得见。Word 模板的具体样式如下：

+ **页面布局：**
  + **页边距：**上 2.54 厘米；下 2.54 厘米；左 3.2 厘米；右 3.2 厘米；装订线：0 厘米；
  + **纸张：**A4，宽度 21 厘米，高度 29.7 厘米；
  + **版式：**距边距 页眉 1.5 厘米，页脚 1.75 厘米。
+ **文字：**
  + **正文标题：**字体是 加粗的楷体二号，段后间距 0.5 行，行距为固定值 22 磅；
  + **一级大标题：**楷体四号，段后间距 0.5 行，行距为固定值 22 磅；前半部分加粗，后半部分不加粗；
  + **二级标题：**楷体四号，行距为固定值 22 磅；前部的数字标号不加粗，中部文字加粗，最后部分不加粗；关于段后行距，部分有0.5行，部分没有，Word模板没统一，个人认为统一有更美观一些；
  + **颜色：**蓝色，RGB 数值为 (0, 112, 192)。

另一个模板是今年1月8号，南开大学的[程明明教授](http://mmcheng.net)，曾在 CTeX 论坛上给出过一个[国家自然科学基金的 LaTeX 模版](http://www.latexstudio.net/archives/9308)。受程明明教授先驱工作的启发，我们也做了一点微小的工作。

### Motivation

已有珠玉在前，我们之所以还要重新造轮子，主要是参考了最新一年青年和面上基金模板，重新修改了页面布局、字体类型和大小以及颜色、标题内容，以期做到与 Word 模板尽可能的相似。主要贡献如下：

+ 重新设置了页面布局、字体类型和大小以及颜色、标题内容，基本做到了100\% 的高仿；
+ 参考文献完全依照国标 gbt7714-2005，修正了部分 Bug，提供了新的引用命令；
+ 替换并引入了一些新的宏包，增加了更多的选项，定制性更好。

如果说还有一点成绩就是写了这篇啰哩啰唆的文档，对于 LaTeX 新人，也能够比较方便地根据自己的需求修改模板。因为是在程明明教授作品的基础上改进的，为表示尊重，我们把我们的模板叫作 improved NSFC template，简称为 iNSFC。

最新的模板可以从 Github 上的[项目主页](https://github.com/YimianDai/iNSFC)下载到。为防 Github 惨遭不测，国内用户也可访问 coding.net 上的[项目备份](https://coding.net/u/YimianDai/p/iNSFC/git)下载最新模板。

### Details

#### 编译

由于 CTeX 宏集的行为会受编译方式影响，比如不同编译方式下 CTeX 宏集底层的中文支持方式也会不同。LaTeX 和 pdfLaTeX 为 CJK 宏包，XeLaTeX 为 xeCJK 宏包，LuaLaTeX 为 LuaTeX-ja 宏包；使用 XeLaTeX 和 LuaLaTeX 编译时，CTeX 宏集使用 UTF-8 编码，LaTeX 和 pdfLaTeX 时使用 GBK 编码。最终的排版效果因不同编译方式而已。

**本模板唯一推荐使用的是 XeLaTeX**，可以获得与 Word 模板100%接近的效果。发行版为 TeXLive 2015 或者 2016 均可，但在 TeXLive 2014 中编译会不通过，因为 CTeX 在 14 和 15 之间有了重大更新。这里暂不推荐其他发行版，毕竟按照 [L 叔](http://liam0205.me/)的名言

> 选择 TeX Live，选择简单的人生；
>
> 选择 MiKTeX，选择麻烦的人生；
>
> 选择 CTeX 套装，选择崩溃的人生。

模板默认按照 XeLaTeX 编译，如果使用 XeLaTeX，那么不需要做任何改动。demo.tex 用 LuaLaTeX 也可以编译通过，但标题加粗部分会不再是粗体；如果想使用 pdfLaTeX，需要在 insfc.sty 中将`\usepackage{fontspec}` 注释掉，`NsfcChapter` 和 `NsfcSection` 命令中的 `\setmainfont{KaiTi} `去掉，但标题中的数字字体将不再是楷体，而且字宽会变宽一点。为了能够让 Sublime Text 中的 LaTeXTools 这样的插件也可以顺利编译，在 demo.tex 中也需要将第一行注释的 xelatex 改为对应的 lualatex 或者 pdflatex。

如果是 **Mac** 版 TeXlive 用户需要更改默认楷书字体，把 insfc.sty 里的 KaiTi 改成 Kai 就能正常编译通过了。

#### 字体

就个人审美而言，正文使用楷体比宋体更加美观。所以我们专门设置了楷体，如果用户想要将自己的内容设置为宋体，只需在 .tex 文件中将下列代码注释掉：

```latex
% 导言区中部  
\DeclareCaptionFont{capfont}{\kaishu\zihao{-4}\selectfont} % Caption font
\DeclareCaptionFont{subfont}{\kaishu\zihao{5}\selectfont} % Sub-caption font
\captionsetup{font = capfont}
\captionsetup[subfigure]{font = subfont}
% \begin{document} 下方
\kaishu
```

#### 参考文献

在 insfc.sty 中，关于参考文献的设置如下，可以看到，我们使用了 natbib 宏包来定制参考文献，除了常用的 `\ cite{}` 命令来提供 full size 的参考文献引用，还提供了 `\citess{}` 命令用于提供上标（右上角）时候的引用（ss 是 superscript 的缩写）。最后一句代码用于调节参考文献条目之间距离。

```latex
\usepackage[square,numbers,sort&compress]{natbib}
\newcommand{\citess}[1]{\textsuperscript{\cite{#1}}}
\setlength{\bibsep}{1pt plus 0.3ex}
```

参考文献的字体、大小和样式风格，可以在 .tex 文件中下面代码里调节。gbt7714-nsfc.bst 文件基于南京大学计算机科学与技术系胡海星博士的 [GBT7714-2005-BibTeX-Style 项目](https://github.com/Haixing-Hu/GBT7714-2005-BibTeX-Style)，我们在此基础上稍做了一点修改，使得英文人名从全部字母大写变为只有首字母大写。

参考文献的行距、字体和大小可以在下列代码中修改

```latex
\begin{spacing}{1.0}  
  \zihao{5} \songti   
  \bibliographystyle{gbt7714-nsfc}
  \bibliography{ref}
\end{spacing}
```

#### 公式

正文和公式之间的间距可以由在下列两句代码调整

```latex
% Decrease space above and below equations
\setlength{\abovedisplayskip}{0pt}
\setlength{\belowdisplayskip}{0pt}
```

#### 插图和表格

其余的插图和表格测试具体请见模板中的 `demo.pdf`。

## Release Notes:

+ Version 1.03：修正了正文与公式之间间距过大的问题。
+ Version 1.02：上传了之前漏掉的 gbt7714-nsfc.bst，增加正文设置为宋体，图题表题去掉了冒号。
+ Version 1.01：去除了 minted 宏包。
+ Version 1.00：第一版。

## 致谢

最后感谢[程明明教授](http://mmcheng.net)的首创性工作，LaTeX 社区的 [L 叔](http://liam0205.me/)提供的细心指导，以及 chengsshi、noirchen 等朋友的指正，也感谢您一直阅读到这里，如果我的文章有错误或不足之处，请务必在评论中留言指出，千万不用客气，万分感谢~