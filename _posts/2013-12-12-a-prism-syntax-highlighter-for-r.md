---
layout:   post
title:    "A Prism Syntax Highlighter for R"
date:     2013-12-12 18:16 +1000
comments: true
categories: ~
tags: [code, R]
authors: [amy]
---
### A Prism Syntax Highlighter for R

( **Update** : description of a known issue, below the numbered list.) As I mentioned in [a previous post](searching-for-syntax-highlighter-for-r.html), I've recently begun to use Lea Verou's fantastic [PrismJS](http://prismjs.com/) to do syntax highlighting on this blog.

As I could not find an R plugin for PrismJS, I wrote one myself. PrismJS highlighting is regex based, which means that while it sometimes makes mistakes with highlighting, it's easy to add in a new language.

You can see a demo [**here**](http://bl.ocks.org/mathematicalcoffee/raw/5655496/) and get the script/style [from my gist](https://gist.github.com/mathematicalcoffee/5655496#file-prism-r-js) (I've also embedded the gist at the end of this post). It's similar to [Yihui Xie's SyntaxHighlighter brush for R](http://yihui.name/en/2010/09/syntaxhighlighter-brush-for-the-r-language/).

Without further ado, here's a demonstration:

    n <- 10
    for (i in seq_len(n)) {
        # say hello, many times
        message("hello world")
    }

You can grab the files [from my gist](http://gist.github.com/mathematicalcoffee/5655496); you can also [**view an example page demonstrating 3 different themes**](http://bl.ocks.org/mathematicalcoffee/raw/5655496/) I modified earlier.

To use it:

1. 

Host the the [PrismJS](http://prismjs.com/download.html) and [R PrismJS](https://gist.github.com/mathematicalcoffee/5655496#file-prism-r-js) script somewhere and include them (note: you may wish to minify the R script and add it to the end of your PrismJS script so you only need to include one file):

    <script src='prism.js'></script> 
    <script src='prism.r.js'></script>

2. 

Include the stylesheet of your choice. You may wish to also define style classes for `.token.function`, `.token.variable` and `.token.namespace`, to determine how functions, variables, and namespaces are styled (the stylesheets [on my gist](http://gist.github.com/mathematicalcoffee/5655496) have this already):

    <link rel='stylesheet' href='prism.css' />

3. 

Any R code you want to be syntax highlighted should have `class="language-r"` on it (note: on the `code` tag, not the `pre` tag). Works for inline code too.

Et Voila!

**Update:** There is a [**known issue**](http://bl.ocks.org/mathematicalcoffee/raw/5655496/index.html#known-issue) whereby hash tags within strings will be highlighted as comments. There are a number of workarounds mentioned in the link,  though each has a use that will break it (regex-based highlighters always have these problems).

You can [view my gist via bl.ocks.org](http://bl.ocks.org/mathematicalcoffee/raw/5655496/) to see a larger code snippet, and play around with a few themes I modified to make the R look pretty: Okaidia (the one from PrismJS), Zenburn (based off the vim theme by [Jami Nurminen](http://slinky.imukuppi.org/zenburnpage/)), and Tomorrow Night 80s (like the one from RStudio, by [Chris Kempson](https://github.com/chriskempson/tomorrow-theme)). I'm using Tomorrow Night 80s on my blog.

<script src="https://gist.github.com/mathematicalcoffee/5655496.js?file=prism.r.js"></script>

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2013-12-12T18:16:00-08:00">18:16</abbr>](a-prism-syntax-highlighter-for-r.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=566451707627245080&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=566451707627245080&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=566451707627245080&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=566451707627245080&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=566451707627245080&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=566451707627245080&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2013/05/a-prism-syntax-highlighter-for-r.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [R](../../search/label/R.html)

