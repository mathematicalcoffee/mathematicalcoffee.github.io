---
layout:   post
title:    "XPenguins in GNOME shell!"
date:     2012-08-06 18:49
comments: true
categories: ~
tags: GNOME 3.2,GNOME 3.4,gnome-shell,gnome-shell-extension,xpenguins
authors: [mathematical.coffee]
---
### XPenguins in GNOME shell!

Do you all remember [XPenguins](http://xpenguins.seul.org/)?

It's a program that spawns a whole bunch of penguins on your desktop - they walk on top of your windows and fall off them, and moving a window over them will squash them.

<tbody>
<tr><td style="text-align: center;"><a href="http://cdn.bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension/downloads/xpenguins-screenshot.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="135" src="http://cdn.bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension/downloads/xpenguins-screenshot.png" width="400"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">XPenguins in action</td></tr>
</tbody>

If you're on Linux, most distributions have an `xpenguins` package in their repositories for you to install.

However on GNOME shell, the xpenguins from the package manager doesn't work. This is not a fault of XPenguins, but rather that XPenguins picks the wrong window to draw the penguins onto. (XPenguins will draw on the Nautilus 'desktop' window which GNOME shell covers up by default).

<tbody>
<tr><td style="text-align: center;">
<embed allowfullscreen="true" height="400" src="http://cdn.bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension/downloads/XPenguins_demo.webm" width="540" style="margin-left: auto; margin-right: auto;"></embed>
</td></tr>
<tr><td class="tr-caption" style="text-align: center;">XPenguins GNOME shell extension in action.</td></tr>
</tbody>

So, I wrote an [XPenguins GNOME shell extension](https://extensions.gnome.org/extension/405/xpenguins/) to get it working on GNOME shell. You can install it from [extensions.gnome.org](https://extensions.gnome.org/extension/405/xpenguins/). You can configure things like the toon speed, which toons to load (Bill, Penguins, Turtles, ...) and how many, and much more! See the video above for a preview (I'm so uber proud!).

<tbody>
<tr><td style="text-align: center;"><a href="http://cdn.bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension/downloads/xpenguins-menu.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="170" src="http://cdn.bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension/downloads/xpenguins-menu.png" width="298"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Configure XPenguins GNOME shell extension via menu.</td></tr>
</tbody>

It uses the standard XPenguins themes (if you have any in `.xpenguins/themes` it will load them). More themes can be found from the [(original) XPenguins home page](http://xpenguins.seul.org/) on the right under "XPenguins Themes 1.0", and also on the "User contributed software" link on that page.

If you want to check out the code, it lives [at bitbucket](https://bitbucket.org/mathematicalcoffee/xpenguins-gnome-shell-extension).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-08-06T18:49:00-07:00">18:49</abbr>](xpenguins-in-gnome-shell.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=7800502838448199712&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=7800502838448199712&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=7800502838448199712&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=7800502838448199712&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=7800502838448199712&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=7800502838448199712&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/08/xpenguins-in-gnome-shell.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [GNOME 3.2](../../search/label/GNOME%203-2.html), [GNOME 3.4](../../search/label/GNOME%203.html), [gnome-shell](../../search/label/gnome-shell.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [xpenguins](../../search/label/xpenguins.html)

