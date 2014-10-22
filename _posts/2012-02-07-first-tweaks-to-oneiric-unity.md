---
layout:   post
title:    "First tweaks to Oneiric Unity"
date:     2012-02-07 16:31 +1000
comments: true
categories: linux
tags: [oneiric, ubuntu]
authors: [amy]
---
### First tweaks to Oneiric Unity

These are the first things I did to Oneiric to try make it more palatable to me.
# Fed-Up-With-Unity-O-Metre:
After all the tweaks so far (left is "happy", right is "argh downgrade to 10.x or use Classic Ubuntu!":

 [![Not happy, Jan!](http://2.bp.blogspot.com/-H_u2cVY7Vj4/TzH4OZ0dNhI/AAAAAAAABQM/Nb2PjXv3VUk/s320/meter_0.7.png)](http://2.bp.blogspot.com/-H_u2cVY7Vj4/TzH4OZ0dNhI/AAAAAAAABQM/Nb2PjXv3VUk/s1600/meter_0.7.png)

## Terminal text

The terminal text is this fancy different font. I just want the normal monospace. No big deal this time --- Terminal -> Edit Profile -> General -> don't use system default font, change to Monospace size 10 (my preferred size).

## Wireless icon not there/network manager not showing networks

I can't seem to get any wireless. The wireless icon I expect is not in my notification area like it used to be. W hen I go into System Settings > Networking > Wireless, I get no network names detected, and the 'Configure...' button is greyed out. `ifconfig` and `iwconfig` do yield the expected `wlan0` interface though.

I used to have `wicd` installed (and apparently it still is) but I can't see the tray icon, so I go to my "Dash", type in "wicd" and open up the Wicd Network Manager (as an aside: `wicd-client` and `wicd-gtk` from the command line didn't open up any visible interface, what's its command?).

Woohoo! I can see networks and connect to them! The reason the in-built network manager wasn't doing anything is (I guess) that wicd is managing all the networks instead.

My problem was not that wireless wasn't working, but just that I can't see the wicd wireless indicator in my notification area.

So, how do I get it showing?

Following [this answer](http://askubuntu.com/questions/69005/wicd-tray-icon-doesnt-show), I install `dconf-tools`, and then run `dconf-editor`. I  navigate to desktop>unity>panel and add `Wicd` to `systray-whitelist`. As an aside, if you want to allow any tray icon to appear, use 'all'.<!-- TODO: show image -->

Then I log out and back in. Hey presto!<!-- TODO: show image -->

## Wireless slowing down startup

Another thing I noticed is that when I start up the laptop, it spends forever on the startup screen (purple-black with "Ubuntu" and the dots underneath) saying "waiting for network configuration...", followed by "waiting another 60 secondsmore for network...", ended by "starting up without network configuration". However, my wireless _does_ work (with wicd, I don't use the standard network-manager).

Looking at [this post](http://uksysadmin.wordpress.com/2011/10/14/upgrade-to-ubuntu-11-10-problem-waiting-for-network-configuration-then-black-screen-solution/) which references [this answer on this bugreport](https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441/comments/24), it does appear that this is a bug, and you may get it if you upgrade (you won't get it from a fresh install) (?). The solution (the usual **DANGER THERE BE DRAGONS** disclaimer):

~~~ bash
mkdir -p /run /run/lock
rm -rf /var/run /var/lock
ln -s /run /var
ln -s /run/lock /var
~~~

What these do:

1. make directories `/run` and `/run/lock`
2. remove directories `/var/run` and `/var/lock`
3. create symbolic links: `/var/run` points to `/run`, and
4. `/var/lock` points to `/run/lock`.

**Argh!** This didn't solve my problem. To be continued.

<!--
`lspci | grep Network` yields:

    04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter (rev 01)

Now to work out`lsmod | grep -i rtl` yields:

    rtl8192ce 84775 0 
    rtl8192c_common 75767 1 rtl8192ce
    rtlwifi 110972 1 rtl8192ce
    mac80211 462092 3 rtl8192ce,rtl8192c_common,rtlwifi
    cfg80211 199630 2 rtlwifi,mac80211
-->
## Argh I hate hovering over the bar to open up my application!

I do like that the side launcher hides itself when you're not using it, giving you more screen real estate. I  also like the Mac-style merging of the top bit of any given window (with the min/max/restore/close buttons and the window title) is merged with the File/Edit/etc menus.

Unfortunately the side-launcher hiding means that when I want to switch between programs I can't just click on its icon and get there instantly --- I have to hover my mouse at the side of the screen to get the launcher to show, and then select my icon.

I have a few alternatives:

- I can press the meta key (windows key for my laptop) and it will show the side bar. I'll stick with this for a while --- it's a pretty good alternative. This is enabled by default.
- I can remove the autohide on the side bar to have it permanently show. I might do this on my big laptop, since it only takes up a small amount of horizontal space and the screen is big enough that I only worry about vertical space.

For completeness:

## Disabling autohide on the side bar.

### Option 1: use `ccsm`.

`ccsm` is the compiz config settings manager. You can `sudo apt-get install` it. (I already had it from my previous incarnation of Ubuntu).

Go to the 'Ubuntu Unity' plugin and you can set "Hide launcher" to "Never", or you could change the "Edge Reveal Timeout" to something small to get the launcher to autohide but appear _instantly_ when your mouse goes to the edge of the screen.

### Option 2:use `dconf`

(This is what I was initially going to do --- I discovered the compiz method by accident whilst getting my Wobbly Windows back).

You have to use `dconf` again! It's annoying, because you _should_ be able to just right-click the side launcher and select "enable/disable autohide". ahh well:

~~~ bash
dconf write /com/canonical/unity-2d/launcher/use-strut true
dconf write /com/canonical/unity-2d/launcher/hide-mode 0
~~~

Alternatively open `dconf-editor`, navigate to `/com/canonical/unity-2d/launcher/`. Change `hide-mode` to 0 and tick `use-strut` to make it True.

While you're there, have a look at the explanation for `hide-mode`:

> Possible values: **0:** never hide; the launcher is always visible. Always set /com/canonical/unity-2d/launcher/use-strut to true when using that mode. **1:** auto hide; the launcher will disappear after a short time if the user is not interacting with it. **2:** intellihide; the launcher will disappear if a window is placed on top of it and if the user is not interacting with it

So to go back to autohide, change `hide-mode` back to 2 and `use-strut` to false.

You have to log out and in again for this to work.

## Auto-login

User Accounts > Unlock > toggle "Automatic login"

## Disable lockscreen

System Settings > Screen > toggle "Lock" off

## I want my wobbly windows back :(

Install/run `ccsm` (I already had it from my previous version of Ubuntu) and re-enable.

## Customising the messenger menu

It's that little icon in the notification area that looks like an envelope:

> Easily launch and receive incoming notifications from messaging applications including email, social networking, and Internet chat.

I do like having the email notifications and functionality (the "compose email" opening up thunderbird is very cool (I set thunderbird as my default mail app)), but don't want the chat/evolution bit.

Argh --- I can't work out how to get rid of the "chat" bit and leave the "email" bit --- my only option is to remove the entire menu (`sudo apt-get remove indicator-messages`), which I don't want to do. O h well.

## Further tweaks.

[This blog post](http://www.webupd8.org/2011/10/things-to-tweak-after-installing-ubuntu.html) is one I _just_ found and it has a whole list of further tweaks.
