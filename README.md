# U of I Thesis Template

A LaTeX document class for University of Illinois Urbana-Champaign dissertations and theses, with special emphasis on accessibility and PDF/UA-2 compliance.

> [!IMPORTANT]
> This document class **is not compatible with the older `uiucthesis2021`** package,
> so it cannot be used as a direct replacement in an existing document.

> [!IMPORTANT]
> LaTeX PDF accessibility is constantly evolving, so this template is a work in progress.
> If you want to update the template, the [changelog](./CHANGELOG.md) will list all
> necessary changes to your document.

## In This README

- [Using This Template](#using-this-template)
- [Requirements](#requirements)
- [Building Your Document](#building-your-document)
- [Document Structure](#document-structure)
- [TeXstudio](#texstudio)
- [Package Groups and Accessibility](#package-groups-and-accessibility)
- [Accessibility Best Practices](#accessibility-best-practices)
- [Document Metadata](#document-metadata)
- [Customization](#customization)
- [File Organization](#file-organization)
- [Troubleshooting](#troubleshooting)

## Using This Template

### Overleaf

You can use this template on Overleaf, in which case you don't need to worry about installing TeX Live locally.

You **must have** a Standard, Professional, or Student license to use Overleaf, 
as the free version times out when building documents with the tagging system enabled.

1. Download the template as a ZIP file from the GitHub page.
2. Select *New project* -> *Upload project* on Overleaf and upload the ZIP file.
3. Open *Settings* using the gear icon in the bottom left, click the *Compiler* tab, and select "LuaLaTeX" from the *Compiler* dropdown menu.
4. Open `thesis.tex` and click "Recompile" to build the document.

#### TeX Live Version on Overleaf

It is **highly** recommended to use [Overleaf Labs](https://www.overleaf.com/labs/participate) to get access
to the Rolling Release. Make sure to change
the TeX Live version in the project settings to "Rolling Release" to use it.

Rolling Release versions are updated regularly with the latest TeX Live packages, 
which helps reduce build issues related to the tagging system.

### Local TeX Installation

We recommend cloning the repository to get started:

```bash
git clone https://github.com/graduatecollege/uofithesis.git
```

Or you can download the code as a ZIP file from the GitHub page.

> [!NOTE]
> Because accessible PDF generation is so new to the LaTeX ecosystem,
> downloading the template for your use is the most effective way
> to ensure you can customize and build your document without issues. We
> don't have plans to publish this class on CTAN until the tagging system 
> is more mature and stable.

## Requirements

This template requires an up to date TeX installation, recommended to be
**TeX Live 2026** or later.

### Installing TeX Live

Install the **latest available version of TeX Live** for your platform. It
must be at least TeX Live 2025 with up to date packages.

If you already have TeX Live installed, make sure it's fully up to date using
_TeX Live Manager GUI_, _TeX Live Utility_ or the `tlmgr` command line tool.

For complete instructions refer to the [TeX Live website](https://www.tug.org/texlive/).
Here are the basic steps for each platform:

#### Windows

Download and run the installer from https://www.tug.org/texlive/windows.html

#### macOS

```bash
# Install MacTeX (includes TeX Live)
# Download from https://www.tug.org/mactex/
# Or use Homebrew:
brew install --cask mactex
```

#### Linux

```bash
# Download the installer
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*

# Run the installer. Can take a long time.
sudo perl install-tl

# Add to PATH (add to ~/.bashrc or ~/.zshrc for persistence)
# Replace /path-to-texlive with the actual path where TeX Live was installed
export PATH=/path-to-texlive/bin/x86_64-linux:$PATH
export MANPATH=/path-to-texlive/texmf-dist/doc/man:$MANPATH
export INFOPATH=/path-to-texlive/texmf-dist/doc/info:$INFOPATH
```

## VS Code and LaTeX Workshop

To use this template in **Visual Studio Code** with the **LaTeX Workshop** extension,
the recommendation is to configure **LaTeX Workshop** to use
**LuaLaTeX** and **latexmk** for building the document.

1. Open VS Code settings (`Ctrl+,` or `Cmd+,` on macOS)
2. Search for `latex-workshop.latex.tools` and ensure you have a tool configured for `lualatex` using `latexmk`:
    ```json
    {
        "name": "lualatexmk",
        "command": "latexmk",
        "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-lualatex",
            "-outdir=%OUTDIR%",
            "%DOC%"
        ]
    },
    ```
3. Search for `latex-workshop.latex.recipes` and ensure you have a recipe configured that uses the `lualatexmk` tool defined above:
    ```json
    {
        "name": "latexmk (lualatex)",
        "tools": [
            "lualatexmk"
        ]
    },
    ```
4. Set this tool as the default builder in `latex-workshop.latex.recipes` so that building your document uses `latexmk` with `lualatex`.

You may also want to set `biblatex` as the Citation Backend for intellisense.

> [!NOTE]
> The magic comment `%! TEX program = lualatex` at the top of `thesis.tex` is a hint for certain editors
> to know they need to use `lualatex` to compile the document. That may interfere
> with editors using `latexmk`, so you can try removing it if you encounter conflicts with your build setup.

## TeXstudio

**TeXstudio** must be configured to use latexmk and LuaLaTeX to build the document properly:

1. Go to Options -> Configure TeXstudio
2. Under "Commands" find "Latexmk" near the bottom. Remove the "-pdf" flag which is forcing it to not use lualatex:
   `latexmk -silent -synctex=1 %`
3. Under "Build", change Default Compiler to "Latexmk"

The document should then compile.

This repository includes a TeXstudio completion word list (CWL) for the
class-specific macros defined by `uofithesis.cls`.

CWL file: `texstudio/uofithesis.cwl`

This is not required for the template to work, but it provides autocompletion
for the custom macros. To use it, copy the `uofithesis.cwl` file to your TeXstudio user completion directory:

- Windows: `%APPDATA%\texstudio\completion\user\`
- macOS/Linux: `~/.config/texstudio/completion/user/`

After copying the file, restart TeXstudio.

## Building Your Document

### Using latexmk (Recommended)

This repository includes a [`.latexmkrc`](./.latexmkrc) that's set up to use
the correct tools. You can build with:

```bash
latexmk thesis.tex
```

Clean build artifacts:

```bash
latexmk -c thesis.tex
```

### Without latexmk

Multiple tool runs are necessary to create all intermediate files and the bibliography:

```bash
lualatex thesis.tex
biber thesis
lualatex thesis.tex
lualatex thesis.tex
```

## Document Structure

[`thesis.tex`](./thesis.tex) is a sample for how to use the `uofithesis` class,
and includes comments and examples for all major features.

Not all elements are required, so remove any sections that don't apply to your document.
Optional parts include:

- Copyright Page
- Acknowledgements
- Appendix or Appendices

### Thesis vs Dissertation

By default, the class produces a dissertation. For a master's thesis:

```latex
\documentclass[thesis]{uofithesis}
```

## Package Groups and Accessibility

> [!WARNING]
> Always consult the [Tagging Status of LaTeX Packages](https://latex3.github.io/tagging-project/tagging-status/)
> before including a package in your document. If possible, choose a fully compatible package.

### Core Document Setup

The template uses packages that are, at time of writing, the best available for an accessible PDF output.

The [LaTeX Tagging Project](https://latex3.github.io/tagging-project/) is the foundation for an accessible PDF structure. It uses a `\DocumentMetadata` command to configure PDF/UA-2 tagging and accessibility features.

The Tagging Project is still under active development, and some features may be added or changed in future releases of TeX Live. The template is designed to be compatible with the latest stable release, but may require updates as the tagging system evolves.

### Mathematics (`unicode-math`)

**Required for accessible mathematics.** This package enables:

- MathML generation for screen reader compatibility
- Unicode math symbols for proper character encoding
- Modern OpenType math fonts
- Provides `amsmath` features with better accessibility support

> [!WARNING]
> Many packages often used with `amsmath` are not compatible with `unicode-math`,
> so always check the [Tagging Status of LaTeX Packages](https://latex3.github.io/tagging-project/tagging-status/)
> before including a package in your document.

`align`, `equation`, `gather`, `split`, `multline` and other `amsmath` environments 
are all supported and will be tagged properly.

```latex
Some body text.

\begin{align}
    E &= mc^2 \\
    F &= ma
\end{align}

Some more text...
```

If using float specifiers, see [About Floats](#about-floats).

### Graphics and Visualization

#### Core Graphics Packages

- **graphicx**: Standard image inclusion with alt-text support
- **tikz**: Programmatic diagrams with alt-text capability
- **pgfplots**: Data visualization with accessible color schemes

Note that `pgfplots` is not properly tagged and relies on alt text for accessibility.

Read [Alternative Text for Images](https://digitalaccessibility.illinois.edu/getting-started/accessibility-fundamentals/alternative-text-images) for best practices on writing alt text.

#### Accessible Color Schemes

The template defines WCAG AA compliant colors for charts:

```latex
\definecolor{aa-teal}{HTML}{168362}
\definecolor{aa-orange}{HTML}{C05402}
\definecolor{aa-blue}{HTML}{716CB2}
\definecolor{aa-pink}{HTML}{e7298a}
```

Use with pgfplots:

```
cycle list name=StrictAA,
```

#### Providing Alt Text

**All graphics must include alt text for accessibility:**

```latex
% For images
\begin{figure}
    \centering
    \includegraphics[width=0.6\textwidth,alt={Alt text}]{image.png}
    \caption{Image caption}
    \label{fig:image_label}
\end{figure}

% For TikZ diagrams and pgfplots
\begin{figure}
    \begin{tikzpicture}[alt={Description of diagram}]
```

If using float specifiers, see [About Floats](#about-floats).

Read [Alternative Text for Images](https://digitalaccessibility.illinois.edu/getting-started/accessibility-fundamentals/alternative-text-images) for best practices on writing alt text.

### Tables

Tables require proper header configuration for accessibility:

```latex
\begin{table}
    \caption{Table Caption}
    \tagpdfsetup{table/header-rows={1}}  % First row is header
    \begin{tabular}{|l|l|}
        \hline
        \textbf{Header 1} & \textbf{Header 2} \\
        \hline
        Data 1 & Data 2 \\
        \hline
    \end{tabular}
\end{table}
```

If using float specifiers, see [About Floats](#about-floats).

For tables with header columns:

```latex
\tagpdfsetup{table/header-columns={1},table/header-rows={1}}
```

#### Advanced Tables

Using colors and merged cells in tables are challenging for accessibility. If you
must use these features, note the following:

**If you need merged cells**, use `array` and `multirow`
for the best results. They tag merged cells correctly. **Does not support colored cells.**
[multirow example](https://github.com/graduatecollege/uofithesis/issues/6#issuecomment-4057268158)

**If you need colored cells**, you have two options:
- Use [`colortbl`](https://ctan.org/pkg/colortbl), which is compatible as of May 11, 2026.
- Use `nicematrix` with the `\CodeBefore` option to 
  apply colors. This tags merged cells as nested tables, which is problematic, but otherwise works. [nicematrix example](https://github.com/graduatecollege/uofithesis/issues/6#issuecomment-4041274456)

`tabularray` is **not** compatible and doesn't produce usable tables.

### Bibliography (`biblatex` + `biber`)

**Biber backend is required**.:

```latex
\usepackage[backend=biber,style=ieee]{biblatex}
\addbibresource{./references.bib}

% In document:
\printbibliography[heading=bibintoc,title={References}]
```

The `style` can be changed to match your field's requirements (apa, ieee, nature, etc.).

To print references at the end of each chapter instead, use the
`sectionwithreferences` environment from the class instead of `\section`:

```latex
\begin{sectionwithreferences}{Chapter Title}

Chapter text with citations \cite{example}.

\end{sectionwithreferences}
```

The `\end` is needed to properly close the `refsection` environment.
The References heading starts on a new page, even though ordinary subsections do not.

### Chemistry Packages

**Important limitation**: `mhchem` and `chemfig` are not fully compatible with accessibility tagging, but currently have no alternatives.

```latex
\usepackage[version=4]{mhchem}  % Chemical formulas: \ce{H2O}
\usepackage{chemfig}            % Molecular structures
```

Here's a sample for how to include a chemical structure with `chemfig`:

```latex
\begin{figure}
    \chemfig{...}
    \caption{Molecular structure}
\end{figure}
```

If using float specifiers, see [About Floats](#about-floats).

### Source Code Listings

The `listings` package will not compile with tagging enabled.

`minted` is an alternative that can be used. It requires Python 3.13 or earlier to be installed.

See [Issue #5](https://github.com/graduatecollege/uofithesis/issues/5) for discussion on this.

### Algorithms and Pseudocode

The `algorithmic`, `algorithmicx` and `algpseudocode` packages are compatible with tagging and can 
be used for algorithms and pseudocode. [algpseudocode example](https://github.com/graduatecollege/uofithesis/issues/8#issuecomment-4057284694)

### Other Utilities

- **csquotes**: Proper quotation handling (recommended with babel)
- **hyperref**: PDF hyperlinks (use `hidelinks` option to avoid colored boxes)
- **footmisc**: Footnote positioning control

## Accessibility Best Practices

### Always Use Sectioning

Use LaTeX's sectioning commands rather than manual formatting:

```latex
% Good
\section{Chapter Title}
\subsection{Section Title}

% Bad - will not be tagged properly
{\large\bfseries Manual Heading}
```

The PDF output will have a `<Title>` tag for the document title, and `<H1>` tags 
for top-level sections. This is consistent with PDF UA-2, and it is practically
impossible to make LaTeX Tagging do anything else.

> [!NOTE]
> The `uofithesis` class uses the `report` document class as its base,
> which uses `\section` rather than `\chapter` for top-level sections. This is
> intentional to meet the Graduate College formatting standards, as the
> `\chapter` command adds extra vertical space and page breaks that are not allowed.

### About Floats

The LaTeX Tagging system does not currently fully support floats, so most float
environments are in the wrong order in the underlying PDF structure. That makes
it hard for assistive technologies to read them in the correct order. The best 
way to mitigate this is to use the `H` float specifier from the `float` package, 
which places the float "here" and tags it in the correct order in the PDF structure.

The `uofithesis` class includes `float` and sets `H` as the default placement 
for figures and tables, so you can just use `\begin{figure}` and `\begin{table}`.

If you need to use other float specifiers, be aware that the PDF structure will 
not match the visual order of the document.

> [!NOTE]
> Previous versions of this template used `\tagstructbegin` and `\tagstructend`
> to manually wrap floats with `Part` elements. This is no longer necessary.

> [!WARNING]
> Figures inside `H` floats still have issues with the order of the elements,
> so VeraPDF will alert that the document is not fully compliant with PDF/UA-2.
> See [Current float defaults fail PDF/UA2](https://github.com/graduatecollege/uofithesis/issues/30) for discussion.

### Provide Meaningful Alt Text

Read [Alternative Text for Images](https://digitalaccessibility.illinois.edu/getting-started/accessibility-fundamentals/alternative-text-images) for best practices on writing alt text.

### Use Raggedright

The template sets `\raggedright` by default, which is recommended for accessibility as it:
- Improves readability for dyslexic readers
- Prevents awkward spacing in justified text
- Maintains consistent word spacing

## Document Metadata

The template automatically configures document metadata for accessibility:

```latex
\DocumentMetadata{
    lang=en,
    pdfstandard=ua-2,
    tagging=on,
    tagging-setup={
        math/setup={mathml-AF,mathml-SE},
        extra-modules={verbatim-mo},
    }
}
```

PDF title is set with the `pdfusetitle` option in `hyperref`:

```latex
\usepackage[hidelinks,pdfusetitle]{hyperref}
```

## Customization

### Changing Fonts

The template uses `fontsetup` which configures sensible defaults. To use specific fonts:

```latex
\setmainfont{Stix Two Text}
```

### Section Formatting

All sections are automatically formatted per Graduate College requirements:

- 12pt bold font
- Centered
- Numbered as "Chapter N"
- Each chapter starts on a new page
- Sections within chapters do not start on new pages

### Chapter References

If you want a bibliography at the end of each chapter, wrap that chapter in a
`sectionwithreferences` environment.

## File Organization

You can split the document into multiple files for better organization. The main `thesis.tex` file should include the preamble and the overall structure, while individual chapters can be placed in separate `.tex` files.

Use `\input{chapters/chapter1.tex}` or similar to include chapter files.

## Troubleshooting

### Build Errors

#### Update TeX Live / LaTeX Distribution

Make sure your distribution of TeX Live (or MikTeX, MacTeX, etc.) is up to date.
Use the newest available version.

On Overleaf, use [Overleaf Labs](https://www.overleaf.com/labs/participate) to enable the Rolling Release, which provides access to the most up-to-date TeX Live environment.

#### Error: "Undefined control sequence"

- Update to the most up-to-date TeX Live version. For Overleaf, see below.
- Older versions don't support the LaTeX Tagging Project.

#### Strange build errors after adding a package

- Check the [Tagging Status of LaTeX Packages](https://latex3.github.io/tagging-project/tagging-status/) to ensure compatibility
- Incompatible packages can fail for reasons not immediately obvious when used with tagging

#### Errors and warnings in Overleaf

Enabling [Overleaf Labs](https://www.overleaf.com/labs/participate) to get access 
to the Rolling Release can reduce build issues related to the tagging system.

### Slow To Compile

The tagging system is still new and can be slow to compile, especially with 
large documents. To speed up compilation when working on the document:

- Remove packages from thesis.tex that you're not using, for example mhchem and chemfig
- Replace `tagging=on` with `tagging=off`. Note that this needs to be on for the final document.
- Remove `fontsetup`, which tends to increase compilation time. If using v1.2 of this template or earlier, remove it from `uofithesis.cls`.
- Enable Draft mode. In Overleaf this is in the Recompile drop-down as "Compile mode: Fast [draft]"
- Use [/includeonly](https://en.wikibooks.org/wiki/TeX/includeonly) to only compile the chapter you're working on.
- If you have a lot of TikZ graphics and diagrams, the Overleaf docs on [Reducing the compile time for diagrams](https://docs.overleaf.com/troubleshooting-and-support/fixing-and-preventing-compile-timeouts/reducing-the-compile-time-for-diagrams) may help.

### Known Adobe Acrobat Accessibility Issues

- Adobe Acrobat repeats the "link" word multiple times with NVDA, e.g. "link link link link Chapter 1".
- Alt text for graphics is only read up to 90 characters at a time, after which it repeats the word "graphic" and then reads the next bit.
- NVDA requires MathCAT to read math in Adobe Acrobat, and supports navigating equations.
- JAWS does not allow navigating equations in Acrobat, and reads the entire equation as one block of text.
- Complex tables with merged cells almost always have problems being read correctly in Acrobat, even with proper header configuration.

## Dissertation/Thesis Support

For general requirements and other support, refer to the
[Graduate College Thesis & Dissertation](https://grad.illinois.edu/academics/thesis-dissertation)
website.

## License

MIT licensed. Copyright (c) 2026 University of Illinois Board of Trustees.
