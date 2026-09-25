%% icsthesis.cls
%% ----------------
%% Implements the style rules published by ICS-ULisboa at https://www.ics.ulisboa.pt/trabalho-final
%% Maintainer: Hugo Ferrinho Lopes
%% Repository: https://github.com/hugoferrinholopes/ics-ulisboa-thesis
%% ----------------
%% DERIVATION NOTICE (required by the LaTeX Project Public License)
%%
%% This class is a substantially modified derivative of the
%% "IPLeiria Thesis" class, version 2.1.0 (2024/12/06), by
%% Jose Antonio Portela Areia <jose.apareia@gmail.com>,
%% https://github.com/joseareia/ipleiria-thesis, licensed LPPL-1.3c.
%% ----------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{icsthesis}[2026/09/25 v1.0 ICS-ULisboa PhD thesis class]

% =============================================
% CLASS OPTIONS
% =============================================

% --- Language -------------------------------
\newcommand{\ics@language}{english}
\newif\ifics@pt \ics@ptfalse
\DeclareOption{en}{\renewcommand{\ics@language}{english}\ics@ptfalse}
\DeclareOption{pt}{\renewcommand{\ics@language}{portuguese}\ics@pttrue}

% --- Thesis format --------------------------
% articles  : compilation of studies (each study is a numbered chapter)
% monograph : traditional monograph
\newif\ifics@articles \ics@articlestrue
\DeclareOption{articles}{\ics@articlestrue}
\DeclareOption{monograph}{\ics@articlesfalse}

% --- Submission stage ------------------------
% provisional : version submitted for admission to the viva
% final       : definitive version, deposited after the viva
\newif\ifics@provisional \ics@provisionaltrue
\DeclareOption{provisional}{\ics@provisionaltrue}
\DeclareOption{final}{\ics@provisionalfalse}

% --- Body typeface --------------------------
% times (default, 11 or 12pt) / arial (11pt) / calibri (11pt)
\newcommand{\ics@face}{times}
\DeclareOption{times}{\renewcommand{\ics@face}{times}}
\DeclareOption{arial}{\renewcommand{\ics@face}{arial}}
\DeclareOption{calibri}{\renewcommand{\ics@face}{calibri}}

% --- Body size ------------------------------
\newcommand{\ics@size}{12pt}
\DeclareOption{11pt}{\renewcommand{\ics@size}{11pt}}
\DeclareOption{12pt}{\renewcommand{\ics@size}{12pt}}

% --- Blank-page notice ----------------------
% By default, pages left blank to force an odd-page start carry a discreet
% notice. Pass 'silentblanks' for entirely empty blank pages.
\newif\ifics@blanknotice \ics@blanknoticetrue
\DeclareOption{silentblanks}{\ics@blanknoticefalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

% Arial and Calibri are permitted at 11pt only.
\def\ics@tmpa{arial}\def\ics@tmpb{calibri}\def\ics@twelve{12pt}
\ifx\ics@size\ics@twelve
  \ifx\ics@face\ics@tmpa
    \ClassWarningNoLine{icsthesis}{ICS rules allow Arial at 11pt only.
      Forcing 11pt}\renewcommand{\ics@size}{11pt}\fi
  \ifx\ics@face\ics@tmpb
    \ClassWarningNoLine{icsthesis}{ICS rules allow Calibri at 11pt only.
      Forcing 11pt}\renewcommand{\ics@size}{11pt}\fi
\fi

\LoadClass[a4paper,twoside,openright,\ics@size]{report}

% =============================================
% ENGINE CHECK
% =============================================
\RequirePackage{iftex}
\ifXeTeX\else\ifLuaTeX\else
  \ClassError{icsthesis}{This class requires XeLaTeX. On Overleaf:
    Menu > Compiler > XeLaTeX}
    {The latexmkrc file supplied with the template normally selects
     XeLaTeX on its own. Locally, run: latexmk -xelatex main.tex}
\fi\fi

% =============================================
% LANGUAGE
% =============================================
\RequirePackage[main=\ics@language,english,portuguese]{babel}
\newcommand{\getLanguage}{\ics@language}

% Convenience switches.
\RequirePackage{ifthen}
\DeclareRobustCommand{\ifprovisional}[2]{\ifics@provisional #1\else #2\fi}
\DeclareRobustCommand{\iflangpt}[2]{\ifics@pt #1\else #2\fi}

% =============================================
% PAGE GEOMETRY 
% =============================================
\RequirePackage[
  a4paper,
  top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm,
  footskip=1.25cm,
  headsep=0.5cm,
  headheight=14.5pt
]{geometry}

% =============================================
% TYPEFACES  
% =============================================
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}

\def\ics@arial{arial}\def\ics@calibri{calibri}

% Small caps borrowed from TeX Gyre, upright and bold.
\newcommand{\ics@serifsc}{%
  SmallCapsFont=texgyretermes-regular.otf,
  SmallCapsFeatures={Letters=SmallCaps},
  BoldFeatures={SmallCapsFont=texgyretermes-bold.otf,
                SmallCapsFeatures={Letters=SmallCaps}}}
\newcommand{\ics@sanssc}{%
  SmallCapsFont=texgyreheros-regular.otf,
  SmallCapsFeatures={Letters=SmallCaps},
  BoldFeatures={SmallCapsFont=texgyreheros-bold.otf,
                SmallCapsFeatures={Letters=SmallCaps}}}

\newcommand{\ics@setfont}[3]{%
  \begingroup\edef\x{\endgroup\noexpand\setmainfont{#1}[#3#2]}\x}

\ifx\ics@face\ics@arial
  \IfFontExistsTF{Arial}
    {\ics@setfont{Arial}{\ics@sanssc}{}}
    {\ics@setfont{texgyreheros}{}{Extension=.otf,
       UprightFont=*-regular, BoldFont=*-bold,
       ItalicFont=*-italic, BoldItalicFont=*-bolditalic}%
     \ClassWarningNoLine{icsthesis}{Arial not found; using TeX Gyre Heros
       (same widths, different kerning:
       line breaks may differ from the final version)}}
\else\ifx\ics@face\ics@calibri
  \IfFontExistsTF{Calibri}
    {\ics@setfont{Calibri}{\ics@sanssc}{}}
    {\ics@setfont{Carlito}{\ics@sanssc}{Extension=.ttf,
       UprightFont=*-Regular, BoldFont=*-Bold,
       ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic,}%
     \ClassWarningNoLine{icsthesis}{Calibri not found; using Carlito
       (same widths, different kerning:
       line breaks may differ from the final version)}}
\else
  \IfFontExistsTF{Times New Roman}
    {\ics@setfont{Times New Roman}{\ics@serifsc}{}}
    {\ics@setfont{texgyretermes}{}{Extension=.otf,
       UprightFont=*-regular, BoldFont=*-bold,
       ItalicFont=*-italic, BoldItalicFont=*-bolditalic}%
     \ClassWarningNoLine{icsthesis}{Times New Roman not found; using
       TeX Gyre Termes (same widths, different kerning:
       line breaks may differ from the final version)}}
\fi\fi

% Cover and title page typeface.
\IfFontExistsTF{Lato}
  {\newfontfamily\coverfont{Lato}}
  {\IfFontExistsTF{Lato-Regular.ttf}
    {\newfontfamily\coverfont{Lato}[
       Extension=.ttf,
       UprightFont=*-Regular, BoldFont=*-Bold,
       ItalicFont=*-Italic,   BoldItalicFont=*-BoldItalic]}
    {\newcommand{\coverfont}{\normalfont}%
     \ClassWarningNoLine{icsthesis}{Lato not found; cover falls back to
       the body typeface}}}

\RequirePackage{microtype}
\RequirePackage{etoolbox}

% black text throughout.
\RequirePackage[dvipsnames]{xcolor}
\definecolor{icslink}{RGB}{0,0,0}
\definecolor{icscover}{RGB}{0,0,0}

% =============================================
% SPACING AND PARAGRAPHS
% =============================================
\RequirePackage{setspace}
\onehalfspacing % 1.5 line spacing
\setlength{\parskip}{0pt} % no extra space between paragraphs
\setlength{\parindent}{0.7cm} % 0.7 cm indent from the 2nd paragraph
\RequirePackage{ragged2e}
\justifying % justified text

% A little slack for the line breaker.
\setlength{\emergencystretch}{1em}

% floats. Pages end where the text ends instead.
\raggedbottom

% =============================================
% HEADINGS 
% =============================================
\RequirePackage{sectsty}
\allsectionsfont{\singlespacing\raggedright}

\RequirePackage{titlesec}

% Chapter headings
\titleformat{\chapter}[display]
  {\normalsize\Huge\color{black}}
  {\normalsize
   {\fontsize{25}{25}\selectfont\rule[-2pt]{.1pt}{30pt}\hspace{0.5em}%
    \raisebox{4.5pt}{\thechapter}}}
  {10pt}
  {\addfontfeature{LetterSpace=6}%
   \singlespacing\Huge\scshape\bfseries\raggedright}
\titlespacing*{\chapter}{0pt}{0pt}{1.5\baselineskip}

% Unnumbered chapters (front matter) get the same face without the rule.
\titleformat{name=\chapter,numberless}[display]
  {\normalsize\Huge\color{black}}
  {}
  {0pt}
  {\addfontfeature{LetterSpace=6}%
   \singlespacing\Huge\scshape\bfseries\raggedright}
\titlespacing*{name=\chapter,numberless}{0pt}{0pt}{1.5\baselineskip}

\titlespacing*{\section}{0pt}{1.2\baselineskip}{0.6\baselineskip}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0.5\baselineskip}
\titlespacing*{\subsubsection}{0pt}{\baselineskip}{0.5\baselineskip}

% \guidenote
\definecolor{icsnote}{RGB}{90,90,90}
\NewDocumentCommand{\guidenote}{m}{%
  \begin{center}%
  \begin{minipage}{0.92\textwidth}%
    \setstretch{1}\small\color{icsnote}%
    \noindent\rule{\linewidth}{0.4pt}\par\vspace{.25\baselineskip}%
    \noindent\textbf{\iflangpt{Orientação para a escrita}%
      {Writing guidance}}\par\vspace{.35\baselineskip}%
    \noindent #1\par\vspace{.35\baselineskip}%
    \noindent\rule{\linewidth}{0.4pt}%
  \end{minipage}%
  \end{center}%
  \par\vspace{\baselineskip}%
  \everypar{{\setbox\z@\lastbox}\everypar{}}%
}

% \studynote{...} - a note at the head of a paper stating co-authorship and publication status. 
% In 'monograph' mode the command is silently ignored
\NewDocumentCommand{\studynote}{m}{%
  \ifics@articles
    \begin{center}%
    \begin{minipage}{0.9\textwidth}%
      \setstretch{1}\small\itshape\centering #1%
    \end{minipage}%
    \end{center}%
    \par\vspace{0.8\baselineskip}%
    \everypar{{\setbox\z@\lastbox}\everypar{}}%
  \fi}

% \chapterabstract{...} - a short abstract for an individual paper.
\NewDocumentCommand{\chapterabstract}{m}{%
  \ifics@articles
    \begin{center}%
    \begin{minipage}{0.9\textwidth}%
      \setstretch{1}\small
      \noindent\textbf{\iflangpt{Resumo}{Abstract}}\par\vspace{0.3\baselineskip}%
      \noindent #1%
    \end{minipage}%
    \end{center}%
    \par\vspace{\baselineskip}%
    \everypar{{\setbox\z@\lastbox}\everypar{}}%
  \fi}

% =============================================
% HEADERS AND FOOTERS 
% =============================================
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[LE,RO]{\thepage} % outer bottom corner

% Optional running head with the short title
\newcommand{\shorttitleheader}[1]{%
  \fancyhead[CE,CO]{\footnotesize\itshape #1}}

\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[LE,RO]{\thepage}}

% =============================================
% BLANK PAGES AND ODD-PAGE STARTS 
% =============================================
\RequirePackage{emptypage}

\newcommand{\icsblankpage}{%
  \clearpage
  \ifodd\value{page}\else
    \thispagestyle{empty}%
    \null\vfill
    \ifics@blanknotice
      \begin{center}
        \textcolor{gray!60}{\itshape
          \iflangpt{Página intencionalmente deixada em branco.}
                   {This page is intentionally left blank.}}
      \end{center}
    \fi
    \vfill\newpage
  \fi}

% Start the next element on an odd page
\newcommand{\icsnextodd}{\icsblankpage}

% Chapters open on the right through \cleardoublepage. Route it through the same macro, so that every blank page in the document looks alike
\renewcommand{\cleardoublepage}{\icsblankpage}

% The standard titlepage environment resets the page counter to 1. Here the page counter always equals the physical page: the cover is page 1, its back is left silently blank, and the title page falls on the next recto.
\newif\ifics@incover
\renewenvironment{titlepage}
  {\clearpage
   \ifodd\value{page}\else\null\thispagestyle{empty}\newpage\fi
   \thispagestyle{empty}\ics@incovertrue}
  {\clearpage}

% =============================================
% CAPTIONS 
% =============================================
\RequirePackage{caption}
\captionsetup{
  font={normalsize,stretch=1.0},
  labelfont=bf,
  labelsep=period,
  skip=8pt
}
\captionsetup[table]{position=above, justification=justified,
  singlelinecheck=false}
\captionsetup[figure]{position=below, justification=centering,
  singlelinecheck=true}
\RequirePackage{subcaption}


\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}

% =============================================
% FOOTNOTES 
% =============================================
\RequirePackage[hang,bottom,flushmargin]{footmisc}
\setlength{\footnotemargin}{0.4cm}
\def\ics@elevenpt{11pt}
\ifx\ics@size\ics@elevenpt
  \newcommand{\ics@fnsize}{\fontsize{10}{12}\selectfont}
\else
  \newcommand{\ics@fnsize}{\fontsize{11}{13}\selectfont}
\fi
\renewcommand{\footnotelayout}{\ics@fnsize\setstretch{1}}
\counterwithout{footnote}{chapter}   % continuous footnote numbering

% =============================================
% BIBLIOGRAPHY 
% =============================================
\RequirePackage{csquotes}

% ---- APA (default) --------------------------
\RequirePackage[
  backend=biber,
  style=apa, % ICS accepts APA or Chicago author-date
  natbib=true,
  uniquename=false,
  uniquelist=false,
  sortcites=true,
  maxcitenames=2,
  maxbibnames=99
]{biblatex}
\DeclareLanguageMapping{english}{english-apa}
\DeclareLanguageMapping{portuguese}{portuguese-apa}

% ---- Chicago author-date alternative -------
% To switch, comment out the whole APA block above, the two language mapping lines included, and uncomment the line below. 
% \RequirePackage[authordate, backend=biber, natbib=true]{biblatex-chicago}
% ----------------

% single spacing, 0.7 cm hanging indent.
\renewcommand*{\bibfont}{\normalfont\setstretch{1}}
\setlength{\bibhang}{0.7cm}
\setlength{\bibitemsep}{0.6\baselineskip}

% Break kong URLs and DOIs 
\setcounter{biburlnumpenalty}{100}
\setcounter{biburlucpenalty}{100}
\setcounter{biburllcpenalty}{100}

% =============================================
% TABLES, FIGURES, LISTS, CODE
% =============================================
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{longtable}
\RequirePackage{threeparttable}
\RequirePackage{rotating}
\RequirePackage{pdflscape}
\RequirePackage{adjustbox}
\RequirePackage{array}
\RequirePackage{float}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% Numbers in tables aligned on the decimal marker (S columns), with room
% for standard errors in parentheses and significance stars. They are set
% in the body typeface. In English the decimal marker is a point and
% thousands take a comma (2,431), as APA asks; in Portuguese the decimal
% marker is a comma and thousands take a thin space (2 431).
\RequirePackage{siunitx}
\sisetup{
  mode=text,                        % numbers in the body typeface
  table-align-text-before=false,     % "(0.036)", not "( 0.036)"
  table-align-text-after=false,
  input-open-uncertainty=,
  input-close-uncertainty=,
  group-minimum-digits=4
}
\iflangpt{\sisetup{output-decimal-marker={,}, group-separator={\,}}}
         {\sisetup{group-separator={,}}}

\RequirePackage{blindtext}  
\@namedef{blindtext@portuguese}{}

\RequirePackage{url}
\urlstyle{tt}
\RequirePackage{enumitem}
\setlist{noitemsep,topsep=0.3\baselineskip}

% Tables are set single spaced
\AtBeginEnvironment{tabular}{\ifics@incover\else\setstretch{1}\small\fi}
\AtBeginEnvironment{tabularx}{\setstretch{1}\small}
\AtBeginEnvironment{longtable}{\setstretch{1}\small}

% Vertical space
\setlength{\LTpre}{12pt plus 4pt}
\setlength{\LTpost}{12pt plus 4pt}
\setlength{\textfloatsep}{20pt plus 2pt}
\setlength{\floatsep}{12pt plus 2pt}
\setlength{\intextsep}{12pt plus 2pt}

% Code listings
\RequirePackage{listings}
\definecolor{icscodebg}{gray}{0.96}
\definecolor{icscodecomment}{gray}{0.40}
\lstdefinestyle{icsstyle}{
  backgroundcolor=\color{icscodebg},
  basicstyle=\ttfamily\footnotesize\setstretch{1},
  commentstyle=\color{icscodecomment}\itshape,
  breaklines=true,
  breakatwhitespace=false,
  captionpos=t,
  frame=single,
  rulecolor=\color{gray!40},
  numbers=left,
  numberstyle=\tiny\color{gray},
  numbersep=8pt,
  showstringspaces=false,
  tabsize=2,
  xleftmargin=14pt
}
\lstset{style=icsstyle}
\iflangpt{\renewcommand{\lstlistingname}{Listagem}}{}

% Simple graphs drawn in LaTeX
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
% Tick labels in the body typeface rather than in the math font, with a decimal comma in a thesis written in Portuguese.
\pgfplotsset{every tick label/.append style={
  /pgf/number format/assume math mode=true}}
\iflangpt{\pgfplotsset{/pgf/number format/use comma}}{}
\usepgfplotslibrary{statistics}

% =============================================
% Colors.
% =============================================
\colorlet{darkred}{red!60!black}
\definecolor{darkblue}{RGB}{0, 94, 184}

% =============================================
% CROSS-REFERENCES AND LINKS
% =============================================
\RequirePackage{hyperref}
% Custom color for citations and references.
\hypersetup{
  %breaklinks=true,
  colorlinks=true,
  linkcolor=darkred,
  citecolor=darkblue,%blue!70!black,
  urlcolor=darkred,
  linktoc=all
}

\RequirePackage{nameref}
\RequirePackage[nameinlink,noabbrev]{cleveref}

\iflangpt{%
  \crefname{figure}{Figura}{Figuras}
  \crefname{table}{Quadro}{Quadros}
  \crefname{chapter}{Capítulo}{Capítulos}
  \crefname{section}{Secção}{Secções}
  \crefname{equation}{Equação}{Equações}
}{%
  \crefname{table}{Table}{Tables}
}

% Numbered hypotheses (H1, H2, ...), referenced with \cref like any other element: \cref{hyp:one} gives "hypothesis H1".
\newlist{hypotheses}{enumerate}{1}
\setlist[hypotheses]{label=\textbf{H\arabic*}, ref=H\arabic*,
  leftmargin=*, labelsep=1em, itemsep=0.3\baselineskip}
\iflangpt{\crefname{hypothesesi}{hipótese}{hipóteses}}
         {\crefname{hypothesesi}{hypothesis}{hypotheses}}

% numerical or qualitative tables are "quadros" in Portuguese.
\iflangpt{\addto\captionsportuguese{\renewcommand{\tablename}{Quadro}}}{}
\iflangpt{\addto\captionsportuguese{%
  \renewcommand{\listtablename}{Índice de Quadros}}}{}

% =============================================
% FRONT MATTER TOOLS
% =============================================
\RequirePackage{titling}
\RequirePackage[nottoc]{tocbibind}   % the contents do not list themselves
\RequirePackage{appendix}
\RequirePackage{eso-pic}
\RequirePackage{xparse}

% ---- Document variables --------------------
\NewDocumentCommand{\candidate}{m}{\newcommand{\candidatename}{#1}}
\NewDocumentCommand{\supervisor}{m}{\newcommand{\supname}{#1}}
\NewDocumentCommand{\supervisortitle}{m}{\newcommand{\suptitle}{#1}}
\NewDocumentCommand{\cosupervisor}{m}{\newcommand{\cosupname}{#1}}
\NewDocumentCommand{\cosupervisortitle}{m}{\newcommand{\cosuptitle}{#1}}
\NewDocumentCommand{\seccosupervisor}{m}{\newcommand{\seccosupname}{#1}}
\NewDocumentCommand{\seccosupervisortitle}{m}{\newcommand{\seccosuptitle}{#1}}
\NewDocumentCommand{\subtitle}{m}{\newcommand{\subname}{#1}}
\NewDocumentCommand{\shorttitle}{m}{\newcommand{\shortname}{#1}}
\NewDocumentCommand{\university}{m}{\newcommand{\univname}{#1}}
\NewDocumentCommand{\institute}{m}{\newcommand{\instname}{#1}}
\NewDocumentCommand{\degree}{m}{\newcommand{\degname}{#1}}
\NewDocumentCommand{\course}{m}{\newcommand{\coursename}{#1}}
\NewDocumentCommand{\funding}{m}{\newcommand{\fundingnote}{#1}}
\NewDocumentCommand{\juryprestitle}{m}{\newcommand{\jurypres}{#1}}
\NewDocumentCommand{\logo}{m}{\newcommand{\icslogo}{#1}}

% ---- Keywords ------------------------------
\NewDocumentCommand{\keywordsen}{m}{%
  \vspace{.6\baselineskip}\noindent\textbf{Keywords:} #1}
\NewDocumentCommand{\keywordspt}{m}{%
  \vspace{.6\baselineskip}\noindent\textbf{Palavras-chave:} #1}

% ---- Unnumbered front-matter chapter --------
\NewDocumentCommand{\frontchapter}{sm}{%
  \icsnextodd
  \chapter*{#2}%
  \IfBooleanF{#1}{\addcontentsline{toc}{chapter}{#2}}%
  \markboth{#2}{#2}}

% the dedication carries no page number.
\NewDocumentCommand{\dedicationpage}{m}{%
  \icsnextodd
  \thispagestyle{empty}%
  \null\vspace*{0.25\textheight}
  \begin{flushright}\itshape #1\end{flushright}
  \vfill\clearpage}

% =============================================
% ABSTRACT ENVIRONMENTS
% =============================================
\newenvironment{icsabstract}[1]
  {\frontchapter{#1}}
  {\clearpage}

\endinput
