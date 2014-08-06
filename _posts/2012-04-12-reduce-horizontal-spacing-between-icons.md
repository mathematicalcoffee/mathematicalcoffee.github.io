---
layout:   post
title:    "Reduce horizontal spacing between icons in GNOME 3.2"
date:     2012-04-12 23:34
comments: true
categories: ~
tags: gnome,gnome-shell
authors: [mathematical.coffee]
---
### Reduce horizontal spacing between icons in GNOME 3.2

One thing that annoys me about the default GNOME shell is the amount of horizontal space it wastes in between icons/indicators in the status area (top right on the panel).

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-Kdw2lhWlwxg/T4fGBVeSycI/AAAAAAAABUk/YuPbxK_HGAw/s1600/notification_tray_original.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="24" width="257" src="http://1.bp.blogspot.com/-Kdw2lhWlwxg/T4fGBVeSycI/AAAAAAAABUk/YuPbxK_HGAw/s320/notification_tray_original.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Urgh look how much space is between all the icons!</td></tr>
</tbody>

I wrote a very simple GNOME shell extension to fix this. (My first ever! More an exercise in how to do it than anything else).

It's available for one-click install from [extensions.gnome.org](https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/). The repository (for anyone interested in the code) is [here](https://bitbucket.org/mathematicalcoffee/status-area-horizontal-spacing-gnome-shell-extension).

If for some reason you don't want to/can't install from extensions.gnome.org, you can go to the ['Downloads' page](https://bitbucket.org/mathematicalcoffee/status-area-horizontal-spacing-gnome-shell-extension/downloads#download-84302) and download the .zip file. Then start `gnome-tweak-tool`, select "Shell Extensions", "Install Shell Extensions", and choose the .zip file. Restart the gnome-shell, enable the extension, and you're all done!

The result?

<tbody>
<tr><td style="text-align: center;">
<a href="http://1.bp.blogspot.com/-k61-1F47Ylk/T4fHW1SgdtI/AAAAAAAABUw/ovl51ORLZ0g/s1600/notification_tray_after.png" imageanchor="1" style="margin-left:auto; margin-right:auto; text-align: center"><img border="0" height="24" width="217" src="http://1.bp.blogspot.com/-k61-1F47Ylk/T4fHW1SgdtI/AAAAAAAABUw/ovl51ORLZ0g/s320/notification_tray_after.png"></a>
</td></tr>
<tr><td class="tr-caption" style="text-align: center;">Nice and slim</td></tr>
</tbody>

**Voila! Enjoy :)**

## What it Does

It basically just modifies these lines from the file `/usr/share/gnome-shell/theme/gnome-shell.css`:

    .panel-button {
        -natural-hpadding: 12px;
        -minimum-hpadding: 6px;
        /* ... and so on */
    }

The attribute `-natural-hpadding` is set by default to 12 pixels wide. My extension sets this to 6 pixels wide (you can modify this if you want; just change the relevant lines in `stylesheet.css` that comes with the extensions).

If you set `-naturial-hpadding` below 6 pixels you will have to adjust `-minimum-hpadding` to match it too.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-04-12T23:34:00-07:00">23:34</abbr>](reduce-horizontal-spacing-between-icons.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=5342763575571028434&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5342763575571028434&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5342763575571028434&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5342763575571028434&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5342763575571028434&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5342763575571028434&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/04/reduce-horizontal-spacing-between-icons.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [gnome](../../search/label/gnome.html), [gnome-shell](../../search/label/gnome-shell.html)

