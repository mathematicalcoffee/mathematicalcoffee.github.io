---
layout:   post
title:    "11.10 Oneiric: "Bad password" and rtlwifi"
date:     2012-02-15 04:02 +1000
comments: true
categories: ~
tags: [oneiric, realtek, rtlwifi, ubuntu, wifi]
authors: [amy]
---
### 11.10 Oneiric: "Bad password" and rtlwifi

Today my wireless decided to stop working (under Linux; it of course worked in Windows).

Whenever I tried to connect to a network, it (wicd, that is) would spend ages on the "authenticate" stage before eventually saying "Bad password".Of course, the password was correct. "Bad password" seems to be a generic error wicd gives you that covers all manner of actual errors.

Looking at `dmesg | tail`, I'd get a whole bunch of:

    [134.347782] rtl8192c: Loading firmware file rtlwifi/rtl8192cfw.bin
    [134.686790] ADDRCONF(NETDEV_UP): wlan0: link is not ready
    [135.037001] rtl8192c: Loading firmware file rtlwifi/rtl8192cfw.bin
    [135.376045] ADDRCONF(NETDEV_UP): wlan0: link is not ready
    [135.548216] rtl8192c: Loading firmware file rtlwifi/rtl8192cfw.bin
    [135.887744] ADDRCONF(NETDEV_UP): wlan0: link is not ready

...and so on.

`lsmod | grep rtl` yields:

    rtl8192ce 84775 0 
    rtl8192c_common 75767 1 rtl8192ce
    rtlwifi 110972 1 rtl8192ce
    mac80211 462046 3 rtl8192ce,rtl8192c_common,rtlwifi
    cfg80211 199630 2 rtlwifi,mac80211

And `lspci | grep -i network` gave

    04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter (rev 01)

After ages of googling, I found [this bug](https://bugzilla.redhat.com/show_bug.cgi?id=729618), actually a Fedora bug, that sounds a lot like mine.

Looking through the various attempts at fixes, etc, the only one that worked for me was:

    ifconfig wlan0 down
    iwconfig wlan0 mode monitor
    ifconfig wlan0 up

I know the first line switches off my wireless for a bit, the second sets the mode to 'monitor' (whatever that means??!!), and the third switches it on again, but I have no idea what this all actually means.

It'd love to have an understanding of what was wrong and why that fixed it, but I'll _definitely_ settle for having it fixed :).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-02-15T04:02:00-08:00">04:02</abbr>](1110-oneiric-bad-password-and-rtlwifi.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=292445394747498321&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=292445394747498321&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=292445394747498321&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=292445394747498321&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=292445394747498321&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=292445394747498321&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/02/1110-oneiric-bad-password-and-rtlwifi.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [oneiric](../../search/label/oneiric.html), [realtek](../../search/label/realtek.html), [rtlwifi](../../search/label/rtlwifi.html), [ubuntu](../../search/label/ubuntu.html), [wifi](../../search/label/wifi.html)

