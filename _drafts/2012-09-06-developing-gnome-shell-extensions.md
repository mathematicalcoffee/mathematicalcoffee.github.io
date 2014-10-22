---
layout:   post
title:    "Developing GNOME shell extensions: finding documentation part 1"
date:     2012-09-06 19:16 +1000
comments: true
categories: ~
tags: [developing, gnome-shell-extension, tutorial]
authors: [amy]
---
### Developing GNOME shell extensions: finding documentation part 1

So, you've recently started developing gnome shell extensions.

You ask a question on the mailing list about wanting to achieve goal X and are told "simple - connect to signal Y and that's exactly what you want". And it _is_ exactly what you want. Only when you look through the gnome-shell javascript files to see examples of how to use the signal, there is _nothing_ in the source that connects to it.

So you think to yourself, "how could I even have _known_ there was a signal/class/method that did X if there are no examples of it being used? Is there a magical list of signals/classes/methods that I don't know about? Will I be stuck forever asking questions on the mailing list hoping that some person is aware of the magical hidden/undocumented signal/method/class that I'm interested in??!!".

I went through the same pain when I first started developing gnome shell extensions.I felt I was stuck asking simple questions that I could easily work out on my own, if only I could find some documentation, and that was hindering me from making progress on the extension and asking the more complex questions.

Well, documentation _does_ exist, although it is sometimes hard to find.I thought I'd share what I've learned so far about finding and generating documentation for classes I'm interested in.

This is part 1; part 2 is [here](developing-gnome-shell-extensions_6.html).

## Documentation on developer.gnome.org

The absolute best documentation I've find is online on the [gnome developer's website](http://developer.gnome.org/).Documentation for most of the `imports.gi.XXXX` libraries lives here.You can search for the library you're interested in from that site, or try `developer.gnome.org/XXXX/` for documentation for library XXXX.For example:

- [imports.gi.St](http://developer.gnome.org/st/stable/)
- [imports.gi.Shell](http://developer.gnome.org/shell/unstable/) (I found that one hard to find - while most of the documentation lives on developer.gnome.org/xxx/stable, this one lives on developer.gnome.org/xxx/ **unstable** )
- [imports.gi.Clutter](http://developer.gnome.org/clutter/stable/)

These pages have lists of available classes you can use, and the page for each class will have a list of methods, signals, and properties of each object.

A quick note - a property with a hyphen (`-`) in it will be converted to an underscore on the javascript side.For example a property `schema-id` will turn into `schema_id`.

Signals retain their hyphens, so a signal `workspace-changed` remains `workspace-changed`.

The function names are all in C syntax. To convert from that to the javascript syntax you just remove the name prefix and omit the `self` argument.

For example, `clutter_actor_allocate(self, box, flags)` turns into `actor.allocate(box, flags)` on the javascript side, where `actor` is a `Clutter.Actor` instance.

There is a _huge_ amount of documentation on the [developer.gnome.org](http://developer.gnome.org/) site.You should be able to find most of what you want there.

However sometimes you can't (for example `imports.gi.Meta`, and that's what my [next blog post](developing-gnome-shell-extensions_6.html) will be about.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-09-06T19:16:00-07:00">19:16</abbr>](developing-gnome-shell-extensions.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=1050684428916935075&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1050684428916935075&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1050684428916935075&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1050684428916935075&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1050684428916935075&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=1050684428916935075&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/09/developing-gnome-shell-extensions.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [developing](../../search/label/developing.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [tutorial](../../search/label/tutorial.html)

