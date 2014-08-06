---
layout:   post
title:    "ggpie: pie graphs in ggplot2"
date:     2014-06-26 00:27 +1000
comments: true
categories: ~
tags: [code, ggplot2, R]
authors: [amy]
---
### ggpie: pie graphs in ggplot2

How does one make a pie chart in R using `ggplot2`? (If you're impatient: see the final code here).

I know, I know, pie charts are often not very good ways of displaying data. It is hard to visually compare the relative sizes of slices (particularly the smaller ones and if they are scattered with larger ones in between), and you get no sense of scale.

However, sometimes a good ol' pie chart can convey your point in a way that many of the general public will find easy to understand. For example, this is how I've spent my "work" hours this week so far:

 [![](http://1.bp.blogspot.com/-HY1rTjjg59E/U6vDOF_8K_I/AAAAAAAAD90/RdHIb0Xie_w/s1600/unnamed-chunk-2.png)](http://1.bp.blogspot.com/-HY1rTjjg59E/U6vDOF_8K_I/AAAAAAAAD90/RdHIb0Xie_w/s1600/unnamed-chunk-2.png)

(I manually inserted the line break into "marking exams" so it wouldn't get cut off - not sure how to automatically do this).

Terrible, I know. But the plot conveys quite clearly the point I want to make: I wasted away almost half (!) of my week so far playing nethack when I should have been doing my PhD, which is much more time than I have spent on my PhD itself!

(Aside: [nethack](http://en.wikipedia.org/wiki/NetHack) is a most excellent ASCII game that can be obtained [here](http://www.nethack.org/), or from your repositories on most Linux systems. In my defence, during the month of June the [Junethack tournament](https://junethack.de/) is run and [clan overcaffeinated (me)](https://junethack.de/clan/overcaffeinated) is in a deadly battle with [clan demilichens](https://junethack.de/clan/demilichens) to win the "most unique deaths" trophy. And this is the last week of June).

## How to do it

My data looks like this (I've been using [hamster time tracker](http://projecthamster.wordpress.com/about/), though I keep forgetting to track things.):

<caption>How I've spent my PhD hours this week</caption><colgroup>
<col width="25%">
<col width="8%">
</colgroup><thead>
<tr class="header">
<th align="center">activity</th>
<th align="center">time</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">Nethack</td>
<td align="center">15.2</td>
</tr>
<tr class="even">
<td align="center">PhD</td>
<td align="center">7.4</td>
</tr>
<tr class="odd">
<td align="center">Marking exams</td>
<td align="center">4</td>
</tr>
<tr class="even">
<td align="center">Meetings</td>
<td align="center">2.3</td>
</tr>
<tr class="odd">
<td align="center">Lunch</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Writing this post</td>
<td align="center">1.5</td>
</tr>
</tbody>

My first attempt at building a pie chart of this data follows the [ggplot2 documentation for coord\_polar](http://docs.ggplot2.org/current/coord_polar.html) and [this excellent post on r-chart](http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html). There are also a number of relevant questions on StackOverflow.

First we construct a stacked bar chart, coloured by the activity type (`fill=activity`). Note that `x=1` is a dummy variable purely so that ggplot has an x variable to plot by (we will remove the label later).

(Aside: if `x` is a factor (e.g. `factor("dummy")`) for some reason the bar does not get full width, and the resulting pie chart has a funny little hole in the middle).

    p <- ggplot(df, aes(x=1, y=time, fill=activity)) +
            geom_bar(stat="identity") +
            ggtitle("How I've spent my PhD hours this week")
    print(p)

 [![](http://1.bp.blogspot.com/-aL-Zmjo7hhA/U6vDOCRdZwI/AAAAAAAAD94/JNVezCam5qY/s1600/unnamed-chunk-4.png)](http://1.bp.blogspot.com/-aL-Zmjo7hhA/U6vDOCRdZwI/AAAAAAAAD94/JNVezCam5qY/s1600/unnamed-chunk-4.png)

Then we use `coord_polar()` to turn it into a pie chart:

    p <- p + coord_polar(theta='y')
    print(p)

 [![](http://4.bp.blogspot.com/-7q3Qt0_llGo/U6vDPJl2hwI/AAAAAAAAD-M/M7Rv4tkWt60/s1600/unnamed-chunk-5.png)](http://4.bp.blogspot.com/-7q3Qt0_llGo/U6vDPJl2hwI/AAAAAAAAD-M/M7Rv4tkWt60/s1600/unnamed-chunk-5.png)

(Aside: does anyone find it weird that although my x axis was 1 and my y axis was `time`, on the resultant graph the x axis is now 'time' and the y axis is now 1?)

Let's tweak this so it doesn't look so bad.

First, some pure aesthetics: let's outline each slice of the pie in black using `color='black'` in `geom_bar()`. This causes there to be an ugly black line and outline on each square of the legend, so we remove that.

    # We have to start the plot again because `color='black'` goes into geom_bar
    p <- ggplot(df, aes(x=1, y=time, fill=activity)) +
            ggtitle("How I've spent my PhD hours this week") +
            coord_polar(theta='y')
    p <- p +
            # black border around pie slices
            geom_bar(stat="identity", color='black') +
            # remove black diagonal line from legend
            guides(fill=guide_legend(override.aes=list(colour=NA)))
    print(p)

 [![](http://2.bp.blogspot.com/-JRBbwI1oBTg/U6vDPdDdaSI/AAAAAAAAD-U/TsXJ4nZOaTU/s1600/unnamed-chunk-6.png)](http://2.bp.blogspot.com/-JRBbwI1oBTg/U6vDPdDdaSI/AAAAAAAAD-U/TsXJ4nZOaTU/s1600/unnamed-chunk-6.png)

Now, remove the axes:

- both the axis labels ("time", "1"),
- the tick marks on the vertical axis,
- the tick labels on the vertical axis (0.75, 1.00, 1.25).

Note - for some reason, although `1` was our `x` variable, you remove its tick label by setting `axis.text.y`...

    p <- p +
        theme(axis.ticks=element_blank(), # the axis ticks
              axis.title=element_blank(), # the axis labels
              axis.text.y=element_blank()) # the 0.75, 1.00, 1.25 labels.
    print(p)

 [![](http://4.bp.blogspot.com/-_WbRAD1cWlE/U6vDPmgVazI/AAAAAAAAD-c/goQBKmTtofQ/s1600/unnamed-chunk-7.png)](http://4.bp.blogspot.com/-_WbRAD1cWlE/U6vDPmgVazI/AAAAAAAAD-c/goQBKmTtofQ/s1600/unnamed-chunk-7.png)

Now, I should also remove the '0', '5', '10', '15' tick marks/labels, being the cumulative number of hours spent so far, since they're not meaningful.

However, I want to label each slice of the pie, and it is convenient to put my labels in place of the '0', '5', etc.

In terms of their _position_, they should be located at the midpoint of each pie slice. Think back to the stacked bar chart I produced at the start, and recall that the y axis (`time`) shows cumulative hours spent.

This means the y coordinate of the _end_ of each slice is given by `cumsum(df$time)` (cumulative sum of time spent so far), and so the coordinate of the _midpoint_ of each slice is given by:

    y.breaks <- cumsum(df$time) - df$time/2
    y.breaks

    ## [1] 7.60 18.90 24.60 27.75 29.90 31.65

In order to implement this in the pie chart, we use `scale_y_continuous` with the `breaks` argument being the coordinates we've just calculated, and the `labels` argument being the activity name.

    p <- p +
        # prettiness: make the labels black
        theme(axis.text.x=element_text(color='black')) +
        scale_y_continuous(
            breaks=y.breaks, # where to place the labels
            labels=df$activity # the labels
        )
    print(p)

 [![](http://4.bp.blogspot.com/-p3H3wu0YcfM/U6vDQX1gqYI/AAAAAAAAD-Y/ZdvxCddplyQ/s1600/unnamed-chunk-9.png)](http://4.bp.blogspot.com/-p3H3wu0YcfM/U6vDQX1gqYI/AAAAAAAAD-Y/ZdvxCddplyQ/s1600/unnamed-chunk-9.png)

Altogether now:

    p <- ggplot(df, aes(x=1, y=time, fill=activity)) +
            ggtitle("How I've spent my PhD hours this week") +
            # black border around pie slices
            geom_bar(stat="identity", color='black') +
            # remove black diagonal line from legend
            guides(fill=guide_legend(override.aes=list(colour=NA))) +
            # polar coordinates
            coord_polar(theta='y') +
            # label aesthetics
            theme(axis.ticks=element_blank(), # the axis ticks
                  axis.title=element_blank(), # the axis labels
                  axis.text.y=element_blank(), # the 0.75, 1.00, 1.25 labels
                  axis.text.x=element_text(color='black')) +
            # pie slice labels
            scale_y_continuous(
                breaks=cumsum(df$time) - df$time/2,
                labels=df$activity
            )

## TL;DR

I've tied it together into a function `ggpie`:

    library(ggplot2)
    # ggpie: draws a pie chart.
    # give it:
    # * `dat`: your dataframe
    # * `by` {character}: the name of the fill column (factor)
    # * `totals` {character}: the name of the column that tracks
    # the time spent per level of `by` (percentages work too).
    # returns: a plot object.
    ggpie <- function (dat, by, totals) {
        ggplot(dat, aes_string(x=factor(1), y=totals, fill=by)) +
            geom_bar(stat='identity', color='black') +
            guides(fill=guide_legend(override.aes=list(colour=NA))) + # removes black borders from legend
            coord_polar(theta='y') +
            theme(axis.ticks=element_blank(),
                axis.text.y=element_blank(),
                axis.text.x=element_text(colour='black'),
                axis.title=element_blank()) +
        scale_y_continuous(breaks=cumsum(dat[[totals]]) - dat[[totals]] / 2, labels=dat[[by]])    
    }

For example:

    library(grid) # for `unit`
    ggpie(df, by='activity', totals='time') +
        ggtitle("A fun but wasteful week.") +
        theme(axis.ticks.margin=unit(0,"lines"),
              plot.margin=rep(unit(0, "lines"),4))

 [![](http://1.bp.blogspot.com/-VZndb208OS4/U6vDOFthMbI/AAAAAAAAD98/kwkKCA5oSjQ/s1600/unnamed-chunk-11.png)](http://1.bp.blogspot.com/-VZndb208OS4/U6vDOFthMbI/AAAAAAAAD98/kwkKCA5oSjQ/s1600/unnamed-chunk-11.png)

(Note: for some reason the pie plots have an unreasonably large amount of white space, and the `theme(*.margin)` settings are an attempt to control that. However, I still get a lot of vertical space that I'm not sure how to compress).

Clearly the labels could do with more work (if they are too long they go out of the plot boundary, or they bump into the pie chart), but not bad for an hour and a half's work :)

Posted by [mathematical.coffee](http://draft.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2014-06-26T00:27:00-07:00">00:27</abbr>](ggpie-pie-graphs-in-ggplot2.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://draft.blogger.com/post-edit.g?blogID=7039473604287682752&postID=4902109804664259933&from=pencil "Edit Post")
 [Email This](http://draft.blogger.com/share-post.g?blogID=7039473604287682752&postID=4902109804664259933&target=email "Email This") [BlogThis!](http://draft.blogger.com/share-post.g?blogID=7039473604287682752&postID=4902109804664259933&target=blog "BlogThis!") [Share to Twitter](http://draft.blogger.com/share-post.g?blogID=7039473604287682752&postID=4902109804664259933&target=twitter "Share to Twitter") [Share to Facebook](http://draft.blogger.com/share-post.g?blogID=7039473604287682752&postID=4902109804664259933&target=facebook "Share to Facebook") [Share to Pinterest](http://draft.blogger.com/share-post.g?blogID=7039473604287682752&postID=4902109804664259933&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2014/06/ggpie-pie-graphs-in-ggplot2.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [ggplot2](../../search/label/ggplot2.html), [R](../../search/label/R.html)

