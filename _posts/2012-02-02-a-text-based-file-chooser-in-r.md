---
layout:   post
title:    "A text-based file chooser in R"
date:     2012-02-02 22:24
comments: true
categories: ~
tags: code,R
authors: [mathematical.coffee]
---
### A text-based file chooser in R

I've had to write some code allowing users to select various files for processing in R.Since they operate my script through a text console, I thought it'd be easier to provide some way for users to select the files they want processed interactively.Basically, a file dialogue in R.Furthermore, I wanted to avoid loading in any extra GUI packages (RGtk2,tcltk,...) to keep the script light-weight.Bingo! In R there's a command <tt>file.choose</tt> that allows a user to pick a file.In Windows or Mac, it comes up with a file dialog.However in Linux, it has this unhelpful interface:

    > file.choose()
    Enter file name:

That's it. It doesn't offer the ability to navigate through folders, you just have to know your entire file path and enter it in. I wanted something a bit more guided.So, after asking [this question](http://stackoverflow.com/questions/9122600/r-command-line-file-dialog-similar-to-file-choose) at Stack Overflow, and with the help of the friendly people there, I wrote my own function to browse files:

    #' Text-based interactive file selection.
    #'@param root the root directory to explore
    #' (default current working directory)
    #'@param multiple boolean specifying whether to allow 
    #' multiple files to be selected
    #'@return character vector of selected files.
    #'@examples 
    #'fileList

It basically looks at the directory you specify and allows you to choose folders to explore or select.You can select multiple files too.The magic boils down to the <tt>menu</tt>, which, given a vector <tt>x</tt>, will provide a text interface asking the user to choose on element of <tt>x</tt>.Example use:

    > fl <- my.file.browse('path/to/dir',multiple=T)
    Select file(s) (0 to quit) in folder path/to/dir:
    
    
    1: ../ (to)
    2: subdir/
    3: b.jpg
    4: a.txt
    
    
    Selection: 3
    Select file(s) (0 to quit) in folder path/to/dir:
    
    
    1: ../ (to)
    2: subdir/
    4: a.txt
    
    
    Selection: 2
    Select file(s) (0 to quit) in folder path/to/dir/subdir:
    
    
    1: ../ (dir)
    2: c.jpg
    
    
    Selection: 2
    Select file(s) (0 to quit) in folder path/to/dir/subdir:
    
    
    1: ../ (dir)
    
    
    Selection: 0
    >
    > fl
    [1] "path/to/dir/b.jpg"
    [2] "path/to/dir/c.jpg"

Nifty! (of course, it could do with improvements - allow for selecting directories say, or filter files shown).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-02-02T22:24:00-08:00">22:24</abbr>](ive-had-to-write-some-code-allowing.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=3600666191367389468&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3600666191367389468&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3600666191367389468&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3600666191367389468&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3600666191367389468&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3600666191367389468&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/02/ive-had-to-write-some-code-allowing.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [R](../../search/label/R.html)

