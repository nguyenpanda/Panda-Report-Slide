%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%    PandaReportSlide CLASS     %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PandaReportSlide}[
    2025/07/10 "PandaReportSlide"
    LaTeX template for report slides was created by Ha Tuong Nguyen 
    (a.k.a nguyenpanda) for my research progress updates 
    at Ho Chi Minh City University of Technology. 
    Feel free to use it if you would like. 
    If you think it looks ugly, then f your damn opinion.
    Email: hatuongnguyen0107@gmail.com | 
    Github: https://github.com/nguyenpanda
]

%%% Argument package
\RequirePackage{kvoptions}
    \SetupKeyvalOptions{
        family=panda,
        prefix=panda@
    }

    \DeclareBoolOption[false]{defaultfont}
    \DeclareVoidOption{defaultfont}{\panda@defaultfonttrue}

    \DeclareBoolOption[false]{draft}
    \DeclareVoidOption{draft}{\panda@drafttrue}

    \ifpanda@draft
        \message{*** DRAFT MODE ACTIVE: Custom fonts will be loaded ***}
    \else
        \message{*** PRODUCTION MODE: Default fonts will be used ***}
    \fi

% Pass all unknown options to beamer
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessKeyvalOptions* % `kvoptions' Package
\ProcessOptions\relax
% Slide size 16:9
\LoadClass[aspectratio=169]{beamer}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%        PACKAGES        %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Layout

%%% Graphic & Drawing
\RequirePackage{graphicx}
    \graphicspath{
        {image/}
    }
\RequirePackage{tikz}
\RequirePackage{tcolorbox}
    \tcbuselibrary{skins, breakable}

%%% Color
\RequirePackage{xcolor}
    \definecolor{lightgray}{RGB}{230,230,230}
    \definecolor{linkblue}{RGB}{0,102,255}
    \definecolor{hcmutlb}{RGB}{20, 136, 219}
    \definecolor{hcmutdb}{RGB}{3, 43, 145}

%%% Text & Font
\RequirePackage{mfirstuc}   % Text manipulate
\RequirePackage{lmodern}    % Latin Modern font (for fallback)
\RequirePackage{fontspec}   % For custom font loading (XeLaTeX/LuaLaTeX)
    \ifpanda@defaultfont
        \newfontfamily\bernoru{Latin Modern Roman}
        % \newfontfamily\nunito{Latin Modern Roman}
        \newfontfamily\worksans{Latin Modern Roman}
        \newfontfamily\jetbrains{Latin Modern Roman}
        \setmainfont{Latin Modern Roman}
    \else
        \newfontfamily\bernoru[
            Path = ./font/BernoruSemiCondensed/static/,
            UprightFont = *-Regular,
            Extension = .otf,
        ]{BernoruSemiCondensed}

        % \newfontfamily\nunito[
        %     Path = ./font/Nunito/static/,
        %     UprightFont = *-Regular,
        %     BoldFont = *-Bold,
        %     ItalicFont = *-Italic,
        %     BoldItalicFont = *-BoldItalic,
        %     Extension = .ttf,
        % ]{Nunito}

        \newfontfamily\worksans[
            Path = ./font/WorkSans/static/,
            UprightFont = *-Regular,
            BoldFont = *-Bold,
            ItalicFont = *-Italic,
            BoldItalicFont = *-BoldItalic,
            Extension = .ttf,
        ]{WorkSans}

        \newfontfamily\jetbrains[
            Path = ./font/JetBrainsMono/static/,
            UprightFont = *-Regular,
            BoldFont = *-Bold,
            ItalicFont = *-Italic,
            BoldItalicFont = *-BoldItalic,
            Extension = .ttf,
        ]{JetBrainsMono}
        
        \setmainfont{WorkSans}
    \fi

%%% Other packages
\RequirePackage{emoji}
\RequirePackage{array}
\RequirePackage{hyperref}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%        Beamer         %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{navigation symbols}{%
    \ifbeamer@plainframe
        
    \else
        \usebeamerfont{footline}%
        \setbeamercolor{footline}{fg=blue}%
        \setbeamerfont{footline}{series=\worksans}%
        \usebeamercolor[fg]{footline}%
        \hspace{1em}%
        \insertframenumber/\inserttotalframenumber%
    \fi
}

\setbeamertemplate{background}{
    \ifbeamer@plainframe
        % Do nothing for plain frames (like cover)
    \else
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north east, xshift=0em, yshift=0em] at (current page.north east) {
            \includegraphics[height=1cm]{logo/nguyenpanda.png}
        };
        \end{tikzpicture}
    \fi
}

\setbeamertemplate{headline}{
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=\paperwidth,ht=2.5ex,dp=1.5ex,left]{section in head/foot}%
        \end{beamercolorbox}%
    }
}

\setbeamertemplate{footline}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%      Cover slide      %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Cover page customization commands
\newcommand{\@CoverTitleOverride}{$\backslash$CoverTitle\{TITLE\}}
\newcommand{\CoverTitle}[1]{\renewcommand{\@CoverTitleOverride}{#1}}

\newcommand{\@CoverSubTitleOverride}{$\backslash$CoverTitle\{TITLE\}}
\newcommand{\CoverSubTitle}[1]{\renewcommand{\@CoverSubTitleOverride}{#1}}

\newcommand{\@CoverReportPeriodOverride}{$\backslash$CoverReportPeriod\{25\_MMDD -- 25\_MMDD\}}
\newcommand{\CoverReportPeriod}[1]{\renewcommand{\@CoverReportPeriodOverride}{#1}}

\newcommand{\@CoverReportTimeOverride}{$\backslash$CoverReportTime\{\#XX\}}
\newcommand{\CoverReportTime}[1]{\renewcommand{\@CoverReportTimeOverride}{#1}}

\newcommand{\@supervisorOverride}{$\backslash$supervisor\{YOUR SUPERVISOR\}}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisorOverride}{#1}}

\newcommand{\@studentOverride}{$\backslash$student\{YOUR NAME\}}
\newcommand{\student}[1]{\renewcommand{\@studentOverride}{#1}}

%%% Cover Page Template
\def\CoverPage{
    \ifpanda@draft

    \else
        \setbeamertemplate{background canvas}{
            \includegraphics[width=\paperwidth,height=\paperheight]{image/hcmut_theme/FrontBackground-nologo.pdf}
        }
    \fi

    \begin{frame}[plain]
        \centering

        \includegraphics[height=1cm]{logo/cover.png}
        \vspace{0.5cm}
    
        \textbf{\bernoru\Huge\scalebox{1}[2]{\@CoverTitleOverride}} \\ [0.5cm]
        \textbf{\bernoru\large\scalebox{1}[2]{\@CoverSubTitleOverride}}
        \vspace{1cm}
        
        \textbf{\bernoru\Large\scalebox{1}[1.5]{\@CoverReportTimeOverride}}
        \vspace{0.5cm}
        
        {\worksans
            Reporting Period: \@CoverReportPeriodOverride
        }
        
        \line(1,0){8cm}
        \vspace{0.2cm}

        {\worksans
            \begin{tabular}{rl}
                Supervisor: & \textbf{\@supervisorOverride}
                \\
                % \textbf{Student:} & \@studentOverride 
                % \\
                Student: & 
                    \raisebox{-0.2\height}[0pt][0pt]{
                        \hspace{-0.25cm}
                        \includegraphics[height=4mm]{
                            logo/nguyenpanda_text.png
                        }
                    }
                \\
            \end{tabular}
        }
    \end{frame}

    \ifpanda@draft
        \setbeamertemplate{background canvas}{}
    \else
        \setbeamertemplate{background canvas}{
            \includegraphics[width=\paperwidth,height=\paperheight]{image/hcmut_theme/Background-nologo.pdf}
        }
    \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%        Meta information slide        %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Meta information page customization commands
\newcommand{\MetaInfoRows}{} % initialize
\newcommand{\MetaInfoAddRow}[3]{ % add row to meta info table
    \g@addto@macro\MetaInfoRows{
        #1: & \href{#3}{\textbf{#2}} \\
    }
}

\newcommand{\@supervisorEmailOverride}{$\backslash$supervisorEmail\{supervisor@email.com\}}
\newcommand{\supervisorEmail}[1]{\renewcommand{\@supervisorEmailOverride}{#1}}

\newcommand{\@studentEmailOverride}{$\backslash$studentEmail\{student@email.com\}}
\newcommand{\studentEmail}[1]{\renewcommand{\@studentEmailOverride}{#1}}

%%% Meta information
\def\MetaInfo{
    \begin{frame}
        \frametitle{Meta Information}
        \centering
        \begin{tcolorbox}[
            standard jigsaw,
            colback=lightgray,
            height=0.75\textheight,
            width=\textwidth,
            boxrule=0pt,
            opacityback=0.5,
            arc=1cm,]
            
            \centering
            {\renewcommand{\arraystretch}{2}
                \worksans
                \begin{table}
                    \begin{tabular}{rl}
                        \MetaInfoRows
                    \end{tabular}
                \end{table}
            }
        \end{tcolorbox}
    \end{frame}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%      Table of Contents slide      %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{subsection in toc}[subsections numbered]

\def\SlideTOC{
    \begin{frame}
        \frametitle{Table of Contents}
        \tableofcontents
    \end{frame}
}

\def\EnableCurrentTOC{
    \AtBeginSection[]{
        \begin{frame}[plain]
            \frametitle{Table of Contents}
            \tableofcontents[currentsection]
        \end{frame}
    }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%      References slide      %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{bibliography item}{\insertbiblabel}

\newcommand{\References}[1]{
    \begin{frame}[allowframebreaks]{References}
        \bibliographystyle{ieeetr}
        \bibliography{#1}
    \end{frame}
}
