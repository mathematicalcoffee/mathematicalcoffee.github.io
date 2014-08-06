---
layout:   post
title:    "Searching for a Syntax Highlighter for R"
date:     2013-05-29 06:06 +1000
comments: true
categories: ~
tags: [code, javascript, R]
authors: [amy]
---
### Searching for a Syntax Highlighter for R

I've recently been looking at various syntax highlighters I could add to my blog to prettify it a bit more.The only criteria was that it had to be easy for me to incorporate into this blog (me being an interwebs ignoramus), and it should support syntax highlighting for R and Javascript, being two languages I post a lot of snippets of.

At a (very) cursory glance, I found a few options:

- the [Highlight package for R](http://highlight.r-enthusiasts.com/);
- [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/);
- [PrismJS](http://prismjs.com/).

## R-Highlight

To use the [highlight package for R](http://highlight.r-enthusiasts.com/):

- include jQuery, the highlight script and CSS stylesheet;
- initiate highlighting by using jQuery to select the nodes we wish to highlight and calling `r_syntax_highlight()`;
- has a list of recognised functions that will be highlighted (no regex there);
- can even cause each function to link to its documentation (!)

However, the script seems to support the R language only (the highlight package when used from R appears to support many languages, but the script for webpages seems to only expose R syntax highlighting. I could be wrong here).

## Syntax Highlighter

To use [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/):

- include the script `shCore.js` and stylesheets `shCore.css`, `shThemeDefault.css`, _plus_ the script for each language you wish to syntax highlight;
- initiate highlighting by labelling `<pre>` tags to be highlighted with `class: brush: <language>`,  and add a call to `SyntaxHighlighter.all()`;
- does not support R out of the box, but [Yihui Xie has written a language definition for it](http://yihui.name/en/2010/09/syntaxhighlighter-brush-for-the-r-language/) (regex-based).

## PrismJS

To use [PrismJS](http://prismjs.com/):

- include the script `prism.js` and stylesheet `prism.css`;
- mark code to be highlighted using `<code class="language-<language>">`;
- no need to call any functions to initiate highlighting;
- does **not** support R out of the box, but languages can be defined using regexes.

## Conclusion

They all seem pretty awesome, and I absolutely love R-highlight's ability to link to a function's documentation as well as marking it up. All three are fairly easily themeable. I strongly recommend you check them all out.

However, in the end I went with PrismJS, because

- I couldn't work out how to use R-highlight for languages other than R (I often blog with Javascript snippets).
- SyntaxHighlighter, while very popular, required me to host and link to many Javascript files (one per language). I didn't feel like doing this.
- I love how PrismJS requires the `class="language-X"` part to be in the _code_ tag, not the _pre_ tag. A language is an attribute of code, not of a preformatted block, and as such you should mark a code block's language in the `code` tag, not the `pre` tag. Plus, this way of hinting the code language is [recommended in the HTML5 specification](http://www.w3.org/html/wg/drafts/html/master/Overview.html#the-code-element).
- PrismJS requires me to include just two files; the script and stylesheet. In addition, it's tiny! With Javascript, R, HTML/XML, CSS and Bash highlighting support the file is all of 7.8kB. <3

I wrote a syntax highlighter for R and PrismJS; I'll post it tomorrow (or whenever I get round to it). Here's a sneak-preview:

    # iterate a dis/like of green eggs and ham
    helloSam

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2013-05-29T06:06:00-07:00">06:06</abbr>](searching-for-syntax-highlighter-for-r.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=5026264639140565466&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5026264639140565466&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5026264639140565466&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5026264639140565466&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5026264639140565466&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5026264639140565466&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2013/05/searching-for-syntax-highlighter-for-r.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [javascript](../../search/label/javascript.html), [R](../../search/label/R.html)

