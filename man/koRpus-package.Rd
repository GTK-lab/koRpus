% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/koRpus-package.R
\docType{package}
\name{koRpus-package}
\alias{koRpus-package}
\title{The koRpus Package}
\description{
An R Package for Text Analysis.
}
\details{
\tabular{ll}{
Package: \tab koRpus\cr
Type: \tab Package\cr
Version: \tab 0.11-2\cr
Date: \tab 2018-01-07\cr
Depends: \tab R (>= 2.10.0),sylly (>= 0.1-4)\cr
Enhances: \tab rkward\cr
Encoding: \tab UTF-8\cr
License: \tab GPL (>= 3)\cr
LazyLoad: \tab yes\cr
URL: \tab https://reaktanz.de/?c=hacking&s=koRpus\cr
}

A set of tools to analyze texts. Includes, amongst others, functions for automatic
language detection, hyphenation, several indices of lexical diversity (e.g.,
      type token ratio,
HD-D/vocd-D, MTLD) and readability (e.g., Flesch, SMOG, LIX, Dale-Chall). Basic import
functions for language corpora are also provided,
      to enable frequency analyses (supports Celex
and Leipzig Corpora Collection file formats) and measures like tf-idf. Support for
additional languages can be added on-the-fly or by plugin packages. Note: For full functionality
a local installation of TreeTagger is recommended. After installation, additional
language support needs to be fetched from the 'l10n' repository
<https://undocumeantit.github.io/repos/l10n>. It is recommended to add it to your list of package repositories permanently,
to receive updates for these packages and be able to install support for further
languages. 'koRpus' also includes a plugin for the R GUI and IDE RKWard,
      providing graphical
dialogs for its basic features. The respective R package 'rkward' cannot be installed directly
from a repository, as it is a part of RKWard. To make full use of this feature, please
install RKWard from <https://rkward.kde.org> (plugins are detected automatically). Due to
some restrictions on CRAN, the full package sources are only available from the project
homepage. To ask for help, report bugs, request features,
      or discuss the development of the
package, please subscribe to the koRpus-dev mailing list (<http://korpusml.reaktanz.de>).
}
\author{
Meik Michalke, with contributions from Earl Brown, Alberto Mirisola, Alexandre Brulet,
      Laura Hauser
}
\keyword{package}
