---
layout:   post
title:    "Installing RStudio Server on Fedora 18"
date:     2013-04-17 18:38
comments: true
categories: ~
tags: fedora,R,RStudio
authors: [mathematical.coffee]
---
### Installing RStudio Server on Fedora 18

I'm trying to install [RStudio Server](http://www.rstudio.com/ide/download/server) on Fedora 18 (64bit) but keep getting an error about `libcrypto.so.6` and `libssl.so.6`. (I didn't enable EPEL as I am not on RedHat/CentOS).

Following the installation instructions, I:

    wget http://download2.rstudio.org/rstudio-server-0.97.336-x86_64.rpm
    sudo yum install --nogpgcheck rstudio-server-0.97.336-x86_64.rpm

But I get the error:

    Error: Package: rstudio-server-0.97.336-1.x86_64 (/rstudio-server-0.97.336-x86_64)
               Requires: libcrypto.so.6()(64bit)
    Error: Package: rstudio-server-0.97.336-1.x86_64 (/rstudio-server-0.97.336-x86_64)
               Requires: libssl.so.6()(64bit)

If I look in `/usr/lib64` I have (both from the `openssl-libs` package: `yum provides /usr/lib64/libssl.so.10`):

    /usr/lib64/libcrypto.so.10
    /usr/lib64/libssl.so.10

So it appears my package versions are too new for RStudio Server (!).

I decided to try the hacky solution of making some links from the old version to the new (hoping that they are backwards-compatible):

    sudo ln -s /usr/lib64/libcrypto.so.10 /usr/lib64/libcrypto.so.6
    sudo ln -s /usr/lib64/libssl.so.10 /usr/lib64/libssl.so.6

Now I attempt to install again, and use `rpm --nodeps` instead of `yum` to force installation:

    sudo rpm -ivh --nodeps rstudio-server-0.97.336-x86_64.rpm

It works!

    Preparing... ################################# [100%]
    Updating / installing...
       1:rstudio-server-0.97.336-1 ################################# [100%]
    rsession: no process found
    Stopping rstudio-server (via systemctl): [OK]
    Starting rstudio-server (via systemctl): [OK]

(Note - if it's still complaining to you about not finding libraries, try

    sudo ldd /usr/lib/rstudio-server/bin/rserver | grep 'not found'

You might get something like:

    libssl.so.6 => not found
    libcrypto.so.6 => not found

This will tell you which libraries you need to make links for.)

I can test whether it worked OK by opening a browser and pointing it to `http://127.0.0.1:8787`:

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-XyLXuhSSjEw/UW9NtEHT4eI/AAAAAAAAByU/zOzQDj33Zqs/s1600/rstudio.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://1.bp.blogspot.com/-XyLXuhSSjEw/UW9NtEHT4eI/AAAAAAAAByU/zOzQDj33Zqs/s320/rstudio.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Huzzah! RStudio Server!</td></tr>
</tbody>

To enable external access I had to open port 8787 for my firewall (you could use the firewall applet for this instead of command-line)

    iptables -A INPUT -p tcp --dport 8787 -j ACCEPT

Now I can continue with the [rest of the instructions](http://www.rstudio.com/ide/docs/server/getting_started)! Yay!

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2013-04-17T18:38:00-07:00">18:38</abbr>](installing-rstudio-server-on-fedora-18.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=3674172317330184561&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3674172317330184561&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3674172317330184561&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3674172317330184561&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3674172317330184561&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=3674172317330184561&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2013/04/installing-rstudio-server-on-fedora-18.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [fedora](../../search/label/fedora.html), [R](../../search/label/R.html), [RStudio](../../search/label/RStudio.html)

