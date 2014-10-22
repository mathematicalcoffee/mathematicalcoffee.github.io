---
layout:   post
title:    "Upgrading to Ubuntu Oneiric Ocelot 11.10 - Argh!"
date:     2012-02-04 23:23 +1000
comments: true
categories: linux
tags: [oneiric, ubuntu]
authors: [amy]
---

I finally bit the bullet and decided to upgrade from Ubuntu Natty 11.04 to Ubunto Oneiric 11.10.

I've been avoiding it for ages (my little laptop is on 10.10 and I intend to keep it there).

Ever since the Unity desktop got introduced, I don't have the courage to upgrade my Ubuntu. I really can't stand the desktop --- although it actually looks quite good! But to me it seems like an attempt to make Ubuntu look more like a Mac, and I resent Macs (another irrational move --- I think the Mac interface is amazing, and I like how it does expose \*nix-like interfaces for the so-inclined. I think I just have an inherent dislike of Apple products because of the "cool"/elite aura they culture and (mostly) because of their uber-high prices).

 [![The Unity desktop looks pretty slick.](http://1.bp.blogspot.com/-H1SpPFSIVLQ/Ty4t6PvMboI/AAAAAAAABO4/UgMBcZr40tQ/s320/NewUnityDesktop.png)](http://1.bp.blogspot.com/-H1SpPFSIVLQ/Ty4t6PvMboI/AAAAAAAABO4/UgMBcZr40tQ/s1600/NewUnityDesktop.png)

Anyhow, I reckon that people turn to a Linux OS because they want to learn all that system nitty-gritty business, and they come to enjoy the feeling of using terminals and such because, well, it makes you feel so ... _hardcore_ (even if it isn't ! :P). No-one thinks, "gee, I'd really like an OS with a user-friendly, idiot-proof interface --- I know, Linux!".

So I see the "prettification" of Ubuntu as a bit of a betrayal of what Linux systems are about. And that's what Kubuntu is for anyway!I know I'm being irrational and petty, but there you go.

It just annoys me that as I upgrade my version of Ubuntu, it becomes harder and harder to find the tools I need to configure, customise and tweak my system to my liking. They all get hidden away between a more and more simplistic interface in the name of "usability", and I need more and more clicks to do what I want.

My pet peeve with the new Unity desktop (with Fedora 15+ too!) is the loss of customisable panels. I really enjoyed having the top panel in which I would dump all sorts of panel applets (isn't the eyes one awesome?!).<!-- todo: pics of panel + eyes applet -->More seriously, I had shortcuts to all my most-used applications there (chrome, terminal and thunderbird).

I rely on the terminal shortcut really heavily, and it is very important to me that it is a one-click application to launch. In Ubuntu Desktop, I'm supposed to pin the terminal launcher to the side launcher, which is fine. However, to open the terminal, I first have to hover my mouse over the side of the screen to get the side launcher to appear, and then click on the terminal button. While this doesn't seem like much, it annoys me to no end that the Ubuntu dev team have, in the name of a more "usable" interface, hidden away the ability to have an always-present shortcut to commonly-used applications!

I suppose I'll find ways to tweak these niggling annoyances as I go along, but I should have been given the option to choose what behaviour I wanted, and it shouldn't be hard for me to work out how to affect these changes.

For example, I like having just two workspaces on my big laptop. By default, Ubuntu Desktop comes with 4: 2 rows, and 2 columns. I just want to change this to 1 row and 2 columns.   
Easy, right? In Classic Ubuntu you just right click on the workspace switcher and you're given an option to change it. <!-- TODO: picture -->.

Not so! This time, after digging through the help files, to change the number of rows and columns of workspaces, you have to go to the terminal and use `gconftool`:

~~~ bash
# set number of rows to 1
gconftool-2 --type=int --set /apps/compiz-1/general/screen0/options/vsize 1
~~~

This is exactly what I mean! I don't mind that the default workspace configuration is 2x2, but the interface is not more usable if the ability to tweak it is hidden away to some obscure command-line hack! You wouldn't know which key in `gconf` to edit because it isn't apparent! By all means, make the interface more usable, but make it easy to tweak as well.

Anyhow, as I learn how to tweak Unity I'll make a note of it so I can remember for if I (ever) upgrade my other laptop.

