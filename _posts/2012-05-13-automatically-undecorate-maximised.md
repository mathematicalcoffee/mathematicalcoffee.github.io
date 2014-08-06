---
layout:   post
title:    "Automatically undecorate maximised windows in GNOME Shell"
date:     2012-05-13 19:32 +1000
comments: true
categories: ~
tags: [gnome, GNOME 3.2, GNOME 3.4, gnome-shell, gnome-shell-extension, maximised, undecorate, window]
authors: [amy]
---
### Automatically undecorate maximised windows in GNOME Shell

One feature I really liked about the Ubuntu Netbook Remix (while it lasted) was how whenever you maximised a window, it removed the title bar. The program that did this was called [Maximus](https://launchpad.net/maximus).

This was really handy for saving a bit of vertical screen real estate, especially when you had a small 10" screen.Yes, it became harder to unmaximise a window/drag it around/resize it, but on a 10" screen you don't do that often anyway as it's really not big enough to bother with having multiple windows visible at once.

Anyhow, I wanted this ability in GNOME shell (undecorate maximised windows), so I wrote an extension to do this.

<tbody>
<tr>
<td style="text-align: center;"><a href="http://cdn.bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/downloads/maximus.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="120" src="http://cdn.bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/downloads/maximus.png" width="250"></a></td>
<td style="text-align: center;"><a href="http://cdn.bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/downloads/no-maximus.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="120" src="http://cdn.bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/downloads/no-maximus.png" width="250"></a></td>
</tr>
<tr>
<td class="tr-caption" style="text-align: center;">Maximus GNOME shell extension undecorates maximised windows</td>
<td class="tr-caption" style="text-align: center;">Without Maximus: title bar consumes vertical space.</td>
</tr>
</tbody>

Before I give the link, I'll mention that you don't actually need an extension to get this behaviour; [this blog post](http://www.webupd8.org/2011/05/how-to-remove-maximized-windows.html) gives two ways to do it:

1. Install Maximus: if you're lucky or have Ubuntu, you can just `sudo apt-get install maximus`. This will install the original Maximus program for you and then you're done. However if you have Fedora, Maximus is not in the package repositories. In that case you could try to [download the source](https://launchpad.net/maximus) and build/install it yourself. This isn't as easy as simply installing a program or extension though.
2. Edit your window theme: you can edit the theme GNOME-shell uses to decorate your windows to artificially remove the title bar from maximised windows. See [Method 2 in this blog post](http://www.webupd8.org/2011/05/how-to-remove-maximized-windows.html) for how. This is nice and easy, but you have to do it every time you change your window theme.

I'd recommend installing Maximus from your package manager if you have it (i.e. Ubuntu). Otherwise, edit your window theme (knowing that it could get written over every time you change your theme), or try my [Maximus GNOME shell extension (from extensions.gnome.org)](https://extensions.gnome.org/extension/354/maximus/).

The [Maximus GNOME shell extension](https://extensions.gnome.org/extension/354/maximus/) is just an extension that emulates the behaviour of the original Maximus program. All it does is undecorate windows that are maximised.

The homepage/repository/instructions are [here](https://bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/overview). For a one-click install just visit [extensions.gnome.org](https://extensions.gnome.org/extension/354/maximus/) (or you can also [download the zip file](https://bitbucket.org/mathematicalcoffee/maximus-gnome-shell-extension/downloads/maximus@mathematical.coffee.gmail.com.zip) and use `gnome-tweak-tool` to install it ('Shell Extensions' > 'Install Extension' > select .zip file). Make sure you additionally enable it.)

Enjoy & let me know of any bugs :)

* * *

## For developers: How it's done

For those who are interested, this is how I managed to get the windows undecorated.

Recall that in GNOME-shell, window objects are `Meta.Window`s (using the Mutter = Metacity + Clutter bindings).There are four ways I tried to undecorate/redecorate a window:

- use the Mutter interface: try modifying the `window.decorated` property of a `Meta.Window`.
- use the Gtk interface: try using `window.set_hide_titlebar_when_maximised()` or `window.set_decorated()`. on a `Gtk.Window`.
- use the Gdk interface: try using `window.set_decorations()` on a `Gdk.Window`.
- make an external call to `xprop` to set the window manager hints saying to undecorate the window.

### Mutter: `window.decorated = false`

It would be ideal to undecorate using the Mutter bindings as GNOME-shell treats all windows as `Meta.Window`s anyway.

There is a `window.decorated` property for `Meta.Window`s but it's treated as read-only (as of GNOME 3.4.1); setting it to `true` or `false` has no effect.There is no way to set the window's decorations from the current (GNOME 3.4.1) Mutter gobject introspection. Not surprising; the Mutter API can't do much at the moment.

### Gtk: `window.set_hide_titlebar_when_maximised`

Now assume that we could convert a `Meta.Window` into a `Gtk.Window`. Then we'd be able to use the function [`gtk_window_set_hide_titlebar_when_maximised()`](http://developer.gnome.org/gtk3/stable/GtkWindow.html#gtk-window-set-hide-titlebar-when-maximized) to get the behaviour we wanted, or if that didn't work, [`gtk_window_set_decorated()`](http://developer.gnome.org/gtk3/stable/GtkWindow.html#gtk-window-set-decorated).

However I couldn't find a way to make a GTK window from a Meta.Window, and in fact I'm not sure if it's possible/GTK works like that.

### Gdk: `window.set_decorations`

Well, why not assume we could convert a `Meta.Window` into a `Gdk.Window`. Then we could use the function [`gdk_window_set_decorations(0)`](http://developer.gnome.org/gdk/stable/gdk-Windows.html#gdk-window-set-decorations) to remove decorations from a window.

How to create a `Gdk.Window` from a `Meta.Window` from the gobject introspection bindings? The best I could find was a function [`gdk_x11_window_foreign_new_for_display`](http://developer.gnome.org/gdk/stable/gdk-X-Window-System-Interaction.html#gdk-x11-window-foreign-new-for-display), which will create a Gdk.Window given the window's X ID. In the GNOME javascript bindings:

    const Gdk = imports.gi.Gdk;
    const GdkX11 = imports.gi.GdkX11;
    
    
    let window = GdkX11.X11Window.foreign_new_for_display( Gdk.Display.get_default(), WINDOW_XID );
    // remove decorations
    window.set_decorations(0);
    // add back decorations
    window.set_decorations(Gdk.WMDecoration.ALL);

Assuming you can find the window's X ID (for example with `xwininfo`), this works!

However, this is another unfortunate caveat; when you call this code from **within** the GNOME-shell process (i.e. from a GNOME shell extension), the window gets killed! If you run the _exact same code_ using the `gjs` binary, or you write the exact same code in Python with the Python bindings, **it works** !.

After [a bit of asking around](https://mail.gnome.org/archives/gnome-shell-list/2012-May/msg00024.html), it turns out that using the above code simply won't work as long as it's run directly from a gnome shell extension; I have to make sure that the code that undecorates the window happens from an external process. This means making an external call (for example, `gjs undecorate_window.js`) from my code.

Then I'll need to somehow pass the window's X ID into the script from the extension to make sure it undecorates the right window.

So yes, this option is viable, but given that I have to make an external call anyway I'd rather not have to load up the various libraries in the external script _each time_ a window is maximised.

### `xprop`

`xprop` is a command-line utility for examining/setting the X properties of a window.

Looking through the `set_decorations` code in GDK and the C source for `Maximus`, to undecorate a window one sets the `_MOTIF_WM_HINTS` property on the window. In the hints one specifies that the window should be undecorated. When the window manager looks at these hints it then attempts to undecorate the window according to the hints.

Translating this into using `xprop` to set the hints, one uses the following command (credit to [this post](http://xrunhprof.wordpress.com/2009/04/13/removing-decorations-in-metacity/) that got me started):

    xprop -id [window_XID] -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"

To explain:

- `-id [window_XID]`: this tells `xprop` which window we wish to modify the hints of.
- `-f _MOTIF_WM_HINTS 32c`: this specifies the format of the `_MOTIF_WM_HINTS` property, each field being a 32bit unsigned integer.
- `-set _MOTIF_WM_HINTS 0x2, 0x0, 0x0, 0x0, 0x0`: says we wish to set the value of `_MOTIF_WM_HINTS` to `0x2, 0x0, 0x0, 0x0, 0x0`.

A quick explanation of what all the numbers in `_MOTIF_WM_HINTS` mean (see `MwmUtil.h` from the [OpenMotif source](http://cvs.openmotif.org/) for the documentation, or there is some rudimentary online documentation [here](http://odl.sysworks.biz/disk%24cddoc04sep11/decw%24book/d3b0aa63.p264.decw%24book)).

The hints structure has 5 fields, and ( **in order** ) they are:

- what fields we're specifying with the hints: the window functions, decorations, input mode and/or status. 
- the hints for the window functions. That is, which buttons to display on the window's title bar: maximise, minimise, close, ...
- the decorations to be drawn on the window: title bar, border, all decorations, no decorations, ...
- the input mode of the window: modeless (can't click on it), application modal, sytem modal, ...
- the status of the window: whether it's a tearoff window or not.

So in the above, `0x2, 0x0, 0x0, 0x0, 0x0` says that:

- we want to specify the decorations of the window (`0x2`); ignore all the other fields
- we want there to be no decorations on the window (the third number is `0x0`).

If we wanted to _decorate_ the window we'd set the window hints to `0x2, 0x0, 0x1, 0x0, 0x0`.

### Summary

Out of all of the above, only `xprop` and the GDK version were viable. Since I have to make an external call to undecorate the window anyway, I'd rather have my external call be `xprop -id ...` than `gjs undecorate_window.js` because in the latter `gjs` has to load all the relevant modules to execute the code, whereas the former is a simple command-line call that does the undecorating directly.

So the only question left is how to get the X ID of a window in order to pass it in to `xprop` (we'd have the same problem with Gdk too).

## Getting the X ID of a window

There is currently (GNOME 3.4.1) **no official way** to get the X ID from a `Meta.Window`. If I listen to `maximise` events, I get a `Meta.Window` specifying the window that was maximised. There is no method in the API to extract this window's X ID. (aaargh!)

So how can I find the `Meta.Window`'s X ID? I could try convert it into a Wnck window which has a `get_xid` method, but there's no way to do this directly other than looping through a list of Wnck windows and (say) comparing titles to determine whether the Wnck window is the same as the Meta.Window. This is prone to error - what happens when you have multiple windows with the same title? How will you work out which Wnck window is _your_ window?

After a bit of digging around in the source of Mutter, I found two (somewhat hacky) ways to grab a Meta.Window's X ID.

### Method 1: Using the window's description

It turns out that the `window.get_description()` of a Meta.Window consists of its X ID followed by its name (truncated to 10 characters) in brackets.For example, `0x26005b (Google Chr)`.

So, method 1 is to extract the X ID from the description of the window. However, it isn't guaranteed that the window's description will have the X ID in it in future releases of GNOME/Mutter; it's just lucky that in 3.2 to 3.4 this is what the description is set to.

### Method 2: Using the window _frame_'s X ID

If one has the actor for a Meta.Window, then the property `actor['x-window']` is the X ID of the window's _frame_.

By the frame of the window, I mean that every window has a frame created for it by the window manager, `actor['x-window']` is the X ID for that frame.

However, to perform undecoration/decoration of windows, one must use the X ID for the _client window_, being the window that the frame contains.

The client window is actually the child of the frame window. By using `xwininfo -children -id [frame_XID]` we can get a list of all the X IDs for the frame window's children, namely the one client window.

So method 2 is to make an external call to `xwininfo` and parse the output the extract the child's X ID. Again, it is not guaranteed that `actor['x-window']` will still be there in future releases of GNOME.

### Failing that

If the above two methods fail to locate a window's X ID we can use its title as a last resort. This is because `xprop -id [window's XID]` can be replaced with `xprop -name [window's title]` to identify the window in question. However if you have multiple windows of the same title, you aren't guaranteed that `xprop` will identify the _particular_ window you're after.

## Putting it all together.

Putting it all together, this is what happens:

1. Create a function `onMaximise` that fires whenever a window is maximised. One of its arguments is the window (that was maximised)'s actor.
2. Get the window's X ID, first by trying to parse the window's description and failing that by calling `xwininfo` on `actor['x-window']` to get the child's X ID.
3. If we found the X ID, then call `xprop -id [XI D] -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"`. If we didn't, then call `xprop -name [window.get_title()] ...`.

If you find a less cludgy way to do this (i.e. doing the external system call) please let me know!

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-05-13T19:32:00-07:00">19:32</abbr>](automatically-undecorate-maximised.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=5963299191853246857&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5963299191853246857&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5963299191853246857&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5963299191853246857&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5963299191853246857&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5963299191853246857&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/05/automatically-undecorate-maximised.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [gnome](../../search/label/gnome.html), [GNOME 3.2](../../search/label/GNOME%203-2.html), [GNOME 3.4](../../search/label/GNOME%203.html), [gnome-shell](../../search/label/gnome-shell.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [maximised](../../search/label/maximised.html), [undecorate](../../search/label/undecorate.html), [window](../../search/label/window.html)

