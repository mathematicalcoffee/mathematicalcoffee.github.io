---
layout:   post
title:    "R gotcha - regular expressions"
date:     2013-05-26 18:00
comments: true
categories: ~
tags: code,R
authors: [mathematical.coffee]
---
### R gotcha - regular expressions

Just a quick post --- I came across this today and thought it was worth mentioning.

By default, the regular expression functions `grep`, `gsub`, `regexpr`, etc use extended regular expressions. By passing in `perl=TRUE` as an argument, one can use Perl regular expressions.

Note that in extended regular expressions, the `.` character matches the newline character `'\n'`. **In Perl regular expressions, it doesn't.**

    grep('.', '\n')
    ## [1] 1
    grep('.', '\n', perl=T)
    ## integer(0)

Something to keep in mind if you use regular expressions in R with strings with embedded newlines and were having puzzling results.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2013-05-26T18:00:00-07:00">18:00</abbr>](r-gotcha-regular-expressions.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=2194533923922336135&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2194533923922336135&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2194533923922336135&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2194533923922336135&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2194533923922336135&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=2194533923922336135&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2013/05/r-gotcha-regular-expressions.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [R](../../search/label/R.html)

