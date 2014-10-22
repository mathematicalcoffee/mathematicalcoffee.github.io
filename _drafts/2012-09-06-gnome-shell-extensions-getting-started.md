---
layout:   post
title:    "Gnome shell extensions: Getting started writing your own"
date:     2012-09-06 19:13 +1000
comments: true
categories: ~
tags: [developing, gnome-shell-extension, tutorial]
authors: [amy]
---
### Gnome shell extensions: Getting started writing your own

Getting started on GNOME shell extensions.

You've seen the great extensions on [extensions.gnome.org](https://extensions.gnome.org/) (I call this e.g.o) and now want to have a fiddle and start writing your own.

Where to start?I can't answer that completely, but here's a few things that might help (I am currently using GNOME 3.4 and GNOME 3.2 for writing extensions; some of this might get outdated with newer versions). It's not so much a tutorial as a list of useful things to get you started.

## Get acquainted

First things first. Extensions are written in GNOME javascript, which they say is based off Spidermonkey (Mozilla's flavour of Javascript).I never learned normal javascript, so I am not in a position to comment on similarities/differences.

[A nice introductory page](https://live.gnome.org/GnomeShell/Extensions) is on the GNOME website.Have a look, but don't get too scared yet and don't start writing yet.I think the main points to get out of this are the anatomy of an extension.

An extension **must** have the files `extension.js` and `metadata.json`.

The `metadata.json` file contains information about your extension - its name, unique identifier, homepage, description, what gnome-shell versions it is compatible with, etc. Have a look at the example one on the website.

The `extension.js` file is the GNOME-javascript file that GNOME-shell uses to run your extension. It **MUST** have at least three functions in it:

- `init(metadata)`: called to initialise your extension. The `metadata` argument is an object containing the metadata from your `metadata.json` file plus a few extras (for example, `metadata.path` contains the path to your extension).
- `enable`: called when the user actually _enables_ your extension (for example when they toggle the switch on e.g.o). This is where you do whatever you want your extension to do.
- `disable`: called when the user _disables_ your extension. It should stop whatever your extension does and restore the system to a state such that it looks like your extension was never there.

There is also an optional file `stylesheet.css` which you can use to style things in your extension, and you can of course have other files (like images, extra javascript files, ...).

I recommend you **not start writing your extension yet** ! Instead...

## Stand on the shoulders of giants

OK, well we who have submitted extensions to e.g.o are not giants ;), but before you even start writing any code, I recommend you look at the source of existing extensions first to get a feel for them.

Whenever you install an extension, its files get put into `$HOME/.local/share/gnome-shell/extensions`.

If you look in the directories here you will see the `extension.js` and `metadata.json` files I was talking about (plus any others that extension uses).

To start off with, try a simple extension. Or if you have an idea you want to implement in an extension, try looking at similar extensions. For example, if you want to do something with the Alt Tab popup, look at the various Alt Tab extensions out there.

Don't worry if you don't understand the details of the code in the file; a lot of the extensions on e.g.o will be a bit more complex than your first extension.If you do

    gnome-shell-extension-tool --create-extension

this tool will walk you through creating your own extension. The resulting files define a simple extension that creates a button in your status area (right hand side of the top panel), that will say "Hello, World!" when you click it.

This is a _great_ example to look through for the first time. I go through explaining it; there is a good explanation [here](http://blogs.openshine.com/cgtapia/2011/05/16/writing-extensions-to-the-new-gnome-shell/).

## GNOME-shell's own javascript code

I recommend looking at the javascript files for gnome-shell.You can get them in `/usr/share/gnome-shell/js`. These are the files gnome-shell uses to define parts of its interface - for example, the alt-tab code is in `/usr/share/gnome-shell/js/ui/altTab.js`. I recommend looking in `/usr/share/gnome-shell/js/ui` - most classes you will want to use are in here.

I'll write another blog post on that at a later date.

## Further down the rabbit hole...

Now you have to actually write your extension.

Well, there's not too much I can say here. Just jump in and give it a go! I do recommend tweaking an existing, simple/similar extension to what you want to do as opposed to writing your own for your first extension.

The main point I wanted to make is that you can learn a lot by looking at existing extensions, and it is often easier to _tweak_ an _existing_ extension to do what you want rather than write your own from scratch.

Quick list of useful things while developing extensions:

- to install an extension, add its UUID to dconf key `org.gnome.shell.enabled-extensions` and make sure it is in `~/.local/share/gnome-shell/extensions`
- every time you make a change to the javascript of an extension (e.g. `extension.js`), you have to restart gnome-shell for the change to take effect. Press `Alt+F2` and type in 'r'.
- you can access an interacitve gnome-javascript console by either using the Looking Glass (`Alt+F2`, type `lg`) or by typing `gjs` or `gjs-console` on the command-line. The Looking Glass will let you access more libraries (like the Metacity or GNOME-shell ones) than the console and also has a 'picker' widget that lets you select any widget on the screen to query its properties etc.
- 

If your extension doesn't load, you can look in the looking glass 'Errors' tab. It might say something like

    Extension myextension@abcd.efgh.com had error: [error message]

- 

It is invaluable to run gnome-shell from a terminal to see extra error messages:

    gnome-shell --replace

from a terminal will start gnome-shell and output error messages to this terminal

- If an extension doesn't load, this is due to errors in the `init()` or `enable()` functions. The error will probably appear in the looking glass 'Errors' tab and not in the terminal.
- If an extension load but something breaks while you're using it, the error will probably appear in the terminal rather than the 'Errors' tab.
- 

To use classes you found in `/usr/share/gnome-shell/js/ui`, import the javascript file with `const FileName = imports.ui.fileName;`. For example, if I want to use classes in `popupMenu.js`:

    const PopupMenu = imports.ui.popupMenu;
    // now I can use PopupMenu.PopupMenuItem, etc

- 

To use external libraries (like `Meta`, `Shell`, ...), use `const Meta = imports.gi.Meta;`. To see what external libraries you can use, have a look in `/usr/lib/girepository-1.0`; these files all define javascript bindings to the C libraries. Documentation exists for these online, mainly from [developer.gnome.org](http://developer.gnome.org/); see my [other blog post](developing-gnome-shell-extensions.html) for further details.

And finally but most important...

## Ask for help!

Feel free to ask for help in what you're doing! It's really hard when you first start writing extensions, because there isn't much in the way of documentation/tutorials to help out. That's why I think it's easiest to look at heaps of other people's extension code before starting your own and even just tweak their code to achieve your purposes when you first start.

Places you can ask for help (more info [here](https://live.gnome.org/GnomeShell)):

- IRC: [irc.gnome.org:#gnome-shell](irc://irc.gnome.org/#gnome-shell) - plenty of people willing to answer questions
- [GNOME shell mailing list](https://mail.gnome.org/mailman/listinfo/gnome-shell-list) - perfectly appropriate to ask extension questions here.

Great links:

- [Writing extensions for the new Gnome Shell](http://blogs.openshine.com/cgtapia/2011/05/16/writing-extensions-to-the-new-gnome-shell/) - a great introduction to writing extensions (includes explanation of the Hello World extension and more helpful links)
- [Step by step tutorial to create extensions](https://live.gnome.org/GnomeShell/Extensions/StepByStepTutorial) on the gnome website. Only partially complete, but there's a lot of stuff there (GNOME 3.4+)
- [Tips for getting extensions approved](http://blog.mecheye.net/2012/02/requirements-and-tips-for-getting-your-gnome-shell-extension-approved/): for when you eventually get to the point of submitting your extension on e.g.o
- [GNOME shell style guide](https://live.gnome.org/GnomeShell/StyleGuide): if you're interested (GJS style guide).
- [Finnibar Murphy's walkthough on creating an extension](http://blog.fpmurphy.com/2011/06/patching-a-gnome-shell-theme.html) NOTE: this is a great walkthrough but it is for GNOME 3.0 and those extensions are incompatible with 3.2+ (3.0 just required a single `main` function instead of `init`, `enable` and `disable`). Walkthrough is still good though.
- [Set of tips for GNOME 3.4](http://blog.mecheye.net/2012/02/more-extension-api-breaks/) from the gnome-shell people - in particular, how to do multifile extensions (although the syntax they provide is GNOME 3.3+)
- ... others?

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-09-06T19:13:00-07:00">19:13</abbr>](gnome-shell-extensions-getting-started.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=1928013052094088247&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1928013052094088247&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1928013052094088247&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1928013052094088247&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1928013052094088247&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1928013052094088247&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/09/gnome-shell-extensions-getting-started.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [developing](../../search/label/developing.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [tutorial](../../search/label/tutorial.html)

