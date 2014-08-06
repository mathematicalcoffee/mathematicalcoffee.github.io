---
layout:   post
title:    "Indicators in Oneiric"
date:     2012-02-07 20:22
comments: true
categories: ~
tags: oneiric,ubuntu
authors: [mathematical.coffee]
---
### Indicators in Oneiric

New annoyed-with-unity-o-meter (indicators made me feel happier):
 [![](http://2.bp.blogspot.com/-e6EbHe4MT5k/TzH4WTq9oBI/AAAAAAAABQY/Rk_6ivuQ5pg/s320/meter_0.55.png)](http://2.bp.blogspot.com/-e6EbHe4MT5k/TzH4WTq9oBI/AAAAAAAABQY/Rk_6ivuQ5pg/s1600/meter_0.55.png)

# Indicators
Today I discovered about Indicator Apps. They are just like the applets of GNOME 2 that I could add to my panel, except they're upgraded for GNOME 3 instead. They all sit up the top-left of your screen.  
  
  
Also, instead of having a nice, single list of these applets where I can choose which ones to add to my panel (like in old Ubuntu), they are now...._all over the place_.  
You basically have to look them up on the internet, add a new repository _for each one_, install it, and then _manually_ run the program each time you start up to get it showing (well, I lie; you can add them into your auto-startup list to have them runn on their own).  
I found [this page](http://askubuntu.com/questions/30334/what-application-indicators-are-available) very helpful in giving a list of the most popular indicator applets and how to install them.Then, [this page](http://www.omgubuntu.co.uk/tag/indicatorapplets/) gives a much bigger list of applets (although less helpful in how to install them).  

## Installing Indicator Applets
Since they're not in the standard ubuntu repository, you usually have to update your list of repositories that Ubuntu looks in to get packages.  
Let's do an example with the [Workspace indicator](https://launchpad.net/indicator-workspaces), which sits in your top panel and lets you switch between workspaces.  
Going to its launchpad page, we see "Use this ppa for install: ppa:geod/ppa-geod".  

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-DwfZK9bh6Hk/TzHe7R-1Y8I/AAAAAAAABPQ/X8lqGLU3sh0/s1600/indicator-workspaces.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="123" src="http://2.bp.blogspot.com/-DwfZK9bh6Hk/TzHe7R-1Y8I/AAAAAAAABPQ/X8lqGLU3sh0/s320/indicator-workspaces.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">launchpad page for inicitator-workspaces</td></tr>
</tbody>

    sudo add-apt-repository ppa:geod/ppa-geod

Then, we update the list of available packages and install `indicator-workspaces`:  

    apt-get update
    apt-get install indicator-workspaces

But wait! You're not done yet! Go to the dashboard and actually _start_ the indicator. Then it will appear in your notification tray. If you right-click this one and look at the preferences you'll also see a "Start indicator at login", which you should check, if that's what you want.  

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-oCxGHGAmYxg/TzHuZWw6DgI/AAAAAAAABPc/B30SEdQ6itU/s1600/workspaceswitcher.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="86" src="http://3.bp.blogspot.com/-oCxGHGAmYxg/TzHuZWw6DgI/AAAAAAAABPc/B30SEdQ6itU/s200/workspaceswitcher.png" width="200"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Workspace switcher indicator.</td></tr>
</tbody>

## List of applets I added.

- [Workspace switcher](https://launchpad.net/indicator-workspaces): `add-apt-repository ppa:ppa/geod` and `apt-get install indicator-workspaces`.
- System Load Indicator - you can just `apt-get install indicator-multiload` this one.
- [Google Reader Indicator](https://launchpad.net/google-reader-indicator): lets me read my rss feeds from the panel. `add-apt-repository ppa:atareao/atareao` and `apt-get install google-reader-indicator`.

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-dRKCmMmmL8k/TzHviG0iszI/AAAAAAAABPo/psx0lbJ8v9M/s1600/reader.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="134" src="http://2.bp.blogspot.com/-dRKCmMmmL8k/TzHviG0iszI/AAAAAAAABPo/psx0lbJ8v9M/s200/reader.png" width="200"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">google reader indicator (top left icon)</td></tr>
</tbody>

## User menu/indicator
I don't like the "User Menu" (the little person and your username up the top left) - it only has "switch user" etc and I'm the only user on my laptop, so it just takes up space.   

 [![](http://1.bp.blogspot.com/-oApCe_7XrhA/TzHwfxOGCiI/AAAAAAAABQA/9YGKYxhz8sc/s320/usermenu.png)](http://1.bp.blogspot.com/-oApCe_7XrhA/TzHwfxOGCiI/AAAAAAAABQA/9YGKYxhz8sc/s1600/usermenu.png)
To remove it, go to dconf-editor and apps>indicator-session, and untick 'show-user-menu'.  
Log out and back in to have it take effect (or just do `unity --replace`).  

## Current snapshot
My current snapshot is:  

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-2LTIP3S7ji8/TzHvzsaJW3I/AAAAAAAABP0/XouiRwwOwJU/s1600/indicators-good.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="22" src="http://3.bp.blogspot.com/-2LTIP3S7ji8/TzHvzsaJW3I/AAAAAAAABP0/XouiRwwOwJU/s320/indicators-good.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Left to Right: Dropbox, Google Reader, System Monitor, Workspace switcher, Messages, Battery, Volume, Date/time.</td></tr>
</tbody>

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-02-07T20:22:00-08:00">20:22</abbr>](indicators-in-oneiric.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=5360393204119797316&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5360393204119797316&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5360393204119797316&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5360393204119797316&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5360393204119797316&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=5360393204119797316&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/02/indicators-in-oneiric.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [oneiric](../../search/label/oneiric.html), [ubuntu](../../search/label/ubuntu.html)

