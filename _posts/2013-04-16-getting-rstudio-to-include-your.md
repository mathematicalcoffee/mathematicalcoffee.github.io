---
layout:   post
title:    "Getting RStudio to include your `R_LIBS_USER` in its library paths."
date:     2013-04-16 19:29 +1000
comments: true
categories: ~
tags: [knitr, R, RStudio]
authors: [amy]
---
### Getting RStudio to include your `R\_LIBS\_USER` in its library paths.

I recently installed [RStudio](http://www.rstudio.com/) Desktop version on my Linux computer, as I wanted to test it out.Previously I'd been happily using R from the command-line.

However, it kept complaining that I didn't have the [`knitr`](http://yihui.name/knitr/) package installed.

Starting `R` from the command-line, I found that I _did_ have knitr installed - `library(knitr)` worked fine!But `library(knitr)` from RStudio gave the errror:

    Error in library(knitr) : there is no package called ‘knitr’

Upon further inspection, I realised that my package library paths were between R-command-line and RStudio, despite the R executable being identical between the two.

My usual R library for command-line R is `~/R/library`, and this was in the `.libPaths()` as expected (executed from R from the command line).

However, when I executed `.libPaths()` from RStudio, I got:

    [1] "/usr/local/lib/R/site-library" "/usr/lib/R/site-library"
    [3] "/usr/lib/R/library" "/usr/lib/rstudio/R/library"

So why did the same R binary produce different library paths?

It turns out that I set my default path `~/R/library` by setting my `R_LIBS_USER` environment variable in my `.bashrc` file:

    export R_LIBS_USER=$HOME/R/library

but RStudio was not reading my `.bashrc` file when it started up (makes sense I guess, as it's not running from the terminal).

The solution was to create a file `~/.Renviron` and set the `R_LIBS_USER` variable there.R looks for this file upon starting up to set environment variables (see also [`?Startup`](http://stat.ethz.ch/R-manual/R-patched/library/base/html/Startup.html)):

    R_LIBS_USER=~/R/library

(Note - I could also just do `.libPaths(c('~/R/library', .libPaths())` in an `.Rprofile` file, but I don't use those in general).

Now I start up RStudio and hey presto! It all works.

Thanks to the folk at [StackOverflow](http://stackoverflow.com/), in particular [flodel](http://stackoverflow.com/users/1201032/flodel) and [Dirk EddelBuettel](http://stackoverflow.com/users/143305/dirk-eddelbuettel), who helped me work this out (the question has probably been deleted since then as it was too localized and probably should have been asked at the [RStudio support page](http://support.rstudio.org/help/discussions)).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2013-04-16T19:29:00-07:00">19:29</abbr>](getting-rstudio-to-include-your.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=2999602835624008125&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2999602835624008125&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2999602835624008125&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2999602835624008125&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2999602835624008125&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2999602835624008125&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2013/04/getting-rstudio-to-include-your.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [knitr](../../search/label/knitr.html), [R](../../search/label/R.html), [RStudio](../../search/label/RStudio.html)

