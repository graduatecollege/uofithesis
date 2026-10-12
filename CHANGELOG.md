# Changelog

**Breaking changes** will be highlighted in each version, if there are any.
Breaking change would mean a change is needed in the `.tex` file to accommodate the changes in the document class.

## v1.8 - 2026-10-12

### Breaking Changes

- Line spacing for captions is not explicitly set to single-spaced. It was already
  single-spaced for most figures, but some placement modifiers don't work with
  the `setspace` package. If you want to use double spacing for captions, you will need to set it explicitly.
- The Table of Contents now only lists chapter titles by default; in-chapter
  headings (`\subsection`) are no longer included. To restore the previous
  behavior, add `\AtBeginDocument{\setcounter{tocdepth}{2}}` to your preamble.
- Figures, tables and equations are now numbered by chapter (e.g. Figure 2.1,
  Table 3.2, Equation (1.4)), and by appendix letter in appendices (e.g.
  Figure A.1). Text that refers to these items with hard-coded numbers instead of
  `\ref` will need to be updated. To keep the previous continuous numbering, use
  `\documentclass[continuousnumbering]{uofithesis}`.

## v1.7 - 2026-04-21

### Breaking Changes

#### Floats

`float` placement has been set to `H` by default for tables and figures. If you
previously relied on the default float placement, you may need to adjust your
tables and figures.

Wrapping floats in `Part` tags is no longer necessary, using `H` placement will
place them in the correct location in the document.

### Other Changes

- Fixed references to appendices using the wrong numbering. They now use the
  correct letter numbering by default.

## v1.6 - 2026-04-02

### Breaking Changes

- The optional Copyright page and the Title page are now counted for page numbers.
  If you're referring to specific page numbers in your document, you may need to
  update those references.

### Other Changes

- Added support for chapter-level references. Use `\sectionwithreferences` to
  create a section that has its own References subsection at the end.
  You may need to add `defernumbers=true` to your `biblatex` options.

## v1.5 - 2026-03-24

Added the `\dedication` environment for better handling of the dedication section.
To update an existing document to include a dedication, add the following
after your `\acknowledgements` if using that, or otherwise after the `\abstract` section:

```latex
% dedication uses begin and end syntax because it opens a center environment
% which needs to be closed
\begin{dedication}
    A dedication is optional.
\end{dedication}
```

## v1.4 - 2026-03-18

### Breaking Changes

Added the `\appendices` environment for better handling of appendices. This
both makes it easier to add appendices and fixes numbering and formatting issues.

To update your document, replace:

```diff
- % For an appendix without the chapter numbering, use \section* and add it to 
- % the table of contents manually with \addcontentsline
- \section*{Appendix A: Coffee Survey}
- \addcontentsline{toc}{section}{Appendix A: Coffee Survey}
+ \appendices{
+     \section{Coffee Survey}
```

Then subsections can be added as normal:

```latex
\subsection{Survey Questions}
```

## v1.3 - 2026-03-17

### Breaking Changes

- `fontsetup` has been moved from the document class to the template.
  Add `\usepackage{fontsetup}` to your `.tex` file to use the same fonts as before.

`fontsetup` tends to increase compilation time, so it is now optional. Include
fonts of your choice in the `.tex` file.

## v1.2 - 2026-03-03

Use the `pdfusetitle` option with `hyperref` instead of `hypersetup` for PDF metadata.

To update your document, remove `hypersetup:

```diff
-\AtBeginDocument{
-    \hypersetup{
-        pdftitle={\@title},
-        pdfauthor={\@author}
-    }
-}
```

And add the `pdfusetitle` option to the `hyperref` package:

```diff
-\usepackage[hidelinks]{hyperref}
+\usepackage[hidelinks,pdfusetitle]{hyperref}
```

## v1.1 - 2026-02-26

### Other Changes

These are *not* breaking changes.

- Add notes regarding TeXstudio usage.
- Remove `\subsubsection` from Table of Contents.
- Fix `\subsection` and `\subsubsection` formatting.
- Fix `\itemize` to not use `left-margin`, which isn't available in all environments.

## v1.0 - 2026-02-23

- Initial release.
