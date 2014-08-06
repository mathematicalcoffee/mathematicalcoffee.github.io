---
layout:   post
title:    "Sending notifications in GNOME shell"
date:     2012-11-29 18:26
comments: true
categories: ~
tags: code,GNOME 3.2,GNOME 3.4,gnome-shell,GNOME3.6,javascript,tutorial
authors: [mathematical.coffee]
---
### Sending notifications in GNOME shell

This is a quick tutorial on how to send notifications in gnome shell from an extension/javascript (you can also send them over DBus but that's for another day).

- Recipe
- Longer recipe
- Explanation
- Code snippets

## Recipe

For those of you who can't wait, here is the quick way to pop up a notification:

    Main.notify('notification title', 'notification summary');

 [![](http://4.bp.blogspot.com/-oMJRlmrw2Wg/ULgMMVu7tmI/AAAAAAAABuw/ixwIHPO6PYQ/s320/main_notify.png)](http://4.bp.blogspot.com/-oMJRlmrw2Wg/ULgMMVu7tmI/AAAAAAAABuw/ixwIHPO6PYQ/s1600/main_notify.png)

The above function `Main.notify` does a number of things. I'll explain them in the next section:

## Longer recipe

To make notifications in gnome shell, you essentially create a Source (a source of notifications) and add it to the message tray, and then make a Notification and notify it from the source.

The basic steps shown below demonstrate this, although in practice one may wish to use various subclasses of the Source or Notification classes.

1. 

Create a _subclass of_ `MessageTray.Source` (in GNOME 3.2 or 3.4), or a `MessageTray.Source` in GNOME 3.6:

    // example in GNOME 3.2 and 3.4.
    // SystemNotificationSource subclasses MessageTray.Source
    let source = new MessageTray.SystemNotificationSource();
    // example in GNOME 3.6 - we can use MessageTray.Source() directly
    let source = new MessageTray.Source('source title', 'source-icon-name');

2. 

Create a Notification, passing in the source, title, and summary:

    let notification = new MessageTray.Notification(source,
                                                    'notification title',
                                                    'notification summary');

3. 

Add the source to the message tray. This is so that the icon appears in the message tray (and no notification will pop up unless its source is added):

    Main.messageTray.add(source);

4. 

Either notify the notification from the source, or simply add it (without notifying):

    // adds the notification to the source and pops it up
    source.notify(notification);
    
    
    // OR:
    
    
    // just adds the notification to the source (doesn't pop it up)
    source.pushNotification(notification);

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s1600/notification_source.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="63" src="http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s320/notification_source.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The example we will work through in this post</td></tr>
</tbody>

## Explanation

Here I'll explain the two main classes: a `Source` and a `Notification`.

### Source

Think of a `Source` as a source of notifications - many notifications can come from the same source (for example many email notifications coming from your one email client).In fact, all notifications _require_ a source.

You can also think of a `Source` as the icon in the message tray (that you click on to show its notifications).

The basic `Source` class is `MessageTray.Source`. To be used, it needs to know what icon to show in the Message Tray.

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-0wVeJen0zBI/ULgNiDmCJzI/AAAAAAAABvI/51t9Ws0L02I/s1600/source.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-0wVeJen0zBI/ULgNiDmCJzI/AAAAAAAABvI/51t9Ws0L02I/s1600/source.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The Source provides the icon in the message tray. </td></tr>
</tbody>

#### GNOME 3.6

In GNOME 3.6, the way to do this is to feed the icon's name into `MessageTray.Source`'s constructor (along with the title of the source):

    let source = new MessageTray.Source("Source title", 'avatar-default');

Alternatively if you wanted something more fancy, you could override `Source.createIcon(size)` in a subclass to return an icon of the appropriate size for the source.

#### GNOME 3.2, 3.4

In GNOME 3.2 and 3.4, you tell the Source what icon it should show in the message tray with one of two methods:

a. when you create a notification for the source, set the icon explicitly in the notification, **OR** b. subclass it, implement the `createNotificationIcon()` function and call `_setSummaryIcon` with it in the constructor.

Method b. is the one most commonly used, but to do method a) you feed in an object as the fourth parameter to MessageTray.Notification with an 'icon' property (explained a bit more in the Notification section):

    let source = new MessageTray.Source("source title");
    let notification = new MessageTray.Notification(source,
                                                    "notification title",
                                                    "notification message",
                                                    {icon: new St.Icon({
                                                        icon_name: 'avatar-default',
                                                        icon_size: source.ICON_SIZE})
                                                    });
    
    
    // add the source to the message tray and pop up the notification
    Main.messageTray.add(source);
    source.notify(notification);

The bare minimum implementation of a subclass of MessageTray.Source (to demonstrate method b.) is:

    const MySource = new Lang.Class({
        Name: 'MySource',
        Extends: MessageTray.Source,
        _init: function (title) {
            // call the parent constructor
            this.parent(title); 
            // set our icon
            this._setSummaryIcon(this.createNotificationIcon());
        },
    
    
        // this should return an icon to show in the message tray. You can use
        // this.ICON_SIZE for a default icon size if you want.
        createNotificationIcon: function () {
            return new St.Icon({
                icon_name: 'avatar-default',
                icon_size: this.ICON_SIZE
            });
        }
    });

One would use it like so:

    let source = new MySource("source title");
    let notification = new MessageTray.Notification(source, "title", "message");
    
    
    // add the source to the message tray and pop up the notification
    Main.messageTray.add(source);
    source.notify(notification);

### Notification

Recall that every notification must belong to a source. Once a notification is added to its source, it can also be "notified".

When a notification is "notified", it pops up from the bottom of the screen showing the user the notification's title and the first line of its details (if they fit).

<tbody>
<tr><td style="text-align: center;">
<div class="separator" style="clear: both; text-align: center;">
<a href="http://3.bp.blogspot.com/-cEjWF-t6Qtc/ULgMPHxPG-I/AAAAAAAABu4/RtiaVtSO10c/s1600/notification_banner.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="23" src="http://3.bp.blogspot.com/-cEjWF-t6Qtc/ULgMPHxPG-I/AAAAAAAABu4/RtiaVtSO10c/s320/notification_banner.png" width="320"></a>
</div>
<a href="http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s1600/notification_source.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="63" src="http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s320/notification_source.png" width="320"></a>
</td></tr>
<tr><td class="tr-caption" style="text-align: center;">A notification upon being notified (above); the same notification being opened from its source (below). </td></tr>
</tbody>

Hovering the mouse over the notification will expand it, showing the full summary of the notification.

Actually _clicking_ on the notification will usually dismiss it (unless you override this behaviour).

After a while the notification will time out, dropping back down off the screen.

After this happens there are a couple of options:

- if the notification is set as "transient", it will disappear forever. Make a notification transient with `notification.setTransient(true)`.
- otherwise (the default), it will now reside in the message tray. Clicking on the notification's icon in the message tray will show the notification, from which it may be dismissed (by clicking on it).
- if you want a notification to _never_ be able to be dismissed (by clicking on it after clicking on its source in the message tray), you can set the notification to be "resident". Do this with `notification.setResident(true)`.

The base notification class is `MessageTray.Notification`, and it allows the construction of very versatile notifications.At its most basic, the notification has a text title and a text summary:

    let notification = new MessageTray.Notification(source,
                                                    'notification title',
                                                    'notification message');

One can also feed in an (optional) parameters object giving the notification's icon. One typically uses an icon size of `source.ICON_SIZE` (24 pixels) to create the icon:

    // source is whatever Source this notification belongs to
    let notification = new MessageTray.Notification(
        source,
        'notification title',
        'notification message', {
        icon: new St.Icon({
            icon_name: 'avatar-default',
            icon_size: source.ICON_SIZE
        })
    });

However, it is also possible to construct much more complex notifications. One can add buttons to the notification with `notification.addButton`, add extra text labels to it with `notification.addBody`, or extra actors (entry boxes, pictures, ...) to it with `notification.addActor`.

For an example of a notification with buttons on it, see the Telepathy Client `AudieoVideoNotification` (in `telepathyClient.js`), which has two buttons for the user to accept or reject a call.

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-vAP7p56Lajo/UFLK-ZQG_tI/AAAAAAAABjY/HZFWcbGqBs0/s1600/telepathyClient.AudioVideoNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="93" src="http://1.bp.blogspot.com/-vAP7p56Lajo/UFLK-ZQG_tI/AAAAAAAABjY/HZFWcbGqBs0/s320/telepathyClient.AudioVideoNotification.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">AudioVideoNotification has had buttons added</td></tr>
</tbody>

For an example of a very complex notification, see the `TelepathyClient.ChatNotification` in `telepathyClient.js`. This adds chat texts to a scrollable area, and adds an entry box for typing chat messages.

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-fYqil14Dmz4/UFLK_SF73wI/AAAAAAAABjg/Bmvp_vOZLao/s1600/telepathyClient.Chat.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="179" src="http://3.bp.blogspot.com/-fYqil14Dmz4/UFLK_SF73wI/AAAAAAAABjg/Bmvp_vOZLao/s320/telepathyClient.Chat.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">ChatNotifiation is a very complex custom notification</td></tr>
</tbody>

## Bringing it all together

Code snippet - notifying a notification with the 'avatar-default' icon. This will create the notification shown below.

 [![](http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s320/notification_source.png)](http://2.bp.blogspot.com/-bs8Xv4yBA2o/ULgQGcJXncI/AAAAAAAABvg/_KU82yHMcB0/s1600/notification_source.png)

### GNOME 3.2 and 3.4

Where we give the source icon via the notification:

    // 1. Make a source
    let source = new MessageTray.Source("source title");
    // 2. Make a notification
    let notification = new MessageTray.Notification(source,
                                                    "notification title",
                                                    "notification message",
                                                    {icon: new St.Icon({
                                                        icon_name: 'avatar-default',
                                                        icon_size: source.ICON_SIZE
                                                    })});
    // 3. Add the source to the message tray
    Main.messageTray.add(source);
    // 4. notify!
    source.notify(notification);

Where we create our own source subclass:

    const MySource = new Lang.Class({
        Name: 'MySource',
        Extends: MessageTray.Source,
        _init: function (title) {
            // call the parent constructor
            this.parent(title); 
            // set our icon
            this._setSummaryIcon(this.createNotificationIcon());
        },
    
    
        // this should return an icon to show in the message tray. You can use
        // this.ICON_SIZE for a default icon size if you want.
        createNotificationIcon: function () {
            return new St.Icon({
                icon_name: 'avatar-default',
                icon_size: this.ICON_SIZE
            });
        }
    }); 
    
    
    // 1. Make a source
    let source = new MySource("source title");
    // 2. Make a notification
    let notification = new MessageTray.Notification(source,
                                                    "notification title",
                                                    "notification message");
    // 3. Add the source to the message tray
    Main.messageTray.add(source);
    // 4. notify!
    source.notify(notification);

### GNOME 3.6

    // 1. Make a source
    let source = new MessageTray.Source("source title", 'avatar-default');
    // 2. Make a notification
    let notification = new MessageTray.Notification(source,
                                                    "notification title",
                                                    "notification message");
    // 3. Add the source to the message tray
    Main.messageTray.add(source);
    // 4. notify!
    source.notify(notification);

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-11-29T18:26:00-08:00">18:26</abbr>](sending-notifications-in-gnome-shell.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=4510693801609964109&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4510693801609964109&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4510693801609964109&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4510693801609964109&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4510693801609964109&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4510693801609964109&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/11/sending-notifications-in-gnome-shell.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [GNOME 3.2](../../search/label/GNOME%203-2.html), [GNOME 3.4](../../search/label/GNOME%203.html), [gnome-shell](../../search/label/gnome-shell.html), [GNOME3.6](../../search/label/GNOME3.html), [javascript](../../search/label/javascript.html), [tutorial](../../search/label/tutorial.html)

