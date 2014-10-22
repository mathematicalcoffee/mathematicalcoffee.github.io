---
layout:   post
title:    "Adding window options to title bar in GNOME 3.2, 3.4"
date:     2012-05-02 17:31 +1000
comments: true
categories: ~
tags: [GNOME 3.2, GNOME 3.4, gnome-shell, gnome-shell-extension, window-options]
authors: [amy]
---
### Adding window options to title bar in GNOME 3.2, 3.4

In GNOME you can usually right-click on the title bar of an application's window to select Minimize, Maximize, Always on Top, Always on Visible Workspace, etc.

If you use Google Chrome and are not using the system title bar and borders (the default), you'll notice it's not possible to access this menu.

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-PgroqTu1zug/T6HJb1GKXrI/AAAAAAAABWU/Xuvu8_bVbCY/s1600/window-options.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://1.bp.blogspot.com/-PgroqTu1zug/T6HJb1GKXrI/AAAAAAAABWU/Xuvu8_bVbCY/s320/window-options.png" width="262"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Window Options GNOME Shell Extension in action</td></tr>
</tbody>

I've written a small GNOME Shell Extension that adds this drop-down list to the GNOME Shell title bar that gets drawn for the current window. See it in action in the picture.

It's called [Window Options](https://bitbucket.org/mathematicalcoffee/window-options-gnome-shell-extension) and is available for installation [from extensions.gnome.org](https://extensions.gnome.org/extension/354/maximus/).

To install it, visit [extensions.gnome.org](https://extensions.gnome.org/extension/354/maximus/) - one-click install.

Otherwise, download the .zip file on the [Downloads page](https://bitbucket.org/mathematicalcoffee/window-options-gnome-shell-extension/downloads). Open `gnome-tweak-tool`, go to "Shell Extensions", "Install Extension" and select the .zip file.

This extension also works with the [Status Title Bar](https://extensions.gnome.org/extension/59/status-title-bar/) extension (which shows the full window title in the top instead of just the current application's name). However, you have to make sure that Window Options is loaded _after_ Status Title Bar, or else Status Title Bar will write over the menu.( **UPDATE:** It now works with Status Title Bar regardless of install order.)

To do this, just make sure that if you're using Status Title Bar, you install it before Window Options. If it's too late and you installed Window Options first, you can either uninstall and reinstall Window Options, OR just toggle Window Options on and off a couple of times (from `gnome-tweak-tool`) when you log in. This will cause Window Options to put its menu items in Status Title Bar's menu instead of the default panel one (that Status Title Bar removes).

You can configure which items are shown in the menu; to see how, see the Readme on [Window Options' homepage](https://bitbucket.org/mathematicalcoffee/window-options-gnome-shell-extension) (just scroll down a bit).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-05-02T17:31:00-07:00">17:31</abbr>](adding-window-options-to-title-bar-in.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=5476723128701617885&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5476723128701617885&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5476723128701617885&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5476723128701617885&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5476723128701617885&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5476723128701617885&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/05/adding-window-options-to-title-bar-in.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [GNOME 3.2](../../search/label/GNOME%203-2.html), [GNOME 3.4](../../search/label/GNOME%203.html), [gnome-shell](../../search/label/gnome-shell.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [window-options](../../search/label/window-options.html)

