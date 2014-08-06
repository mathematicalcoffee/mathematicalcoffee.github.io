---
layout:   post
title:    "Be a NethackR!"
date:     2012-03-07 22:28
comments: true
categories: ~
tags: games,R
authors: [mathematical.coffee]
---
### Be a NethackR!

[Net Hack](http://www.nethack.org/) is one of the most amazing games of all times.

It's a rogue-like game, where the quest is to retrieve the Amulet of Yendor from the bottom of the dungeon and bring back it up to the top in order to sacrifice it to your deity and achieve immortal fame & glory, etc. Along the way, one must avoid the many (and I mean _many_) ways to die, including from the evil Wizard of Yendor, also known as Rodney.

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-BEb05MrU-Lg/T1hRMyUEs2I/AAAAAAAABQo/UY48fdTa1UQ/s1600/died.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="207" src="http://2.bp.blogspot.com/-BEb05MrU-Lg/T1hRMyUEs2I/AAAAAAAABQo/UY48fdTa1UQ/s320/died.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Adventuring through the dungeon (aww, I died)</td></tr>
</tbody>

There are many, _many_, **many** ways to die in Net Hack. Also, there's no saving except to resume your game later - once you die, you die. You have to restart the game from scratch. Finally, the game comes with a small hints book to get you started, but no real instructions (like "don't look at Medusa or you'll die! Don't touch a cockatrice or you'll turn to stone! Don't eat to much or you'll die of overeating (not kidding!)").

These factors all make Net Hack a very, very, hard game. And yet addictive! I have yet to win the game after a couple of years of on and off playing, but I still love it.

Anyhow, I decided to write an [R](http://www.r-project.org/) package that would let me play Net Hack in R (terminal version, of course! I wouldn't play the graphics version unless I didn't have a keyboard!).

Why would I want to play Net Hack from R? Well ... why not? :D

You can download it from [here](https://bitbucket.org/mathematicalcoffee/nethackr) - either go to the 'Downloads' page and grab the .zip file and install within R (Packages -> Install package(s) from local zip files... OR `install.packages('nethackR_1.0.1.zip',repos=NULL)`), or if you feel hackerish and are running Cygwin or Linux (or Mac? haven't tested it there), you can grab the source, unzip, and type:

    make
    make install

After that, go into R, read the help file, and start a game!

    library(nethackR)
    ?nethackR # read some help files
    ?nethack # read some help files
    nethack() # start a game!

You can even feed in nethack options:

    nethack(dogname='Indy',catname='lolcatz',hilite_pet=TRUE,time=TRUE)

Enjoy! (and let me know of bugs, I'm sure there are some).

As a note - the package comes bundled with the Net Hack executable already. You may not feel secure running an exe that the package author (me) guarantees you is the actual NetHack.exe and not one filled with viruses. If so, download NetHack yourself and place it within the `bin/your_OS-type` folder in the `nethackR` folder of your R library. `your_OS-type` is either 'unix' (for Linux and Mac) or 'windows' (for Windows). That way you can be sure the executable is safe.

Onward NethackRs!

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-YG53YtPd9cY/T1hRNC8TPMI/AAAAAAAABQ0/vTH-ARSSe7A/s1600/rip.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="238" src="http://2.bp.blogspot.com/-YG53YtPd9cY/T1hRNC8TPMI/AAAAAAAABQ0/vTH-ARSSe7A/s320/rip.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">RIP yet another character!</td></tr>
</tbody>

### Extra rambling (mainly for R people):

This was mostly an exercise in writing R packages - it was the first one I ever wrote and wanted something fun to motivate me.

It turned out to be much easier than I thought - you can just call `system('nethack')`, and R takes care of the rest, even the interactive part - it's as if I'd just run nethack from the terminal instead.

However, I then took this to Windows to test, and if I used the GUI console for R (Rgui.exe as opposed to Rterm.exe), NetHack would start but hang my system until I forcibly closed the NetHack.exe process using the System Manager.

I figured out the solution today by looking at the help file for `system` in R in Windows (turns out the help file is different in Linux and didn't include this all-important information) - turns out I can't run interactive (text) programs in Rgui, it just doesn't work.

So instead, if the user uses Rgui, the package will launch a command prompt from which the user can play.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-03-07T22:28:00-08:00">22:28</abbr>](be-nethackr.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=8148435291439087445&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8148435291439087445&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8148435291439087445&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8148435291439087445&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8148435291439087445&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8148435291439087445&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/03/be-nethackr.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [games](../../search/label/games.html), [R](../../search/label/R.html)

