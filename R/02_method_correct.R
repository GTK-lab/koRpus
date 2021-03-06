# Copyright 2010-2017 Meik Michalke <meik.michalke@hhu.de>
#
# This file is part of the R package koRpus.
#
# koRpus is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# koRpus is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with koRpus.  If not, see <http://www.gnu.org/licenses/>.


#' Methods to correct koRpus objects
#' 
#' The method \code{correct.tag} can be used to alter objects of class \code{\link[koRpus]{kRp.tagged-class}}.
#'
#' Although automatic POS tagging and lemmatization are remarkably accurate, the algorithms do ususally produce
#' some errors. If you want to correct for these flaws, this method can be of help, because it might prevent you from
#' introducing new errors. That is, it will do some sanitiy checks before the object is actually manipulated and returned.
#'
#' \code{correct.tag} will read the \code{lang} slot from the given object and check whether the \code{tag}
#' provided is actually valid. If so, it will not only change the \code{tag} field in the object, but also update
#' \code{wclass} and \code{desc} accordingly.
#'
#' If \code{check.token} is set it must also match \code{token} in the given row(s). Note that no check is done on the lemmata.
#'
#' @param obj An object of class \code{\link[koRpus]{kRp.tagged-class}}, \code{\link[koRpus]{kRp.txt.freq-class}},
#'    \code{\link[koRpus]{kRp.analysis-class}}, or \code{\link[koRpus]{kRp.txt.trans-class}}.
#' @param row Integer, the row number of the entry to be changed. Can be an integer vector
#'    to change several rows in one go.
#' @param tag A character string with a valid POS tag to replace the current tag entry.
#'    If \code{NULL} (the default) the entry remains unchanged.
#' @param lemma A character string naming the lemma to to replace the current lemma entry.
#'    If \code{NULL} (the default) the entry remains unchanged.
#' @param check.token A character string naming the token you expect to be in this row.
#'    If not \code{NULL}, \code{correct} will stop with an error if this values don't match.
#' @return An object of the same class as \code{obj}.
# @author m.eik michalke \email{meik.michalke@@hhu.de}
#' @keywords methods
#' @seealso \code{\link[koRpus]{kRp.tagged-class}}, \code{\link[koRpus:treetag]{treetag}},
#'    \code{\link[koRpus:kRp.POS.tags]{kRp.POS.tags}}.
#' @examples
#' \dontrun{
#' tagged.txt <- correct.tag(tagged.txt, row=21, tag="NN")
#' }
#' @export
#' @docType methods
#' @rdname correct-methods
setGeneric("correct.tag", function(obj, row, tag=NULL, lemma=NULL, check.token=NULL){standardGeneric("correct.tag")})

#' @export
#' @docType methods
#' @rdname correct-methods
#' @aliases correct.tag correct.tag,kRp.taggedText-method
#' @include 01_class_01_kRp.tagged.R
#' @include 01_class_03_kRp.txt.freq.R
#' @include 01_class_04_kRp.txt.trans.R
#' @include 01_class_05_kRp.analysis.R
#' @include koRpus-internal.R
setMethod("correct.tag",
    signature(obj="kRp.taggedText"),
    function (obj, row, tag=NULL, lemma=NULL, check.token=NULL){

      if(!is.numeric(row)){
        stop(simpleError("Not a valid row number!"))
      } else {}

      local.obj.copy <- obj
      lang <- obj@lang

      if(!is.null(tag)){
        # before we attempt anything, let's check if this is a valid tag
        valid.POS.tags <- kRp.POS.tags(lang, list.tags=TRUE)
        if(is.na(match(tag, valid.POS.tags))){
          stop(simpleError(paste0("Not a valid POS tag for language \"", lang, "\": ", tag)))
        } else {}
        all.POS.tags <- kRp.POS.tags(lang)
        # this object will hold the columns "tag", "wclass" and "desc" for our tag
        new.tag <- all.POS.tags[all.POS.tags[,"tag"] == tag, ]
        for (cur.row in row){
          if(!is.null(check.token) & !identical(local.obj.copy@TT.res[cur.row, "token"], check.token)){
            stop(simpleError(paste0("In row ", cur.row,", expected \"", check.token,"\" but got \"", local.obj.copy@TT.res[cur.row, "token"],"\"!")))
          } else {}
          local.obj.copy@TT.res[cur.row, c("tag","wclass","desc")] <- new.tag[c("tag","wclass","desc")]
        }
      } else {}
      if(!is.null(lemma)){
        for (cur.row in row){
          if(!is.null(check.token) & !identical(local.obj.copy@TT.res[cur.row, "token"], check.token)){
            stop(simpleError(paste0("In row ", cur.row,", expected \"", check.token,"\" but got \"", local.obj.copy@TT.res[cur.row, "token"],"\"!")))
          } else {}
          local.obj.copy@TT.res[cur.row, "lemma"] <- lemma
        }
      } else {}

      # update descriptive statistics
      local.obj.copy@desc <- basic.tagged.descriptives(local.obj.copy, lang=lang, desc=local.obj.copy@desc, update.desc=TRUE)

      cat("Changed\n\n")
      print(obj@TT.res[row, ])
      cat("\n  into\n\n")
      print(local.obj.copy@TT.res[row, ])

      return(local.obj.copy)
    }
)
