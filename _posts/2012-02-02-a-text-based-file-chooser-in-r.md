---
layout:   post
title:    "A text-based file chooser in R"
date:     2012-02-02 22:24 +1000
comments: true
categories: R
tags: [code, R]
authors: [amy]
---

I've had to write some code allowing users to select various files for processing in R. Since they operate my script through a text console, I thought it'd be easier to provide some way for users to select the files they want processed interactively. Basically, a file dialogue in R. Furthermore, I wanted to avoid loading in any extra GUI packages (RGtk2,tcltk,...) to keep the script light-weight. Bingo! In R there's a command `file.choose` that allows a user to pick a file. In Windows or Mac, it comes up with a file dialog. However in Linux, it has this unhelpful interface:

~~~ r
> file.choose()
Enter file name:
~~~

That's it. It doesn't offer the ability to navigate through folders, you just have to know your entire file path and enter it in. I wanted something a bit more guided. So, after asking [this question](http://stackoverflow.com/questions/9122600/r-command-line-file-dialog-similar-to-file-choose) at Stack Overflow, and with the help of the friendly people there, I wrote my own function to browse files:

~~~ r
#' Text-based interactive file selection.
#'@param root the root directory to explore
#' (default current working directory)
#'@param multiple boolean specifying whether to allow 
#' multiple files to be selected
#'@return character vector of selected files.
#'@examples 
#'fileList
~~~

It basically looks at the directory you specify and allows you to choose folders to explore or select. You can select multiple files too. The magic boils down to the `menu`, which, given a vector `x`, will provide a text interface asking the user to choose on element of `x`. Example use:

~~~
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
~~~

Nifty! (of course, it could do with improvements - allow for selecting directories say, or filter files shown).
