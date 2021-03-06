\name{c.timeline}
\alias{c.timeline}
\alias{[.timeline}
\alias{[<-.timepoint}
\alias{[[.timeline}
\alias{as.character.timepoint}
\alias{as.chartime.numeric}
\alias{as.chartime}
\alias{as.numeric.chartime}
\alias{print.timepoint}
\alias{seq.timeline}
\alias{rep.timeline}
\title{Support for timepoint Classes}
\description{
  These functions support classes timepoint, timeline, time, date, and datetime
  (and related functions).  They are mostly S3 methods for base R generics.
}
\usage{
\method{c}{timeline}(..., recursive = FALSE)
\method{[}{timeline}(x, ..., drop = TRUE)
\method{[}{timepoint}(x, ...) <- value
\method{[[}{timeline}(x, ..., drop = TRUE)
\method{as.character}{timepoint}(x, ...)
as.chartime(x, ...)
\method{as.chartime}{numeric}(x, format, mark=TRUE,...)
\method{as.numeric}{chartime}(x, format,...)
\method{print}{timepoint}(x, ...)
\method{rep}{timeline}(x, ...)
\method{seq}{timeline}(from, to, by, length.out, along.with, ...)
}

\arguments{
  \item{\dots}{arguments to \code{c}, or passed to other functions}
  \item{recursive}{same meaning as for \code{c}}
  \item{x}{object of class timepoint}
  \item{drop}{same meaning as for \sQuote{[} and \sQuote{[[}}
  \item{value}{value to be assigned, as for \sQuote{[<-}}
  \item{format}{input or output format describing character time (see \code{\link{strftime}})}
  \item{mark}{boolean: mark times with dangling seconds using \sQuote{+}}
  \item{from}{as for \code{\link{seq.default}}}
  \item{to}{as for \code{\link{seq.default}}}
  \item{by}{as for \code{\link{seq.default}}}
  \item{length.out}{as for \code{\link{seq.default}}}
  \item{along.with}{as for \code{\link{seq.default}}}
}
\details{
  Normally you shouldn't need to worry about these functions.  \code{c} and the \sQuote{[}
  variants exist just so that class information is not lost on invocation of the
  generic.  \code{as.character.timepoint} and \code{print.timepoint} just call \code{format}.
  \code{chartime} variants are used internally by other functions.  \code{seq.timeline}
  requires \code{from}. If an interval cannot be calculated from supplied arguments,
  \code{by} is set to 1 hour for \code{time} or 1 day for \code{date} or \code{datetime}.
}
\value{
  \item{print}{an invisible object with same class as \code{x}}
  \item{as.chartime}{generic: does not return}
  \item{as.chartime.numeric}{character (time)}
  \item{as.numeric.chartime}{numeric (seconds)}
  \item{as.character.timepoint}{character (time)}
  \item{others}{object with same class as \code{x}}
}
\author{Tim Bergsma}
\seealso{
	\itemize{
		\item \code{\link{timepoint}}
		\item \code{\link{seq.default}}
		\item \code{\link{strftime}}
	}
}
\examples{

#as.data.frame
data.frame(
	dt=as.datetime(seq(from=0,by=86500,length.out=3)),
	d=as.date(seq(from=0,by=86400,length.out=3)),
	t=as.time(c(60,120,180))
)
#                  dt          d     t
# 1  1970-01-01 00:00 1970-01-01 00:01
# 2 1970-01-02 00:01+ 1970-01-02 00:02
# 3 1970-01-03 00:03+ 1970-01-03 00:03

#combine
c(as.time(0),as.time(60))
# 00:00 00:01
c(as.date(0),as.date(86400))
# 1970-01-01 1970-01-02
c(as.datetime(0),as.datetime(86500))
# 1970-01-01T00:00  1970-01-02T00:01+

#subset
as.time(c('08:00','09:00'))[2]
# 09:00
as.date(c('2008-01-01','2008-01-04'))[2]
# 2008-01-04
as.datetime(c('2008-01-01T12:00','2008-01-04T12:30'))[2]
# 2008-01-04 12:30

#element selection
as.time(c('08:00','09:00'))[[2]]
# 09:00
as.date(c('2008-01-01','2008-01-04'))[[2]]
# 2008-01-04
as.datetime(c('2008-01-01T12:00','2008-01-04T12:30'))[[2]]
# 2008-01-04 12:30

#assignment
a <- as.time(seq(60,300, by=60))
a#00:01 00:02 00:03 00:04 00:05
a[5] <- 60
a#00:01 00:02 00:03 00:04 00:01
a[3] <- NA
a#00:01 00:02 <NA>  00:04 00:01

#identity
as.time(as.time(0))
# 00:00
as.date(as.date(0))
# 1970-01-01
as.datetime(as.datetime(0))
# 1970-01-01T00:00

#repetition
rep(as.time(86340),2)
# 23:59 23:59

#sequence
seq(from=as.time('00:00'),length.out=3)
seq(from=as.time('00:00'),by=as.time('00:05'),length.out=3)
seq(from=as.time('00:00'),by=as.time('00:05'),along.with=integer(3))
seq(from=as.time('00:00'),to=as.time('06:00'))
seq(from=as.time('00:00'),to=as.time('06:00'),by=as.time('02:00'))
seq(from=as.time('00:00'),to=as.time('06:00'),length.out=4)

}
\keyword{manip}
