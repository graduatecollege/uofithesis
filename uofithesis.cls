\NeedsTeXFormat{LaTeX2e}[2025/11/01]
\ProvidesClass{uofithesis}[2026/04/21 v1.7 University of Illinois Graduate College Dissertation/Thesis Class]

\LoadClass[letterpaper,12pt,oneside]{article}

\RequirePackage[english]{babel}
\RequirePackage{geometry}
\RequirePackage{setspace}
% sectsty is partially compatible with tagging, don't use \sectionrule
\RequirePackage{sectsty}
\RequirePackage{float}

\floatplacement{figure}{H}
\floatplacement{table}{H}
% setspace doesn't work with H placement, so we manually set the line spacing
\g@addto@macro\@floatboxreset{\def\baselinestretch{\setspace@singlespace}\normalsize}

% pgfplots configuration for accessible color schemes
\RequirePackage{etoolbox}
\AtEndPreamble{
    \@ifpackageloaded{pgfplots}{
        \usepgfplotslibrary{colorbrewer}
        % Qualitative color scheme from https://colorbrewer2.org/
        % Color-blind friendly, adjusted for WCAG AA contrast
        \definecolor{aa-teal}{HTML}{168362}
        \definecolor{aa-orange}{HTML}{C05402}
        \definecolor{aa-blue}{HTML}{716CB2}
        \definecolor{aa-pink}{HTML}{e7298a}

        \pgfplotscreateplotcyclelist{StrictAA}{
            {aa-teal, fill=aa-teal, draw=black},
            {aa-orange, fill=aa-orange, draw=black},
            {aa-blue, fill=aa-blue, draw=black},
            {aa-pink, fill=aa-pink, draw=black}
        }
    }{}
}

% Styles

\newgeometry{margin=1in}
\allsectionsfont{\normalfont\bfseries\fontsize{12pt}{14.4pt}\selectfont\centering}
\subsectionfont{\normalfont\bfseries\fontsize{12pt}{14.4pt}\selectfont\raggedright}
\subsubsectionfont{\normalfont\bfseries\fontsize{12pt}{14.4pt}\selectfont\raggedright}
\AddToHook{cmd/section/before}{\clearpage}

% Options for the title page
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\concentration}[1]{\def\@concentration{#1}}
\newcommand{\minor}[1]{\def\@minor{#1}}
\newcommand{\degreeyear}[1]{\def\@degreeyear{#1}}
\newcommand{\committee}[1]{\def\@committee{#1}}
\newcommand{\earneddegree}[1]{\def\@earneddegree{#1}}
\newcommand{\committeetitle}[1]{\def\@committeetitle{#1}}

% Copyright page option
\newif\if@copyrightpage
\@copyrightpagefalse % Default to no copyright page
\newcommand{\copyrightpage}{\@copyrightpagetrue}

\newif\ifdissertation
\dissertationtrue % Default to dissertation
\DeclareOption{thesis}{\dissertationfalse}
\ProcessOptions\relax

\def\@degreetext{Submitted in partial fulfillment of the requirements\\for the degree of}
\def\@degreelevel{}

% Customized title page environment to keep them in page number counts
\newenvironment{thesis@titlepage}
{%
    \if@twocolumn
    \@restonecoltrue\onecolumn
    \else
    \@restonecolfalse\newpage
    \fi
    \thispagestyle{empty}%
}%
{\if@restonecol\twocolumn \else \newpage \fi}

% Make the title according to Graduate College formatting requirements
\renewcommand{\maketitle}{%
    \if@copyrightpage
    \begin{thesis@titlepage}
        \vspace*{\fill}
        \begin{center}
            \textcopyright\ \@degreeyear\ \@author
        \end{center}
        \vspace*{\fill}
    \end{thesis@titlepage}
    \fi
    \begin{thesis@titlepage}
        \newgeometry{margin=1in,vmargin={1.3in,1in}}
        \linespread{1.2}
        \begin{center}%
            \vbox to 3.5in{%
                \tagstructbegin{tag=Title}
                \tagmcbegin{tag=Title}
                % Disable automatic tagging, otherwise a P gets inserted inside the Title
                \tagpdfsetup{para/tagging=false}

                {\fontsize{12pt}{14.4pt}\selectfont \bfseries \@title}

                \tagpdfsetup{para/tagging=true}
                \tagmcend
                \tagstructend

                \vskip 12pt

                by \par

                \vskip 12pt

                {\@author \par}
                \vfill
            }

            % Set defaults based on dissertation vs thesis
            \ifdissertation
            \ifdefined\@department
            \gdef\@degreelevel{ Doctor of Philosophy in \@department}
            \fi
            \gdef\@thesislabel{Dissertation}
            \gdef\@defaultcommitteetitle{Doctoral Committee:}
            \else
            \ifdefined\@department
            \gdef\@degreelevel{ Master of Science in \@department}
            \fi
            \gdef\@thesislabel{Thesis}
            \gdef\@defaultcommitteetitle{Master's Committee:}
            \fi

            % Use custom earned degree if set, otherwise use default
            \ifdefined\@earneddegree
            \gdef\@degreelevel{ \@earneddegree}
            \fi

            % Use custom committee title if set, otherwise use default
            \ifdefined\@committeetitle\else
            \gdef\@committeetitle{\@defaultcommitteetitle}
            \fi

            {\@thesislabel\par}
            \vspace{12pt}
            \@degreetext
            \@degreelevel\\
            \ifdefined\@concentration
            with a concentration in \@concentration\\
            \fi
            \ifdefined\@minor
            with a minor in \@minor\\
            \fi
            in the Graduate College of the\\
            University of Illinois Urbana-Champaign, \@degreeyear\par
            \vspace{12pt}
            \vbox to 0.4in{%
                {Urbana, Illinois\par}
                \vfill
            }%
        \end{center}%
        \begin{flushleft}
            {\@committeetitle\par}
            \setlength{\leftmargini}{0.5in}
            \begin{itemize}[label={}]
                    \setlength{\itemsep}{0pt}
                    \setlength{\parskip}{0pt}
                    \setlength{\parsep}{0pt}
                    \@committee
            \end{itemize}
        \end{flushleft}
        \par
        \restoregeometry
    \end{thesis@titlepage}
}

% Abstract environment
\renewenvironment{abstract}{%
    \thispagestyle{plain}
    \section*{Abstract}
    \vspace{12pt}
    \doublespacing
}{%
}

% Acknowledgements environment
\newenvironment{acknowledgements}{%
    \thispagestyle{plain}
    \section*{Acknowledgements}
    \vspace{12pt}
    \doublespacing
}{%
}

% Dedication environment
\newenvironment{dedication}{%
    \clearpage
    \thispagestyle{plain}
    \vspace*{\fill}
    \begin{center}
        \itshape
    }{%
    \end{center}
    \vspace*{\fill}
    \clearpage
}

% Adjust ToC line height
% tableofcontents adds its own spacing on top of line height, hence the 12pt line height
\let\thesis@tableofcontents=\tableofcontents
\def\tableofcontents{{\fontsize{12pt}{12pt}\selectfont\thesis@tableofcontents}}

\renewcommand{\thesection}{Chapter \arabic{section}}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}

% Only include chapter-level (\section) headings in the ToC.
\AtBeginDocument{\setcounter{tocdepth}{1}}
\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{5em}}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{3em}{2.5em}}

\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{5em}}
\renewcommand*{\l@subsection}{\@dottedtocline{2}{3em}{2.5em}}

% Print the references for the current biblatex refsection.
\newcommand{\chapterreferences}{%
    \@ifpackageloaded{biblatex}{%
        \clearpage
        \printbibliography[heading=subbibintoc,title={References}]%
    }{%
        \ClassError{uofithesis}{\string\chapterreferences\space requires biblatex}{%
            Load biblatex before using \string\chapterreferences.
        }%
    }%
}

% Environment for chapters with end-of-chapter references.
\newenvironment{sectionwithreferences}[1]{%
    \@ifpackageloaded{biblatex}{%
        \begin{refsection}%
        \section{#1}%
    }{%
        \ClassError{uofithesis}{sectionwithreferences requires biblatex}{%
            Load biblatex before using the sectionwithreferences environment.
        }%
    }%
}{%
    \@ifpackageloaded{biblatex}{%
        \chapterreferences%
        \end{refsection}%
    }{}%
}

% Appendix environment that resets numbering and uses A, B, C...
% instead of 1, 2, 3... for sections.
\newcounter{appendix}
\newenvironment{appendices}{%
    \setcounter{appendix}{0}%
    \renewcommand{\theappendix}{\Alph{appendix}}%
    \renewcommand{\thesection}{Appendix \Alph{appendix}}%
    \renewcommand{\thesubsection}{\Alph{appendix}.\arabic{subsection}}%
    \renewcommand{\section}[1]{%
        \refstepcounter{appendix}%
        \setcounter{subsection}{0}%
        \clearpage%
        \phantomsection%
        \addcontentsline{toc}{section}{Appendix \Alph{appendix}: ##1}%
        \begin{center}%
            {\normalfont\bfseries\fontsize{12pt}{14.4pt}\selectfont
            Appendix \Alph{appendix}: ##1\par}%
        \end{center}%
        \vspace{12pt}%
    }%
}{%
    \renewcommand{\thesection}{Chapter \arabic{section}}%
    \renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}%
    \renewcommand{\section}{\@startsection{section}{1}{\z@}%
        {-3.5ex \@plus -1ex \@minus -.2ex}%
        {2.3ex \@plus.2ex}%
    {\normalfont\bfseries\fontsize{12pt}{14.4pt}\selectfont\centering}}%
}