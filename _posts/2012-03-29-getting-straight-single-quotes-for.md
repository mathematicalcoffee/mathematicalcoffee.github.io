---
layout:   post
title:    "Getting straight single quotes for code/verbatim in Sweave/knitr"
date:     2012-03-29 05:32
comments: true
categories: ~
tags: knitr,latex,R,sweave
authors: [mathematical.coffee]
---
### Getting straight single quotes for code/verbatim in Sweave/knitr

**Update 16 April 2012: Yihiu has [fixed this](https://github.com/yihui/knitr/commit/b4934de5eb769437cf8c080cd11c2c4366d3e7a7) from knitr 0.5! Thanks!**

I've recently started using [knitr](http://yihui.name/knitr/) to write reports, mainly about code I've written in R.

One thing that I insist upon in documentation on code is that code snippets _within_ the document be able to be copy-and-pasted easily so the user can follow along.

This is why I don't like having the following in my documents:

    > words <- c('Hello','world!')
    > paste(words)
    [1] "Hello" "world!"

If the user wants to perform the code I've just written, they can't simply select everything and copy-paste; the `>` symbols are going to get in the way.

I much prefer something like this:

    words <- c('Hello','world!')
    paste(words)
    ## "Hello" "world!"

This is why I like knitr as opposed to [Sweave](http://www.statistik.lmu.de/~leisch/Sweave/) on which it is based; knitr seems to be more flexible in suppressing the leading `>` in input commands, and putting comments (`##`) in front of the outputs.

However, knitr has an annoying drawback that Sweave doesn't when it comes to typesetting code: a single quote mark/apostrophe `'` in Sweave will stay as such in the output; in knitr, it will be converted to a left or right single quote.

By default, LaTeX will change "straight" single quotes ' into left ‘ and right ’ single quotes that are curled depending on whether the quote is open or closed.

If you try and copy-paste these into a terminal you will run into trouble, and R will complain about "unexpected input in "??"", where the "??" may be a funny looking symbol (depending on your terminal) that basically means "I don't understand this fancy symbol you gave me!"

Now, Sweave has some way of dealing with this. It converts all of these funky quotes into normal straight quotes that can be safely copy-pasted into R. Knitr doesn't.

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-9Du4GWxLxX8/T3RUdvOhOzI/AAAAAAAABRw/vy0XzEihdyk/s1600/sweaveCurlyQuotes.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="42" src="http://2.bp.blogspot.com/-9Du4GWxLxX8/T3RUdvOhOzI/AAAAAAAABRw/vy0XzEihdyk/s320/sweaveCurlyQuotes.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">weird curly quotes in knitr</td></tr>
</tbody>

How to fix this? Well, there is a LaTeX package [upquote](http://www.ctan.org/tex-archive/macros/latex/contrib/upquote) that converts all single quotes that occur in a verbatim environment (or `\verb` commands) from left/right single quotes into straight single quotes.

It uses the textcomp package to access the command `\textquotesingle` which is the straight single quote (it also does backticks via `\textasciigrave`). The upquote package basically says "if you encounter a quote in a verb-like environment, make sure it's `\textquotesingle`!".

So how does this tie into getting straight quotes in Sweave/knitr? Easy: add `\usepackage{upquote}` and a fairly arcane command to your preamble:

    \documentclass{article}
    \usepackage{upquote} % to convert funny quotes to straight quotes
    \setbox\hlnormalsizeboxsinglequote=\hbox{\normalsize\verb.'.}%
    \begin{document}
    <<eval=TRUE,echo=TRUE,tidy=FALSE>>=
        words <- c('Hello','world!')
    @
    \end{document}

Now you can just run knitr on this and then pdflatex, and voila! Straight quotes.

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-C-MmdMEvAvw/T3RTqwjfr1I/AAAAAAAABRk/ru7iim6W7QY/s1600/sweavestraightquotes.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="30" src="http://1.bp.blogspot.com/-C-MmdMEvAvw/T3RTqwjfr1I/AAAAAAAABRk/ru7iim6W7QY/s320/sweavestraightquotes.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">straight quotes in knitr!</td></tr>
</tbody>

### How does this work? 

For the more TeX-inclined among you, this is why it works.

First of all, when knitr process a Rnw file (and makes a tex file as an output), it defines a whole bunch of individual characters and uses them in the output. Have a look at the preamble of a knitted document and you will see a whole bunch of:

    \newsavebox{\hlnormalsizeboxclosebrace}%
    \newsavebox{\hlnormalsizeboxopenbrace}%
    ....
    \setbox\hlnormalsizeboxopenbrace=\hbox{\begin{normalsize}\verb.{.\end{normalsize}}%
    \setbox\hlnormalsizeboxclosebrace=\hbox{\begin{normalsize}\verb.}.\end{normalsize}}%

There are lots and _lots_ of these definitions. There appears to be one for each punctuation character and text size.

In particular there is one for the single quote mark, called `\hlnormalsizeboxsinglequote`. _Every single time_ you have a single quote in a code chunk, knitr replaces this single quote with `\usebox{\hlnormalsizeboxsinglequote}`. _Every single time_ you use _any_ punctuation character _at all_ within a code chunk, knitr will replace it with the relevant `\hlnormalsize[charactername]`. It's bizarre, and leads to very ugly code!

For example, the simple chunk in the example above gets rendered (in the tex document) like so:

    \begin{knitrout}
    \definecolor{shadecolor}{rgb}{0.969, 0.969, 0.969}\color{fgcolor}\begin{kframe}
    \begin{flushleft}
    \ttfamily\noindent
    {\ }{\ }{\ }{\ }\hlsymbol{words}{\ }\hlassignement{\usebox{\hlnormalsizeboxlessthan}-}{\ }\hlfunctioncall{c}\hlkeyword{(}\hlstring{\usebox{\hlnormalsizeboxsinglequote}Hello\usebox{\hlnormalsizeboxsinglequote}}\hlkeyword{,}\hlstring{\usebox{\hlnormalsizeboxsinglequote}world!\usebox{\hlnormalsizeboxsinglequote}}\hlkeyword{)}\mbox{}
    \normalfont
    \end{flushleft}
    \end{kframe}
    \end{knitrout}

How gross!  

Anyhow, remember that knitr inserts all the savebox commands _before_ the preamble you put in your Rnw document. Well, `\setbox` operates such that it calculates the contents of the box _straight away_ and saves it to the box register, and then forgets the definition of the box (i.e. the `\normalsize\verb.'.`).

What this means is that `\hlnormalsizeboxsinglequote` gets defined _ **before** _ the upquote package is even _loaded_, and hence the effect of upquote (redefining `'` to `\textquotesingle` within verbatim commands) happens too late to affect the `\verb.'.` that occurs in `\hlnormalsizeboxsinglequote`.

To fix this, we would like to retrieve the definition of the `\hlnormalsizeboxsinglequote` command _after_ we load the upquote package so that its definition gets re-parsed. Then we'd just have to type something like \edef\hlnormalsizeboxsinglequote\hlnormalsizeboxsinglequote to say "set `\hlnormalsizeboxsinglequote` to what it used to be, but re-read the definition first".

Unfortunately there appears to be no way to do this.Hence the only fix is to look up how knitr defines `\hlnormalsizeboxsinglequote` by grabbing it out of the preamble of a knitted document, and copy its definition into the preamble of the source document.

This works for now, but it just means that if the knitr package changes how it defines `\hlnormalsizeboxsinglequote` (maybe in one revision they decide to make all quotes blue in colour), it is up to you to make sure that your redefinition of `\hlnormalsizeboxsinglequote` in your Rnw file matches that used by Sweave.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-03-29T05:32:00-07:00">05:32</abbr>](getting-straight-single-quotes-for.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=282086588719098363&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=282086588719098363&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=282086588719098363&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=282086588719098363&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=282086588719098363&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=282086588719098363&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/03/getting-straight-single-quotes-for.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [knitr](../../search/label/knitr.html), [latex](../../search/label/latex.html), [R](../../search/label/R.html), [sweave](../../search/label/sweave.html)

