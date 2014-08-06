---
layout:   post
title:    "Upgrading your GNOME shell extensions from 3.4 to 3.6"
date:     2012-11-08 17:07 +1000
comments: true
categories: ~
tags: [code, developing, GNOME 3.4, gnome-shell-extension, GNOME3.6]
authors: [amy]
---
### Upgrading your GNOME shell extensions from 3.4 to 3.6

I recently started upgrading all my extensions from 3.4 to 3.6. Here are a few things I ran into:

### New useful things:

- 

you can reload just a single extension rather than restarting GNOME-shell. To do it by UUID:

    Main.shellDBusService._extensionSerivce.ReloadExtension(UUID)        
    // **NOTE** the typo 'Serivce' --> this is a typo in 3.6.0 and 3.6.1

OR, if you prefer not to have the typo:

    const ExtensionUtils = imports.misc.extensionUtils;              
        const ExtensionSystem = imports.ui.extensionSystem;                         
        ExtensionSystem.reloadExtension(ExtensionUtils.extensions[UUID]);

### Gotchas for extension developers!

Whenever you enter the lock screen all the extensions get disabled until the user logs back in, and then they get re-enabled.

This means: **your extension must be able to disable and re-enable itself smoothly!**

Before this wasn't so important because typically a user does not toggle their extensions on and off many times within one session; so extensions typically get enabled once (when the user logs in) and not disabled until the user logs out, after which it doesn't matter whether it disables cleanly or not.

I've noticed quite a few extensions (including most of mine, oops...) that don't disable cleanly at the lock screen and hence don't re-enable cleanly once unlocked, causing all sorts of havoc...

### Changes (some)

Some changes I noticed (certainly not all of them; just ones relevant to [my extensions](https://extensions.gnome.org/accounts/profile/mathematical.coffee) and a few others I use):

- `~/.xsession-errors` got renamed to `~/.cache/gdm/session.log` (calls to `log` output here, as well as in the terminal if you're running gnome-shell from the terminal).
- `panel._menus` -> `panel.menuManager` (main panel popup menu manager is now public)
- `panel._statusArea` -> `panel.statusArea` (status area is now public)
- `panel._dateMenu` -> `panel.statusArea.dateMenu` (date menu etc have all been stored in the status area and now is public)
- `panel._appMenu` -> `panel.statusArea.appMenu` (app menu moved to the status area, and now is public)
- `overview._workspacesDisplay` -> `overview._viewSelector._workspacesDisplay` (the "windows" tab of the overview)
- search providers: in GNOME 3.4 we had `getInitialResultSet` (which returns an array of results) and `getInitialResultSetAsync` (which calls `this.searchSystem.pushResults`). In GNOME 3.6 there is _just_ `getInitialResultSet`, which takes an extra argument `callback` and should call `this.searchSystem.pushResults` on the results (rather than returning them) and _also_ apply `callback` to the results.
- Use `Main.panel.addToStatusArea(unique_name_of_indicator, inidicator, position, box)` to add a SystemStatusButton or PanelButton to the panel. This handles adding its menu to the menu manager for you (box is Main.panel.\_{left, right, center}Box, omitting the box argument gives right box by default, and ommitting position gives position 0). If your button is a ButtonBox only (i.e. no menu) then stick with. `_{left, right, center}Box.insert_child_at_index`.
- Symbolic/Full-colour Icons: previously system status buttons would always do a symbolic icon. Now they will do either full colour or symbolic. Use 'iconname' to get the full colour and 'iconname-symbolic' to get symbolic icons (so if your extension made a SystemStatusButton in 3.4, to get it looking the same in 3.6 you have to add '-symbolic' to the icon name).
- Overview - the "tab" system where you could click on the "Windows" or "Applications" tab has been removed (!!!). Instead the windows tab is shown by default (as before) and to get to the application tab you click on the applications button on the dash. This means you can no longer simply add your own tabs to the overview, like [the Extension List extension](https://extensions.gnome.org/extension/320/extension-list/) did (which added an "Extensions" tab to manage your extensions from). This is a **major** regression, in my opinion!
- Looking glass - there's no longer an "Errors" tab. `global.log` used to output to the Errors tab whereas `log` would output to the terminal. Now they all output to the terminal if you're running from the terminal (makes more sense than having two separate logging systems).
- System status icons and panel menu buttons. The top-level actor 'indicator.actor' is _NOT_ the top-level actor that is placed into the panel. There is a new member 'indicator.container' which is a St.Bin that _contains_ 'indicator.actor', and 'indicator.conainer' is what gets put into the panel boxes. So if you were previously looping through \*Box.get\_children() and accessing `child._delegate` to get the associated `PanelMenu.Button`, now you have to access `child.child._delegate`.
- StatusIconDispatcher - in GNOME 3.2 and 3.4, this listens to icons being added by application to the tray (for example Dropbox) and depending on the type, either emits 'status-icon-added' or 'message-icon-added'. The Panel listens to the former to make a button in the top panel for the icon, and the NotificationDaemon listens to the latter to make an icon in the message tray for the icon. This let some icons be "dispatched" to the top panel and others to the bottom without overlap. In 3.6, this class has been removed and the functionality implemented directly into the classes; if the notification daemon gets 'tray-icon-added' it will make an icon in the message tray for it _unless_ it's a standard status icon, but the top panel _won't_ make top panels for these.
- Contact Search Provider (contactDisplay.js) was removed. Apparenty `gnome-contacts` is implementing one so it's no longer necessary.
- lock screens: there is a new lock screen in GNOME3.6 that wasn't there in 3.4. It's the one where you have to swipe up (to drag the screen up).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-11-08T17:07:00-08:00">17:07</abbr>](upgrading-your-gnome-shell-extensions.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=4320637073470736185&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4320637073470736185&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4320637073470736185&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4320637073470736185&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4320637073470736185&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=4320637073470736185&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/11/upgrading-your-gnome-shell-extensions.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [developing](../../search/label/developing.html), [GNOME 3.4](../../search/label/GNOME%203.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [GNOME3.6](../../search/label/GNOME3.html)

