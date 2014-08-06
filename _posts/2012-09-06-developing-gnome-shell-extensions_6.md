---
layout:   post
title:    "Developing GNOME shell extensions: finding documentation part 2"
date:     2012-09-06 19:28
comments: true
categories: ~
tags: developing,gir,gnome-shell-extension,tutorial,typelib
authors: [mathematical.coffee]
---
### Developing GNOME shell extensions: finding documentation part 2

Part 2 of finding documentation for developing gnome shell extensions; [Part 1 is here](developing-gnome-shell-extensions.html).

You can't always find documentation online. For example, Meta (`imports.gi.Meta`) doesn't have documentation online.Or perhaps you just want more details on the specific GNOME Javascript implementation of the C functions. Or there's a function listed on the page that you can't seem to find on the GNOME Javascript side.

Then, I recommend you look at the corresponding `.gir` file for your library, for example `Meta-3.0.gir`.

A `gir` file defines the binding between the C functions and the Javascript functions. They're used to define _bindings_ between languages.If you look inside a `gir` file, you'll see it just looks like an XML file.

In this post I'll cover a few things:

- Getting information from the raw `gir` file
- Where to find `gir` files, and converting `typelib` to `gir`
- Compiling the `gir` file into HTML documentation.
- Summary

## Getting information from the `gir` file

### Looking for signals in a `gir` file

To quickly look for signals in a `gir` file, you can just `grep` for `glib:signal` like so:

    grep 'glib:signal' Meta-3.0.gir
    # will give me a list of signals in the Meta library.
    # ... (lots of signals)
          <glib:signal name="workspace-changed" when="last">
          </glib:signal>
    # ... (lots more signals)

In the example above I wanted to see what signals the `Meta` library provided and in particular was after the `workspace-changed` signal.You can then go into the gir file and see that the `workspace-changed` signal belongs to the `Meta.Screen` class, so if I want to monitor workspace changes I have to do:

    global.screen.connect('workspace-changed', myFunction);

(This is an example of a useful signal that is not used anywhere in the gnome-shell javascript files, so I wouldn't have known about it otherwise). Note - many of the `global.*` objects (`global.screen`, `global.display`, ...) are Meta objects.

### Methods not available on the javascript side

Often you'll find that a function that is documented and available on the C side, but you can't seem to find it on the javascript side.

For example, suppose I want to get the current Metacity theme. I see that there's a function `meta_theme_get_current` that will do what I want, but when I try `Meta.Theme.get_current()`, I found out that `.get_current()` is not a function!

Looking in the `gir` file:

    <record name="Theme" c:type="MetaTheme" disguised="1">                      
    .... (more functions in between) ...
    
    
      <function name="get_current"                                              
                c:identifier="meta_theme_get_current"                           
                introspectable="0">                                             
        <return-value>                                                          
          <type name="Theme" c:type="MetaTheme*"/>                              
        </return-value>                                                         
      </function>

See the `introspectable="0"`? that means you can't get it from the javascript side. Too bad (time to pester the mailing list/find another way around it).

## Where to find `gir` files/Converting `typelib` files to `gir`

Great, so we now know about looking into `gir` files for more information. But where do we find these `gir` files?

Most of them live in `/usr/share/gir-1.0`. Often they will not appear there until you install the relevant dev or gir package (for example if you want `Wnck-[version].gir` on Ubuntu you need to install the `gir[girversion]-wnck-[version]` package (e.g. `gir1.0-wnck-1.0`), of the `libwnck-devel` package on Fedora).

Chances are you don't have many gir files in `/usr/share/gir-1.0`. Don't despair!

A `gir` file is really a human-readable version of a `typelib` file (a bit like what `gschema.xml` is to `gschema.compiled`).Have a look in `/usr/lib/girepository-1.0`. You will see a _huge_ number of `.typelib` files. (Maybe `/usr/lib` **64** `/girepository-1.0` for 64bit machines).

Everything in here can be imported in GJS through `imports.gi.[name]`.

Some of them are not there (e.g. Meta, Shell, St) because they are considered "private". This means if you run `gjs` on the command line, you will not be able to find them. However, you can find their typelib files here:

- `/usr/lib/gnome-shell` (Shell, St)
- `/usr/lib/mutter` (Meta)

So, how do we convert `typelib` files to human-readable `gir` files?

Use the `g-ir-*` tools. These are a collection of tools for generating `gir` or `typelib` files from source and converting between the two.We will be using `g-ir-generate`.

If you do not have these tools installed already (I think from GNOME 3.4+ on they come packaged with gnome-shell), you can install them in the `gobject-introspection` package (Ubuntu), or on Fedora 16 they were in `gobject-introspection-devel`. Or you could just [get the source from github](https://github.com/magcius/gobject-introspection).

To create a `gir` from a typelib (for example Meta):

    g-ir-generate /usr/lib/mutter/Meta-3.0.typelib > Meta-3.0.gir

And voila! A `gir` file for Meta!

Sometimes `g-ir-generate` will complain about not being able to find various other typelibs, for example if you try to generate `Shell-0.1.gir` from the typelib:

    [mathematicalcoffee ~]$ g-ir-generate /usr/lib/gnome-shell/Shell-0.1.typelib
    **(g-ir-generate:9599): ERROR** : failed to load typelib: Typelib file for namespace 'St', version '1.0' not found
    Trace/breakpoint trap (core dumped)

In this case it's trying to find `St-1.0.typelib`, which is one of those "private" ones in `/usr/lib/gnome-shell`, so you can include it using the `--includedir` argument (it also needs to find `Meta-3.0.typelib` in `/usr/lib/mutter`; I think by default just `/usr/lib/girepository-1.0` is included):

    [mathematicalcoffee ~]$ g-ir-generate --includedir=/usr/lib/gnome-shell \
        --includedir=/usr/lib/mutter /usr/lib/gnome-shell/Shell-0.1.typelib > Shell-0.1.gir

And that works.

## Generating HTML documentation from `gir` files

It's easier to use some form of documentation than wading through the `gir` files all the time.

Here is how to generate HTML documentation from the `gir` files (you use `g-ir-doc-tool`):

    mkdir mutter-docs
    g-ir-doc-tool Meta-3.0.gir -o mutter-docs

Then turn the output (yelp files) into HTML (or you could just use the yelp files if you prefer):

    yelp-build html mutter-docs

Then load index.html in a browser and you have some basic browsable documentation, complete with a list of signals (so if youclick on the Meta.Screen page it has a list of signals you can connect to, although it is a bit sparse on explanation).

 [![](http://1.bp.blogspot.com/-fHYW36Qopkg/UElb2PTp50I/AAAAAAAABaU/8LhMbaJ6Ceg/s320/meta-documentation.png)](http://1.bp.blogspot.com/-fHYW36Qopkg/UElb2PTp50I/AAAAAAAABaU/8LhMbaJ6Ceg/s1600/meta-documentation.png)

Notes:

- If you can find the documentation online, use that instead. The generated documentation is often quite sparse/no explanations.
- Sometimes `g-ir-doc-tool` complains about repository versions being unsupported. You can go into the `gir` file and modify the line `<repository version="1.0"` to `<repository version="1.2"` and it will then generate the documentation (not sure if anything is affected by that)
- Sometimes `g-ir-doc-tool` complains about not being able to find the `gir` files of other libraries it depends on. You have to generate them and make sure they're in `/usr/share/gir-1.0` (it doesn't seem to support an `--includedir` argument like `g-ir-generate` does).

# Summary

When looking for documentation:

- First look on [developer.gnome.org](http://developer.gnome.org/)
- 

Otherwise generate some documentation from the `gir` file (`/usr/share/gir-1.0`, `/usr/lib/mutter`, `/usr/lib/gnome-shell`):

    g-ir-doc-tool /path/to/gir -o /path/to/output/directory
    yelp-build html /path/to/output/directory

- 

If you can't find the `gir` file, find the `typelib` file and convert it to `gir` first (`/usr/lib/girepository-1.0`):

    g-ir-generate /path/to/typelib > /path/to/output/filename # use --includedir=/path/to/typelib/folder if need be

Hope that helps! Feedback welcome.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-09-06T19:28:00-07:00">19:28</abbr>](developing-gnome-shell-extensions_6.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=8569879999051177566&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8569879999051177566&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8569879999051177566&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8569879999051177566&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8569879999051177566&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8569879999051177566&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/09/developing-gnome-shell-extensions_6.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [developing](../../search/label/developing.html), [gir](../../search/label/gir.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [tutorial](../../search/label/tutorial.html), [typelib](../../search/label/typelib.html)

