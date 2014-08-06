---
layout:   post
title:    "Shell Extensions in Gnome 3.2/Fedora 16"
date:     2012-04-12 20:29
comments: true
categories: ~
tags: fedora,gnome,gnome-shell
authors: [mathematical.coffee]
---
### Shell Extensions in Gnome 3.2/Fedora 16

I just upgraded my work computer from Fedora 15 to Fedora 16, which uses Gnome 3.2. This is my first real experience with the GNOME shell in Fedora, because I got rid of it straight away (fallback mode) in F15 since I couldn't stand it so haven't used it since.

Anyhow, I thought I'd give it a shot this time as the GNOME team have apparently been doing good things with the newer versions of GNOME shell.

My first impression - danger Will Robinson! Switch back to fallback mode!

- poor support for dual monitor which I use at work: top panel is only on one screen
- to get to the Overview to switch/view windows I have to hover over the top left corner of the left-most screen, rather than just clicking a window from the top panel
- the clock is in the middle of my top panel, meaning I wouldn't be able to see my current window title, _except_ that
- the window title of the current window I'm in doesn't show in the top panel. Just the application name. 

I was just about to switch to fallback mode again, when I discovered [GNOME shell extensions](https://extensions.gnome.org/about/).These are little plugins (think of them like browser plugins) that add functionality to the GNOME shell interface.

Below I'll summarise some of the shell extensions that I found at the [GNOME shell extensions website](https://extensions.gnome.org/) that rectified my problems. You generally install them from that website, and then use `gnome-tweak-tool` (or "Advanced Settings" in Fedora) to toggle them on and off.

You'll need to log out and in again or restart the shell (Alt+F2, type 'r' for restart, press Enter) to have them take effect.

### Top Panel

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-LRFm3fT1l-I/T4ePonVPNUI/AAAAAAAABSg/AmDlRetODUg/s1600/extensions_moveclock.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="24" src="http://3.bp.blogspot.com/-LRFm3fT1l-I/T4ePonVPNUI/AAAAAAAABSg/AmDlRetODUg/s320/extensions_moveclock.png" width="256"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Frippery Move Clock moves the clock to the left</td></tr>
</tbody>

[Frippery Move Clock](https://extensions.gnome.org/extension/2/move-clock/) This moves the clock from the centre of the panel to the left of the status menu button (over the right of the screen). This frees up space for extensions that show icons for open windows, etc. Essential.

[Extend Left Box](https://extensions.gnome.org/extension/51/extend-left-box/) This allows extensions using the top panel (e.g. window list extensions) to use the whole of the top panel instead of just the left half. Essential.

[Status Title Bar](https://extensions.gnome.org/extension/59/status-title-bar/) This shows the entire title (e.g. "Blogger: Mathematical Coffee - Edit post - Google chrome") of your current window in the top panel, rather than just the application name ("Chrome"). Whether to use this or not depends on your top panel real-estate.

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-4LlHjx-V7J8/T4eP5ELNhlI/AAAAAAAABSs/TIAH9UYin-A/s1600/extensions_windowTitle.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="14" src="http://3.bp.blogspot.com/-4LlHjx-V7J8/T4eP5ELNhlI/AAAAAAAABSs/TIAH9UYin-A/s320/extensions_windowTitle.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Status Title Bar with Extend Left Box show the full window title</td></tr>
</tbody>

### Notification Icons
The following extensions affect the notification icons up the top-right of the screen (accessibility, volume, ...) and the messaging tray at the bottom of the screen.   

[Evil Status Icon Forever](https://extensions.gnome.org/extension/99/evial-status-icon-forerver/) There are many extensions that hide icons (e.g. accessibility) or move icons from the messaging tray to the notification bar (dropbox, ...), but this one seems to cover the functionality of all of them. This allows you to set which notification icons to move from the messaging tray to the top panel (I added dropbox and guake up there) and which to hide (the accessibility icon). For instructions see [here](https://github.com/brianhsu/EvilStatusIconForever).

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-eWjnetxTTnc/T4eP_4WAiVI/AAAAAAAABS4/7ev_XGQ_FOo/s1600/extensions_evil-status-icon.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="19" src="http://1.bp.blogspot.com/-eWjnetxTTnc/T4eP_4WAiVI/AAAAAAAABS4/7ev_XGQ_FOo/s320/extensions_evil-status-icon.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Evil Status Icon Forever lets me put dropbox &amp; other icons up the top; <br>notice also the workspace indicator.</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-xBV0Y5Pommw/T4eZhqMM8nI/AAAAAAAABT0/16OLK8gvjiM/s1600/screenshot_8.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="208" src="http://4.bp.blogspot.com/-xBV0Y5Pommw/T4eZhqMM8nI/AAAAAAAABT0/16OLK8gvjiM/s320/screenshot_8.png" width="113"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Places menu</td></tr>
</tbody>

[Places Status Indicator](https://extensions.gnome.org/extension/8/places-status-indicator/) adds a folder to the notification tray that, when clicked, shows a list of folders to open in nautilus.

If you want to remove an individual icon (accessibility, bluetooth, volume, ..) from the notification bar, use Evil Status Icon Forever. If for some reason you don't want to do that, you can install the [volume icon remover](https://extensions.gnome.org/extension/124/volume-icon-remover/), [bluetooth icon remover](https://extensions.gnome.org/extension/125/bluetooth-icon-remover/), or `gnome-shell-extension-remove-accessibility-icon` from the fedora repositories.

[Workspace indicator](https://extensions.gnome.org/extension/21/workspace-indicator/) adds a little drop-down menu from the notification area letting you switch between workspaces (The '1' in the box in the above picture). Since I added this functionality on my docklet (later in this post), I didn't need this any more).

### Status Icon
The "Status Icon" is the menu at the top-right of your panel with a speech bubble next to your user name.The speech bubble is your chat availability - you can control it from there. The menu also contains the "System Settings", "Log out", etc options.  

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-jVUn7sfnS34/T4eQTQAKIQI/AAAAAAAABTE/stbAvzoWn3A/s1600/status_menu.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://1.bp.blogspot.com/-jVUn7sfnS34/T4eQTQAKIQI/AAAAAAAABTE/stbAvzoWn3A/s320/status_menu.png" width="182"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Chat, Hibernate, Power Off options;<br>No name on the button</td></tr>
</tbody>

[Alternative Status Menu](https://extensions.gnome.org/extension/5/alternative-status-menu/) By default the status menu only gives a "Suspend" option for closing your computer, and you have to hold down Alt to see "Hibernate" or "Power Off". This extension adds the "Hibernate" and "Power Off" buttons _permanently_ to the menu. Very useful (for me anyway), because I want to power off my computer much more often than suspend it.

[Status Only icon](https://extensions.gnome.org/extension/40/status-only-icon/) removes your username from next to the speech bubble, leaving just the speech bubble. I know my name already so there's no use having it there taking up space!

[Empathy Menu](https://extensions.gnome.org/extension/259/empathy-menu/) You can set your availability for chat with the status menu, but you can't actually start a chat from it. What a pain! This extension adds an option "Chat" to the menu that launches empathy (there are similar ones for [Pidgin](https://extensions.gnome.org/extension/260/pidgin-menu/) and [Gwibber](https://extensions.gnome.org/extension/198/empathy-gwibber-in-usermenu/)). I still think I'd like to be able to click on a contact's name from that menu though, like Unity.

[Notifications Alert](https://extensions.gnome.org/extension/258/notifications-alert-on-user-menu/) this paints the speech bubble on the status menu red when you have a new notification (e.g. IM messages).

### Window list
My biggest gripe is not having a one-click window list. I just want something like the good old gnome-panel. There are a number of extensions providing this functionality. These all work best with Frippery Move Clock extension and the Extend Left extension.  

[Dock](https://extensions.gnome.org/extension/17/dock/) this puts a permanent dock on the left or right side of the screen, the same dock that appears in the overview. You can configure it to autohide or not, and which side of the screen to put it on (not top and bottom though, and doesn't support one per monitor). Quite slick, although not very customisable.

[Window List](https://extensions.gnome.org/extension/25/window-list/) does what it says on the can. Adds window buttons (icon and text) to the top panel. Like the Windows XP task bar.

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-L-gjvxHC5lw/T4efy2_o-FI/AAAAAAAABUY/kB6TjR38sfc/s1600/window_list.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="12" width="320" src="http://1.bp.blogspot.com/-L-gjvxHC5lw/T4efy2_o-FI/AAAAAAAABUY/kB6TjR38sfc/s320/window_list.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Window list</td></tr>
</tbody>

[Window Icon List](https://extensions.gnome.org/extension/70/window-icon-list/) Adds icons for open windows to the top panel, like Windows 7.

[Panel Docklet S](https://extensions.gnome.org/extension/105/panel-docklet/) I've saved the best til last! This is the extension I ended up going with - sleek, infinitely customisable. It lets me create either a panel or docklet (my chose) on any side of the screen I like. I can show one icon per group of icons (text too if I want), or one icon per application, and **best of all** , I can put **one docklet per monitor** , and I'll only get icons for applications on that monitor! I can also add a workspace switcher (depreciating the need for a separate workspace switcher app), add a button to go to the desktop, add my 'favourites' (on the side dock) as icon shortcuts, and much, much more. I **strongly recommend** this. The only downfall is that I find that the panel on the second monitor sometimes shows icons of applications even though they've already been closed, and if I right click on them gnome-shell crashes :(.

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-EaSonIKNG9k/T4eY0bOx8fI/AAAAAAAABTc/iQdLAX_jZMc/s1600/extension_panel_docklet.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="48" src="http://4.bp.blogspot.com/-EaSonIKNG9k/T4eY0bOx8fI/AAAAAAAABTc/iQdLAX_jZMc/s320/extension_panel_docklet.png" width="264"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Panel Docklet S in 'docklet' mode</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-Invamlb_aGc/T4ecou4_ikI/AAAAAAAABUI/Paodoh0Wsow/s1600/extension_panedocklet.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="17" src="http://3.bp.blogspot.com/-Invamlb_aGc/T4ecou4_ikI/AAAAAAAABUI/Paodoh0Wsow/s320/extension_panedocklet.png" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Panel Docklet S in 'panel-docklet' mode over my top panel</td></tr>
</tbody>

### Other

[User Themes](https://extensions.gnome.org/extension/19/user-themes/): this allows you to install custom skins for the GNOME shell and switch between them from `gnome-tweak-tool`.

[Lame Extensions Manager](https://extensions.gnome.org/extension/141/lame-extensions-manager/) while you're playing around with all the shiny extensions on [extensions.gnome.org](https://extensions.gnome.org/), this provides a button in the status bar allowing you to toggle them on and off quickly.\

## Summary

In the end, I managed to fix most my gripes - removed notification icons I don't use, moved the clock to the left, removed the name from the status bar, and these freed up a lot of space in the top panel.

With that free space I dumped a Panel Docklet S there (in the 'docklet panel' mode) which allows me to quickly see what windows I have open on a particular monitor and go to them (as well as letting me switch between workspaces), and changed the title bar to show the full name of the current window rather than the application name.

All in all, that covers most the gripes I started with! The fact that I can make one docklet per monitor soothes the gnome-shell dual-monitor pain, and the docklet really lets me do most things I wanted (workspace and window switching, shortcuts).

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-04-12T20:29:00-07:00">20:29</abbr>](shell-extensions-in-gnome-32fedora-16.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=6342846385485526200&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=6342846385485526200&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=6342846385485526200&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=6342846385485526200&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=6342846385485526200&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=6342846385485526200&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/04/shell-extensions-in-gnome-32fedora-16.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [fedora](../../search/label/fedora.html), [gnome](../../search/label/gnome.html), [gnome-shell](../../search/label/gnome-shell.html)

