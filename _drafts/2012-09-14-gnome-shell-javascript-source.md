---
layout:   post
title:    "GNOME shell: Javascript Source Documentation (extensions development)"
date:     2012-09-14 05:39 +1000
comments: true
categories: ~
tags: [code, developing, gnome-shell, gnome-shell-extension, javascript, tutorial]
authors: [amy]
---
### GNOME shell: Javascript Source Documentation (extensions development)

When you try to write gnome shell extensions, you quickly realise that while there's plenty of documentation for imported libraries like [Clutter](http://developer.gnome.org/clutter/stable/), there is none for the Javascript files that make up gnome-shell's Javascript side (`/usr/share/gnome-shell/js/ui`). This is a quick summary of files in `/usr/share/gnome-shell/js/ui` and `/usr/share/gnome-shell/misc` and what's in them. I compiled the list because it helps me to learn more about the source. Feel free to correct bits (I certainly have some things wrong).

### Important notes/caveats

- This is based off GNOME 3.2/3.4 JS source. When I say 'GNOME 3.4 only' it might mean 'GNOME 3.4+', but I don't have the source for anything later to check.
- This is just a reference list, not full documentation or anything. Use this to get a quick idea of what is in what file, and then _go and read that file_ for further information.
- **I might not be correct!** I mainly did this so that _I_ could learn things, and I don't always get them right ;) In particular, I'm quite confused about DBus and the words "interface", "proxy", "server", "listener" - so I might misuse them.
- I give a list of just the classes in the files, but sometimes there are other functions there instead of classes that may be useful.
- Contributions welcome (perhaps I should put this page on some sort of wiki/versioning system so that other people can easily edit it).

Let me know of mistakes/broken links.

### Quick links:

- UI files `/usr/share/gnome-shell/js/ui`, `imports.ui`.
- miscellaneous files `/usr/share/gnome-shell/js/misc`, `imports.misc`.

(If you're interested: I use [Markdown](http://daringfireball.net/projects/markdown/) to write blog posts and used the following command to generate the list of classes in each file for me to write explanations into. It missed some things like classes generated from DBus interface specifications but got all the other classes:

    cd /usr/share/gnome-shell/js/ui
    for f in *.js
    do
        echo "### <a name='${f/.js/}'>"'`'$f'`'"</a>"
        # GNOME 3.2:
        # grep -oP '^([A-Za-z_0-9]+)(?=\.prototype)' $f | sed -r -e "s@(.+)@* <a name='${f/.js/}.\1'>"'`\1`'"</a>:@"
        # GNOME 3.4:
        grep -oP '([A-Za-z_0-9]+)(?= *= *new *Lang.Class)' $f | sed -r -e "s@(.+)@* <a name='${f/.js/}.\1'>"'`\1`'"</a>:@"
    done

)

# UI files in `/usr/share/gnome-shell/js/ui` (`imports.ui`)

- `altTab.js`: the popup that appears when you press `Alt+Tab`.
- `appDisplay.js`: to do with the applications tab in the overview - searching for apps and displaying their icons.
- `appFavorites.js`: manages app favourites in the dash (left hand sidebar in the overview).
- `automountManager.js`: handles the automagic detection of external media (USB sticks, ...).
- `autorunManager.js`: handles the popup menu when you mount an external media offering you options to view photos, browse, play music, etc on the media.
- `boxpointer.js`: whenever you open a popup menu there's a little arrow connecting the button to the menu. That's what this is.
- `calendar.js`: stuff to do with the calendar in the clock dropdown menu.
- `checkBox.js` ( **GNOME 3.4 only** ): A checkbox (in < GNOME3.4 you just have the PopupMenu.Switch). As far as I can tell there's one in the Keyring Prompt and that's it.
- `contactDisplay.js`: Handles the display and searching of contacts in the Overview.
- `ctrlAltTab.js`: Handles the Accessibility switcher which lets you select UI elements (top panel, dash, ...) so that you can navigate around them with the keyboard (I never knew this existed!). According to [here](https://live.gnome.org/GnomeShell/CheatSheet) it's not yet fully functional.
- `dash.js`: Handles the dash (left-hand sidebar in the overview showing the application favourites).
- `dateMenu.js`: The graphical calendar widget in the calendar menu (the grid of squares where you click on the date to see events for that date).
- `dnd.js`: Handles drag and drop.
- `docDisplay.js` ( **GNOME 3.2 only** ): gives search results for 'recent items'. GNOME 3.4 doesn't have this.
- `endSessionDialog.js`: the dialog that appears when you log out/shut down/etc.
- `environment.js`: sets up the GJS environment for the rest of the code.
- `extensionSystem.js`: handles installing, enabling, and disabling extensions.
- `flashspot.js` ( **GNOME 3.4 only** ): When you press the printscreen key and get a screenshot, the screen has this white flash (like a camera flash). This is that... (this also happens in GNOME 3.2, but it looks like the screenshot code has changed between 3.2 and 3.4).
- `iconGrid.js`: classes for layout out icons in a grid (e.g. the Overview search results)
- `keyboard.js`: on-screen keyboard class.
- `keyringPrompt.js` ( **GNOME 3.4 only** ): prompt for gnome-keyring.
- `layout.js`: stuff to do with laying out actors on the stage? (panel, message tray, hot corners, ...)
- `lightbox.js`: Creates a dark translucent shade covering a UI element (e.g. when the end session modal dialog causes the rest of the screen to be shaded; this is the shade).
- `link.js`: defines links in the looking glass.
- `lookingGlass.js`: the looking glass (`Alt+F2`, 'r').
- `magnifierDBus.js`: Shell magnifier (for accessibility): the Dbus interface.
- `magnifier.js`: Shell magnifier (for accessibility): the magnifier object itself (see [Magnifier specification](https://live.gnome.org/GnomeShell/Magnification)).
- `main.js`: This is what defines most of the global object instances in GNOME shell and sets everything up - the top panel, overview, .... Also defines a bunch of convenience functions.
- `messageTray.js`: the message tray (bottom of the screen showing notifications).
- `modalDialog.js`: defines the gnome-shell popup dialogs (logout/shutdown, authentication, ...).
- `networkAgent.js`: wrapper around network authentication (listens on dbus for password requests and pops up the authentication dialog).
- `notificationDaemon.js`: listens for notifications via DBus and adds them to the message tray.
- `overview.js`: The overview (press the windows key).
- `panel.js`: Defines the top panel.
- `panelMenu.js`: Defines various helper functions for items in the panel (notably, the system status icon class, being a button in the top panel with a dropdown menu).
- `placeDisplay.js`: Handles searching for Places (Home, Network, mounted volumes, ...) in the overview.
- `polkitAuthenticationAgent.js`: Handles popping up a password dialog on receiving authentication requests (e.g. on updating software).
- `popupMenu.js`: Defines the popup menus and items that can go in them (for example the popup menu from the user menu).
- `remoteSearch.js` **(GNOME 3.4 only)** : Handles remote search providers (search providers that operate through DBus, like Google and Wikipedia where searches go through the internet).
- `runDialog.js`: The run dialog/command prompt when you pres `Alt+F2`.
- `scripting.js`: A scripting module for gnome-shell devs to do performance/unit tests...(?)
- `searchDisplay.js`: Classes for displaying the results of a search in the overview.
- `search.js`: Abstract classes that handle searching and providing results (that are then displayed in the overview by `searchDisplay.js` classes). They are all implemented through other classes (e.g. `appDisplay.js`, `contactDisplay.js`, ...
- `shellDBus.js`: GNOME shell DBus implementation (interface name `org.gnome.shell`, path `/org/gnome/Shell`) - for installing/enabling/disabling/uninstalling extensions and requesting information from them, taking screenshots, and so on.
- `shellEntry.js`: Adds context menus to entry widgets with 'copy' and 'paste' and (if it's a password widget) 'show/hide text'. Examples: in the run dialog and authentication dialog.
- `shellMountOperation.js`: Wrappers around `Shell.MountOperation` that handle the ejecting of a device from the `autorunManager.AutorunResidentNotification`. Provides a dialog letting you know if the device is busy/what processes are inhibiting unmounting and notifications if passwords are needed for the volume.
- `statusIconDispatcher.js`: Diverts some message-tray icons into standard status area icons (for example 'gnome-sound-control-applet' and 'gnome-volume-control-applet' will be removed from the message tray as they are handled by the 'volume' status icon).
- `telepathyClient.js`: handles chat through telepathy and setting up notifications etc for these.
- `tweener.js`: a module that wraps around `imports.tweener.tweener` adding extra goodness for gnome-shell (initialised in `main.js`).
- `userMenu.js`: defines the user menu (with your username, chat status, avatar, ...).
- `viewSelector.js`: The main part of the Overview - defining a notebook/tabs model. For example the 'Applications' and 'Windows' sections of the Overview are 'tabs' within the notebook.
- `wanda.js` **(GNOME 3.4 only)** : Dispenses wisdom from Wanda the GNOME-panel fish from the overview if you type the magic phrase into the search box.
- `windowAttentionHandler.js`: Handles requests for attention from windows (e.g. when you start up and app and it takes a while to start, when the app is done loading you get a '<application> is ready' notification).</application>
- `windowManager.js`: Extra bells and whistles for the window manager implemented on the JS side (mainly window animations).
- `workspace.js`: Classes handling the window previews you see in the 'Windows' tab of the Overview.
- `workspacesView.js`: Essentially the 'Windows' tab in the Overview - handles assembling the window previews (from `workspace.js`) and the workspaces sidebar (`workspaceThumbnail.js`) into one 'tab' for the Overview.
- `workspaceSwitcherPopup.js`: The popup you get upon switching workspaces through the keybindings that shows you which workspace you're switching to.
- `workspaceThumbnail.js`: Defines the classes in the workspaces sidebar in the 'Windows' tab of the Overview - the little snapshots of each workspace allowing you to drag windows between them.
- `xdndHandler.js`: GNOME-shell handling of [Xdnd](http://en.wikipedia.org/wiki/X_Window_selection): dragging and dropping things between an X window and a gnome-shell object. E.g. if you try to drag a file from Nautilus over the Overview button, `panel.js` uses `xdndHandler` to detect this and trigger the overview.
- `status` directory: this contains the files for all the standard status indicators in the status area.
  - `accessibility.js`: the accessibility (a11y) indicator.
  - `bluetooth.js`: the bluetooth indicator.
  - `keyboard.js`: keyboard layout indicator (letting you switch between layouts).
  - `network.js`: the network (wifi/wired) indicator.
  - `power.js`: the power (battery life/power settings) indicator.
  - `volume.js`: the volume/sound settings indicator.

* * *

## Overview of classes in each file.

### `altTab.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-6soMhxap6PE/UFK8KnmDhVI/AAAAAAAABcA/0R9tCRzgaxw/s1600/altTabPopup.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="229" src="http://2.bp.blogspot.com/-6soMhxap6PE/UFK8KnmDhVI/AAAAAAAABcA/0R9tCRzgaxw/s400/altTabPopup.png" alt="altTabPopup" title="altTabPopup" width="400"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The <code>AltTabPopup</code>. <code>SwitcherList</code>s are outlined yellow and <code>AppIcon</code>s are outlined green. The <code>AppSwitcher</code> is the top one and the <code>ThumbnailList</code> is the bottom one (both <code>SwitcherList</code>s).</td></tr>
</tbody>

- `AltTabPopup`: the popup that shows all the window previous when you press `Alt+Tab`
- `AppIcon`: class defining the icon for an app (used in the alt tab popup)
- `SwitcherList`: Helper function defining a list of items to switch between when alt-tab is pressed (used for switching between apps and between windows of a particular app in the AltTab popup).
- `AppSwitcher`: This handles the display of icons for each app in the AltTab popup. Generates an `AppIcon` per app.
- `ThumbnailList`: This is what appears when you hover over an app with multiple windows in the AltTab popup (and it shows you a bunch of window thumbnails). It handles the list of thumbnails for a given app.

### `appDisplay.js`

<tbody>
<tr>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-8s3m34ObOAE/UFLABYZZLkI/AAAAAAAABcc/kjZdbCkxEyg/s1600/appDisplay.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="240" src="http://3.bp.blogspot.com/-8s3m34ObOAE/UFLABYZZLkI/AAAAAAAABcc/kjZdbCkxEyg/s320/appDisplay.png" alt="appDisplay" title="appDisplay" width="320"></a></td>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-zoHulCt54i4/UFLACBeiPzI/AAAAAAAABco/T5mRjJc3PVg/s1600/AppWellIcon.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="160" src="http://3.bp.blogspot.com/-zoHulCt54i4/UFLACBeiPzI/AAAAAAAABco/T5mRjJc3PVg/s320/AppWellIcon.png" alt="AppWellIcon" title="AppWellIcon" width="320"></a></td>
</tr>
<tr>
<td class="tr-caption" style="text-align: center;">
<code>AlphabeticalView</code> is the grid displaying the apps. <code>ViewByCategory</code> handles the categories filter on the side. </td>
<td class="tr-caption" style="text-align: center;">
<code>AppWellIcon</code> consisting of an <code>AppIcon</code> with an <code>AppIconMenu</code>
</td>
</tr>
</tbody>

- `AlphabeticalView`: Based off IconGrid.IconGrid - a grid of application icons (AppWellIcon) that displays its results alphabetically (the grid of app entries the Applications tab).
- `ViewByCategories`: Handles the showing of applications by category (see the Applications tab).
- `AllAppDisplay`: Handles showing every app in all categories.
- `AppSearchProvider`: Handles finding apps matching search term(s).
- `SettingsSearchProvider`: Handles finding entries in the gnome control centre matching search term(s). (The 'SETTINGS' set of results when you do a search - searches through subcategories of 'System Settings').
- `AppIcon`: An icon for an app (there's a similar class AltTab.AppIcon).
- `AppWellIcon`: Extends AppIcon. One per app - the icon + label (giving the app name) + drag and drop support + right-click menu ("New Window", etc) that appears in the applications tab/application search results.
- `AppIconMenu`: The right-click menu of an AppWellIcon containing the relevant actions (New Window, Remove from Favorites, Add to Favorites, ...)

### `appFavorites.js`

- `AppFavorites`: handles your list of app favourites - updates the list when you choose 'add to favourite', provides API for you to add/remove from your favourites.

### `automountManager.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-EfqSwjMMnbw/UFLBpYzOn3I/AAAAAAAABc0/FVt1QIp3X94/s1600/autorunResidentNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="88" src="http://4.bp.blogspot.com/-EfqSwjMMnbw/UFLBpYzOn3I/AAAAAAAABc0/FVt1QIp3X94/s320/autorunResidentNotification.png" alt="autorunResidentNotification" title="autorunResidentNotification" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;"><code>AutorunResidentNotification</code></td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-rhvcfAd8BnI/UFLBpgzQi9I/AAAAAAAABdA/dR0M- __4ZaQ/s1600/autorunTransientNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="80" src="http://3.bp.blogspot.com/-rhvcfAd8BnI/UFLBpgzQi9I/AAAAAAAABdA/dR0M-__ 4ZaQ/s320/autorunTransientNotification.png" alt="autorunTransientNotification" title="autorunTransientNotification" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;"><code>AutorunTransientNotification</code></td></tr>
</tbody>

- `ConsoleKitManager`: Connection to ConsoleKit DBus
- `AutomountManager`: Uses ConsoleKitManager to listen for drives being added, removed, connected, disconnected, ejected, etc and automounts the drive.

### `autorunManager.js`

- `HotplugSniffer`: Listens on the dbus for something...
- `ContentTypeDiscoverer`: Guesses what content is on a media (filesystem? photos? ...), uses HotplugSniffer to discover this.
- `AutorunManager`: Master class that handles monitoring when volumes are mounted/dismounted, uses the other classes in the file to determine what content is on the media and send a notification with the right options for that media on it (if it's a camera card offer to view photos, if it's music offer to play it, ...)
- `AutorunResidentSource`: Inherits from MessageTray.Source: handles the notification side of things. A resident source is one that stays in the messageTray permanently (i.e. the 'Removable Devices' item in the message tray when you have a removable device plugged in).
- `AutorunResidentNotification`: Inherits from MessageTray.Notification: handles the creation of the 'removable devices' notification showing a menu of removable devices with an eject button for each..
- `AutorunTransientDispatcher`: Determines a mounted volume's autorun settings for its transient notification.
- `AutorunTransientSource`: Inherits from MessageTray.Source: the notification source for the autorun notification that you get upon plugging in a device. It can be dismissed (unlike the `AutorunResidentSource`, which only dismisses when all the devices have been ejected).
- `AutorunTransientNotification`: Inherits from MessageTray.Notification: handles the creation of the transient notification you get upon plugging in a device. This is the notification that says 'View photos with Shotwell', 'Play music', 'Browse Files', etc.

### `boxpointer.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-Cijy8Xwlx14/UFLBqKyPfGI/AAAAAAAABdM/DCkcoMg1JpU/s1600/BoxPointer.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="168" src="http://4.bp.blogspot.com/-Cijy8Xwlx14/UFLBqKyPfGI/AAAAAAAABdM/DCkcoMg1JpU/s320/BoxPointer.png" alt="BoxPointer" title="BoxPointer" width="151"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>BoxPointer</code> is the triangular bit.</td></tr>
</tbody>

- `BoxPointer`: The triangle arrow connecting a popupmenu to its source (you can configure what side of the menu the pointer appears).

### `calendar.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-qbsGqXv_zVc/UFLDPOEW7YI/AAAAAAAABds/3bDae29z1dY/s1600/calendar.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="194" src="http://3.bp.blogspot.com/-qbsGqXv_zVc/UFLDPOEW7YI/AAAAAAAABds/3bDae29z1dY/s320/calendar.png" alt="calendar" title="calendar" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The date menu. In red: <code>Calendar.Calendar</code>. Blue: <code>Calendar.EventsList</code>. The entire button and popup are <code>DateMenu.DateMenuButton</code>.</td></tr>
</tbody>

- There are a whole bunch of functions in here to do with changing between date formats, getting day-of-the-week abbreviations, etc.
- `CalendarEvent`: an event in the calendar.
- `EmptyEventSource`: "Interface for appointments/events".
- `CalendarServer`: sets up a Dbus server for the calendar.
- `DBusEventSource`: A calendar event on the dbus. Interacts with CalendarServer.
- `Calendar`: main Calendar class, handles the UI part for the calendar (month navigation, date, graphical calendar) as well as monitoring events.
- `EventsList`: List of events. The UI part to the right of the calendar with the list of upcoming events.

See also `dateMenu.js` which ties all these elements together.

### `checkBox.js` (GNOME 3.4 only)

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-wJun4gQlcsg/UFLF9JM5dgI/AAAAAAAABeA/leQ_tCmuroE/s1600/checkBox.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-wJun4gQlcsg/UFLF9JM5dgI/AAAAAAAABeA/leQ_tCmuroE/s1600/checkBox.png" alt="checkBox" title="checkBox"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">A <code>CheckBox</code>. They only appear on a <code>KeyringDialog</code> (I created this one from the looking glass).</td></tr>
</tbody>

- `CheckBoxContainer`: checkbox container class (helper class), with a checkbox and label.
- `CheckBox`: checkbox itself. If you want a checkbox, use this, not the container class.

### `contactDisplay.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-exZCDcDPQr8/UFLBqTse-2I/AAAAAAAABdY/M8-XEKgFqxE/s1600/Contact.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="117" src="http://4.bp.blogspot.com/-exZCDcDPQr8/UFLBqTse-2I/AAAAAAAABdY/M8-XEKgFqxE/s200/Contact.png" alt="Contact" title="Contact" width="200"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">A <code>Contact</code>.</td></tr>
</tbody>

- `Contact`: A class representing a contact (wrapper around the [Folks](https://live.gnome.org/Folks) library) and also a UI element being what is displayed in the Overview when you search for contacts.
- `ContactSearchProvider`: Handles searching for contacts matching specified search term(s).

### `ctrlAltTab.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-i4bElF37BOk/UFLBquyborI/AAAAAAAABdk/rX8qHvCG7vM/s1600/ctrlAltTabPopup.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="176" src="http://2.bp.blogspot.com/-i4bElF37BOk/UFLBquyborI/AAAAAAAABdk/rX8qHvCG7vM/s320/ctrlAltTabPopup.png" alt="ctrlAltTabPopup" title="ctrlAltTabPopup" width="175"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>CtrlAltTabPopup</code> (with a one-child <code>CtrlAltTabSwitcher</code>).</td></tr>
</tbody>

- `CtrlAltTabManager`: handles control alt tab behaviour - showing the popup, setting up the stage to be ready for keyboard navigation, ..
- `CtrlAltTabPopup`: control alt tab popup itself (UI)
- `CtrlAltTabSwitcher`: inherits from AltTab.SwitcherList: UI element holding all the options you can alt-tab between.

### `dash.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-lgTLP0edjT0/UFLHE5-z8nI/AAAAAAAABeI/0dlVclrd8NE/s1600/dash.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://2.bp.blogspot.com/-lgTLP0edjT0/UFLHE5-z8nI/AAAAAAAABeI/0dlVclrd8NE/s320/dash.png" alt="dash" title="dash" width="50"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>Dash</code>. The <code>RemoveFavouriteIcon</code> is the rubbish bin at the bottom, the <code>DragPlaceholderItem</code> is the line with the white circle at the centre (in the screenshot I am dragging the 'Terminal' icon to put it there).</td></tr>
</tbody>

- `DashItemContainer`: Helper class - each item in the dash is one of these.
- `RemoveFavoriteIcon`: Inherits DashItemContainer. It's the little rubbish bin that appears on the dash when you drag an icon (that lets you remove from your favourite).
- `DragPlaceholderItem`: When you drag your favourites around to re-order them, you see a little bar showing you where the item will be dropped. That's what this is.
- `Dash`: the master Dash class, making use of all the other classes.

### `dateMenu.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-qbsGqXv_zVc/UFLDPOEW7YI/AAAAAAAABds/3bDae29z1dY/s1600/calendar.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="194" src="http://3.bp.blogspot.com/-qbsGqXv_zVc/UFLDPOEW7YI/AAAAAAAABds/3bDae29z1dY/s320/calendar.png" alt="calendar" title="calendar" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The date menu. In red: <code>Calendar.Calendar</code>. Blue: <code>Calendar.EventsList</code>. The entire button and popup are <code>DateMenu.DateMenuButton</code>.</td></tr>
</tbody>

- `DateMenuButton`: Subclasses [`PanelMenu.Button`] to provide the date menu in the middle of the top panel. It's made up of the date/time label in the panel, as well as its PopupMenu containing the `Calendar` and the `EventsList`.

See also: `calendar.js`.

### `dnd.js`

This allows you to add drag-and-drop functionality to your own classes.You use the following functions defined in the file:

- `addDragMonitor`: you define an object defining the drag behaviour you want, and use `addDragMonitor` to add it.A drag monitor is an object with the key `dragMotion` which is a callback for what happens when a drag motion event occurs.Unsure of further details, but see (e.g) `dash.js` and `workspacesView.js` for examples.
- `removeDragMonitor`: remove your drag behaviour that you added with `addDragMonitor`.
- `makeDraggable`: this is what makes an item draggable. You call it on an actor and get a draggable actor back out. You have to define some functions in `actor._delegate`'s class in order for this to work: `handleDragOver`, `acceptDrop`, `getDragActor`, `getDragActorSource`, `handleDragOver`. I don't know the details or if all of these are mandatory, but will write a blog post on this if I ever work it out.

Classes:

- `_Draggable`: Class defining a basic draggable item, defining how the dragging happens (starting it, animating it, what to do if the user cancels, ...). You do not use this directly. Instead, use `makeDraggable` to make an actor draggable.

### `docDisplay.js` (GNOME 3.2 only)

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-QnyOYKjIq4Y/UFLHF2QsekI/AAAAAAAABeM/WbmyMA1ztSA/s1600/docDisplay.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-QnyOYKjIq4Y/UFLHF2QsekI/AAAAAAAABeM/WbmyMA1ztSA/s1600/docDisplay.png" alt="docDisplay" title="docDisplay"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Example of <code>docDisplay</code> results.</td></tr>
</tbody>

- `DocSearchProvider`: Handles finding recent documents matching search term(s).

### `endSessionDialog.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-BVxuegmoubA/UFLHGXOKViI/AAAAAAAABeU/IJZOzzaDVXQ/s1600/endSessionDialogLogoutInhibitor.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="203" src="http://2.bp.blogspot.com/-BVxuegmoubA/UFLHGXOKViI/AAAAAAAABeU/IJZOzzaDVXQ/s320/endSessionDialogLogoutInhibitor.png" alt="endSessionDialogLogoutInhibitor" title="endSessionDialogLogoutInhibitor" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">A <code>EndSessionDialog</code> for logging out, with its <code>ListItem</code> (gedit is impeding logout) outlined in green.</td></tr>
</tbody>

- `ListItem`: A list item in the end session dialog - when it gives a list of applications impeding shutdown, each gets its own ListItem.
- `EndSessionDialog`: The end session dialog. Handles the UI part (presentation of the dialog). In terms of actually logging out/shutting down etc, the dialog simply sends messages to the GNOME SessionManager Dbus to request a shutdown rather than doing the shutdown itself.

### `environment.js`

This module sets up the GJS environment for the rest of the JS files:

- adds up the `global` object (with `global.display`, `global.screen`, ...) to the environment
- adds the `add` function to `St.BoxLayout` and `St.Table` (???)
- adds/improves the `toString()` function (e.g. Clutter.Actors will state their delegate if this is set, e.g.: function MyLabelClass() { this.actor = new Clutter.Text({text: 'asdf'}); this.actor.\_delegate = this; }
- adds the method `String.format` (a bit like `sprintf`; allows us to do (e.g.) `'Hello, %s'.format('world')`).
- initialises various things the shell needs to work.

### `extensionSystem.js`

This is a collection of functions to do with installing, enabling and disabling extensions, and accessing their metadata. (Note - the extension UUID is something like `extensionname@some.website.com`).

In GNOME 3.2 you access particular extensions through the `extensions` and `extensionMeta` objects in `imports.ui.extensionSystem` (these are indexed by extension UUID). In GNOME 3.4, access extensions and their metadata using `imports.misc.extensionUtils.extensions` instead (use `imports.misc.extensionUtils.getCurrentExtension()` from within an extension to get the object for that extension).

There is also an array `enabledExtensions` containing the UUID of enabled extensions. In GNOME 3.4 there's additionally an array 'extensionOrder' giving the order in which extensions were loaded.

Some of the functions:

- `installExtensionFromUUID`: installs an extension by UUID by downloading it from [extensions.gnome.org](https://extensions.gnome.org/).
- `uninstallExtensionFromUUID`: installs an extension by UUID.
- `disableExtension`: disables an extension by UUID.
- `enableExtension`: enables an extension by UUID.

The other functions are to do with the Shell looking for all the extensions you have installed and enabling them.

Just one class provided here:

- `InstallExtensionDialog`: The dialog that pops up when you choose to install an extension (e.g. from [e.g.o](https://extensions.gnome.org/)) confirming that you want to install the extension.

### `flashspot.js` (GNOME 3.4 only)

<tbody>
<tr>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/--pJvxm2M5PM/UFLHHLtRVuI/AAAAAAAABeg/H-08y-Mwmos/s1600/flashspot_1.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/--pJvxm2M5PM/UFLHHLtRVuI/AAAAAAAABeg/H-08y-Mwmos/s1600/flashspot_1.png" alt="flashspot_1" title="flashspot_1" style="border: 1px solid black;"></a></td>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/-qUo138L_FCY/UFLHHxxXuDI/AAAAAAAABek/-30w6ebwwy8/s1600/flashspot_2.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-qUo138L_FCY/UFLHHxxXuDI/AAAAAAAABek/-30w6ebwwy8/s1600/flashspot_2.png" alt="flashspot_2" title="flashspot_2" style="border: 1px solid black;"></a></td>
</tr>
<tr><td class="tr-caption" colspan="2" style="text-align: center;">When I screenshot the 'Activities' button , <code>Flashspot</code> starts to simulate a camera flash. It gets brighter and then fades again.</td></tr>
</tbody>

- `Flashspot`: extends LightBox. That white flash that you get (like a camera flash) when you press the printscreen button (..odd..)...

### `iconGrid.js`

- `BaseIcon`: A basic icon class consisting of an icon and a label.
- `IconGrid`: A widget displaying its children in a grid (allowing you to set a row limit or column limit, and actors that don't fit in will not be painted).

### `keyboard.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-lOuyurMJFno/UFLKoGPRtwI/AAAAAAAABgU/zRQa9uFrfpk/s1600/keyboard.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="240" src="http://4.bp.blogspot.com/-lOuyurMJFno/UFLKoGPRtwI/AAAAAAAABgU/zRQa9uFrfpk/s320/keyboard.png" alt="keyboard" title="keyboard" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>Keyboard</code> with many <code>Key</code>s.</td></tr>
</tbody>
  
  

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-ePJ7rh8PN7c/UFLKpRuIeSI/AAAAAAAABgc/A-UbJQnKm34/s1600/keyboardSource.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-ePJ7rh8PN7c/UFLKpRuIeSI/AAAAAAAABgc/A-UbJQnKm34/s1600/keyboardSource.png" alt="keyboardSource" title="keyboardSource"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>KeyboardSource</code> (click on it to bring up the keyboard)</td></tr>
</tbody>

- `Key`: A key on the keyboard.
- `Keyboard`: The Keyboard class (implements DBus class `/org/gnome/Caribou/Keyboard`?)
- `KeyboardSource`: Inherits from MessageTray.Source, shows the keyboard in the message tray.

### `keyringPrompt.js`:

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-3WXME6gR6do/UFLKqA4HixI/AAAAAAAABgk/OmWryEaSnbY/s1600/keyringDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="190" src="http://3.bp.blogspot.com/-3WXME6gR6do/UFLKqA4HixI/AAAAAAAABgk/OmWryEaSnbY/s320/keyringDialog.png" alt="keyringDialog" title="keyringDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">KeyringDialog</td></tr>
</tbody>

- `KeyringDialog`: a `ModalDialog` that is a dialog for gnome-keyring.

### `layout.js`

- `LayoutManager`: Manages layout of items on the stage (message tray, top panel, hot corners) and updates these when monitors change. I _think_ you might have to call `LayoutManager.addChrome(actor)` if you want to add an actor to the stage and want it to be able to receive events.
- `HotCorner`: Hot corners (e.g. the top-left hot corner lets you switch to the overview).
- `Chrome`: The UI that's visible in the non-overview mode that surrounds all the windows (panel, message tray, ..)

### `lightbox.js`

- `Lightbox`: A shade obscuring the specified container actor (for example the screen in the case of a modal dialog). The `Flashspot` subclasses this to do a white flash instead of a dark shade.

### `link.js`

- `Link`: Defines a Link (only used in the looking glass) - creates a St.Button with a link markup style (underline, ...). The `LookingGlass.ObjLink` is an example of this.

### `lookingGlass.js`

<tbody>
<tr>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/-_v_Qlog4_ys/UFLKZeV-mpI/AAAAAAAABe8/Df4vfXmqDjY/s1600/LookinGlassAutocomplete.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="253" src="http://4.bp.blogspot.com/-_v_Qlog4_ys/UFLKZeV-mpI/AAAAAAAABe8/Df4vfXmqDjY/s320/LookinGlassAutocomplete.png" alt="LookinGlassAutocomplete" title="LookinGlassAutocomplete" width="320"></a></td>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-EN6dAn2XiPE/UFLKcAJNqnI/AAAAAAAABfM/wHpCGCeksIs/s1600/LookingGlassObjInspector.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="237" src="http://3.bp.blogspot.com/-EN6dAn2XiPE/UFLKcAJNqnI/AAAAAAAABfM/wHpCGCeksIs/s320/LookingGlassObjInspector.png" alt="LookingGlassObjInspector" title="LookingGlassObjInspector" width="320"></a></td>
</tr>
<tr>
<td class="tr-caption" style="text-align: center;">Autocomplete function in the looking glass (GNOME 3.4+).</td>
<td class="tr-caption" style="text-align: center;">LookingGlass <code>ObjInspector</code> - inspecting <code>Meta.KeyBindingAction</code>
</td>
</tr>
</tbody>

<tbody>
<tr>
<td style="text-align: center;"><a href="http://2.bp.blogspot.com/-eQQ5TruNTt0/UFLKa32PeXI/AAAAAAAABfE/gU8kzN7WZcg/s1600/LookingGlassInspector.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="142" src="http://2.bp.blogspot.com/-eQQ5TruNTt0/UFLKa32PeXI/AAAAAAAABfE/gU8kzN7WZcg/s320/LookingGlassInspector.png" alt="LookingGlassInspector" title="LookingGlassInspector" width="320"></a></td>
<td class="tr-caption" style="text-align: center;">Looking Glass <code>Inspector</code> - outlines the actor your mouse is over and lets you pick it.</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://2.bp.blogspot.com/-V9J2go0aVfA/UFLKdRwiU5I/AAAAAAAABfU/D8YyzKORCjU/s1600/LookingGlassResultObjLink.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-V9J2go0aVfA/UFLKdRwiU5I/AAAAAAAABfU/D8YyzKORCjU/s1600/LookingGlassResultObjLink.png" alt="LookingGlassResultObjLink" title="LookingGlassResultObjLink"></a></td>
<td class="tr-caption" style="text-align: center;">Looking Glass <code>ObjLink</code> - clicking on it launches the <code>ObjInspector</code>.</td>
</tr>
</tbody>

- `AutoComplete` ( **GNOME 3.4 only** ): Adds completion behaviour on Tab/double-Tab to the looking glass!! (Like the Terminal).
- `Notebook`: The Looking Glass consists of multiple 'tabs' (Evaluator; Windows; Errors; Memory; Extensions); the notebook is what holds them all. Defines the tab controls, ability to add/switch tab pages, and an area where the page content will appear.
- `ObjLink`: inherits from Link.Link - when you type things into the Looking Glass console the results are clickable. This class handles those links.
- 

`Result`: When you type things into the Looking Glass the results get printed like so:

    r(result_number) = result

That is what this class is (where `result` is an ObjLink`).

- `WindowList`: The Windows tab of the Looking Glass.
- `ObjInspector`: When you click on a result in the Looking Glass you get a window that shows you more information about that result. For example, clicking on an object will show (some of) its properties. This is that class.
- `Inspector`: There's a 'picker' icon in the Evaluator tab of the Looking Glass. When you select it, you can 'pick' an object from the stage to examine further. As you move your pointer over particular objects, they get a red border drawn around them. The `Inspector` class handles adding and removing these borders, and tracking which object your pointer is over (the actual function to add the borders is called `addBorderPaintHook`).
- `ErrorLog`: The 'Errors' tab in the Looking Glass.
- `Memory`: The 'Memory' tab in the Looking Glass.
- `Extensions`: The 'Extensions' tab in the looking glass.
- `LookingGlass`: Assembles the whole looking glass together. Also provides the 'Evaluator' tab and handles the actual evaluation of commands typed into the console.

### `magnifierDBus.js`

- `ShellMagnifier`: DBus proxy (proxy? server?) representing the Shell Magnifier (`org.gnome.Magnifier`).
- `ShellMagnifierZoomRegion`: DBus proxy (??server?? I don't know about DBus) representing a zoom region (region being magnified).

### `magnifier.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-n-zVpO8tSkc/UFLKq6WFQXI/AAAAAAAABgs/XOyNoLSCuvg/s1600/magnifier.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="217" src="http://1.bp.blogspot.com/-n-zVpO8tSkc/UFLKq6WFQXI/AAAAAAAABgs/XOyNoLSCuvg/s320/magnifier.png" alt="magnifier" title="magnifier" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>Magnifier</code>. The <code>ZoomRegion</code> is the little region of the screen being displayed/zoomed, and the <code>Crosshairs</code> are in red.</td></tr>
</tbody>

- `Magnifier`: Defines the shell magnifier.
- `ZoomRegion`: Defines a particular zoom region.
- `Crosshairs`: Defines the crosshairs of the magnifier.

### `main.js`

No classes in here. This file is like the `int main();` of programs, setting up the whole gnome-shell interface and making parts available to everyone else (the top panel, overview, ...). Many global objects in gnome-shell create just one instance. These are stored here.

This file also handles dynamic workspaces (when you have no windows left on a workspace it is removed).

Some of the objects stored to be accessed by others (there are more, see `main.js`):

- `panel`: this is the top panel. If you want to add buttons to the status area etc, you use this panel to add them to.
- `hotCorners`: the hot corner(s), e.g. the top-left one (move your cursor over it and the Overview opens).
- `overview`: the Overview.
- `runDialog`: the dialog when you press `Alt+F2`.
- `lookingGlass`: the looking glass.
- `messageTray`: the message tray.
- `recorder`: gnome-shell recorder (when you record a screencast).
- `shellDBusService`: Gnome-shell's Dbus service.
- `magnifier`: the accessibility magnifier.
- `keyboard`: the accessibility on-screen keyboard.

Some handy functions (there are other functions in `main.js` too; these are just some handy one):

- `getThemeStylesheet()`: gets the file path for the (custom) theme you are using for gnome-shell, if any (e.g. `$HOME/.themes/<themename>/gnome-shell/gnome-shell.css`). If you are not using a custom gnome-shell theme, this will be null.
- `setThemeStylesheet(path)`: sets the file path for the custom theme for gnome-shell (but doesn't actually cause a theme change; use `loadTheme` to reload the theme after doing this).
- `loadTheme()`: reloads the style for gnome-shell. It sets the `getThemeStylesheet` (any custom gnome-shell theme if you have one, or just the default `/usr/share/gnome-shell/themes/gnome-shell.css`) as the top priority style sheet, and then loads all the extra stylesheets (e.g. extension stylesheets) at a lower priority. This is why if you set a style in your extension's `stylesheet.css` that conflicts with the a gnome-shell style class, gnome-shell will win.
- `notify(msg, details)`: creates a gnome-shell notification (i.e. popup from the message tray) with title `msg` and text `details`.
- `notifyError(msg, details)`: calls `notify(msg, details)` to send a popup notification from the message tray, and additionally logs the message/details using `log` (if you are running `gnome-shell` from a terminal, the message will appear there).
- `_log(category, msg)`: logs a message to the Looking Glass errors tab, where `category` is 'info', 'error', or 'debug'. You will probably want to use `global.log(message)` instead of this (which logs with category 'debug').
- `_logError(msg)`: calls `_log` with category 'error'. Aliased as `global.logError`.
- `_logDebug(msg)`: calls `_log` with category 'debug'. Aliased as `global.log`.
- `pushModal(actor, timestamp, options)`: Grabs all keyboard/mouse input to the stage and focuses `actor`. When the modal stack is empty we return focus to whatever had focus before `pushModal` was called. The overview, run dialog, looking glass, alt-tab switchers, and modal dialogs all use this (there are probably more too).
- `popModal(actor, timestamp)`: Opposite of `pushModal` (removes `actor` from the modal stack).
- `initializeDeferredWork(actor, callback, props)`: Sets up a callback to be invoked either when `actor` is mapped, or when the machine is idle - useful if your actor isn't always visible on the screen and you don't want to consume resources updating if the actor isn't actually visible. (The Overview actors are all examples of these). Returns a work ID that you can use with `queueDeferredWork` every time you update the actor.
- `queueDeferredWork(workId)`: Ensures that the work identified by `workId` will be run on map or timeout. It is called by default on `initializeDeferredWork`, call it again when (say) the data being displayed by the actor changes.

A few of convenience functions (again, this is not all of them)`:

- `getWindowActorsForWorkspace(workspaceIndex)`: gets a list of window actors for windows displayed on workspace `workspaceIndex` (this includes windows that are set as 'on all workspaces'). (Just a convenience wrapper around `global.get_window_actors()` with filtering for windows on the specified workspace and checking for windows on all workspaces).
- `activateWindow(window, time, workspaceNum)`: activates the Meta.Window `window`, switching to its workspace first if necessary, and switching out of the overview if active (just a convenience wrapper around `Meta.Window.activate(time)` with workspace/overview checking).

### `messageTray.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-dxN0qi6AmqQ/UFLKe9r65WI/AAAAAAAABfY/AU6fn4z-C6g/s1600/MessageTray.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="77" src="http://4.bp.blogspot.com/-dxN0qi6AmqQ/UFLKe9r65WI/AAAAAAAABfY/AU6fn4z-C6g/s320/MessageTray.png" alt="MessageTray" title="MessageTray" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The <code>messageTray</code>, showing three <code>SummaryItem</code>s (which each have their own underlying <code>Source</code>) and one <code>Notification</code>.</td></tr>
</tbody>

<tbody>
<tr>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/-MjAhMc74xNg/UFLKsEtX-QI/AAAAAAAABgw/fDSA8cOykTk/s1600/messageTraySummaryItemYellowSourceRed.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-MjAhMc74xNg/UFLKsEtX-QI/AAAAAAAABgw/fDSA8cOykTk/s1600/messageTraySummaryItemYellowSourceRed.png" alt="messageTraySummaryItemYellowSourceRed" title="messageTraySummaryItemYellowSourceRed"></a></td>
<td class="tr-caption" style="text-align: center;">The <code>SummaryItem</code> is outlined in yellow and its associated <code>Source</code> provides the icon and counter (outlined in red).</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/-irUuo8uuf6s/UFLKfQZPRmI/AAAAAAAABfg/X8XLw __xJQ0/s1600/MessageTrayNotificationTransient.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="44" src="http://4.bp.blogspot.com/-irUuo8uuf6s/UFLKfQZPRmI/AAAAAAAABfg/X8XLw__ xJQ0/s320/MessageTrayNotificationTransient.png" alt="MessageTrayNotificationTransient" title="MessageTrayNotificationTransient" width="320"></a></td>
<td class="tr-caption" style="text-align: center;">A <code>Notification</code> in "banner mode" (pops up from bottom of the screen), also demonstrating the <code>UrlHighlighter</code>.</td>
</tr>
</tbody>

- `URLHighlighter`: class to markup URLs in notifications.
- `FocusGrabber`: grabs focus to a notification.
- **`Source`** : abstract class defining a notifications source. It provides the UI element of the icon + notification counter in the message tray. Implementations must provide the method `createNotificationIcon` to create the icon. When you wish to create a notification, you notify _from_ a source (e.g. a source (Thunderbird) can provide many notifications (about new emails)).
- **`Notification`** : base class defining a notification - the UI element. A notification belongs to a `Source` and has a title and text. In banner mode, the notification shows an icon, title, and banner on a single line. If the notification has additional elements in it or the banner doesn't fit on a single line, the notification is expandable. See `messageTray.js` for much more in-depth documentation. Also, if the notification is transient, it will pop up from the button of your screen. If the notification is resident, its `Source`/`SummaryItem` will stay in the message tray and clicking on that will bring up the `Notification`.
- `SummaryItem`: This is the UI element that sits in the message tray, one per source. It display's the source's summary icon (being the `source.createNotificationIcon()` plus a counter of the number of notifications) and also displays the title of the source upon mouseover and defines the right-click menu (with Open/Remove) when you right-click a summary item in the message tray. Think of a notification source as being composed of a `Source` (being tied to the application and handling its notifications) and a `SummaryItem` handling all the UI/message tray part. Then only UI task that the `Source` has to do is provide an icon for the notification.
- `MessageTray`: the MessageTray class.
- `SystemNotificationSource`: Example of a Source - for system notifications.

Recap - if you wish to create notifications, the `MessageTray.Source` is the class you subclass. You need to implement the `createNotificationIcon` function at a minimum. When you want to send a _notification_ from that source, use `source.notify(notification)`, where `notification` is a `MessageTray.Notification` (or subclass thereof).

### `modalDialog.js`

- `ModalDialog`: a handy class defining a modal (popup) dialog. Use `.setButtons` to add buttons to it, and `open` and `close` to show or hide it. Examples: end session dialog, install extensions confirmation dialog, wifi network password entry dialog...

### `networkAgent.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/--Jyk8gBtGPc/UFLKgCO1bXI/AAAAAAAABfs/WJrVuON8fO0/s1600/NetworkSecretDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="154" src="http://4.bp.blogspot.com/--Jyk8gBtGPc/UFLKgCO1bXI/AAAAAAAABfs/WJrVuON8fO0/s320/NetworkSecretDialog.png" alt="NetworkSecretDialog" title="NetworkSecretDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>NetworkSecretDialog</code>.</td></tr>
</tbody>

- `NetworkSecretDialog`: dialog that pops up getting you to entire in your password for wifi.
- `NetworkAgent`: listens to NetworkAgent on Dbus - handles authentication requests.
- `VPNRequestHandler` ( **GNOME 3.4 only** ): handles authentication requests for VPN.

### `notificationDaemon.js`

- `Bus`: Listens to `org.freedesktop.DBus`, interface 'org.freedesktop.Notifications'.
- `NotificationDaemon`: gnome-shell uses dbus to listen/send notifications; this handles that.
- `Source`: extends MessageTray.Source - a message tray source for notifications that arrive over DBus path 'org.freedesktop.Bus'. The icon is usually the icon of the application causing the notification.

### `overview.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-Gl3tsp2xr3Q/UFLKhyIpoVI/AAAAAAAABf0/jZfr-chn1b0/s1600/Overview.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="240" src="http://4.bp.blogspot.com/-Gl3tsp2xr3Q/UFLKhyIpoVI/AAAAAAAABf0/jZfr-chn1b0/s320/Overview.png" alt="Overview" title="Overview" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>Overview</code>.</td></tr>
</tbody>

- `ShellInfo`: Handles spawning notifications for actions performed from the overview and undoing them (only examples I could find were adding/removing favourites from the dash in `appDisplay.js` and adding/removing places in `placeDisplay.js`.
- `Overview`: The Overview (triggered when you press the windows key). Made up of various tabs defined in other classes. Code in here is to do with animation when the overview shows and hides, loading search providers, interaction with the overview (typing, dragging, clicking) and so on.

See also `viewSelector.js` for the classes defining the 'notebook/tab' classes, and `*Display.js` files for files defining various tabs (e.g. the core 'Applications' tab code is in `appDisplay.js`, the code for the 'Windows' tab is in `workspacesView.WorkspacesDisplay`.

### `panel.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-7_cwAEwuYSU/UFLKxSCMMWI/AAAAAAAABhs/9lNGzOnR0Lw/s1600/panelMenu.boxes.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="14" src="http://4.bp.blogspot.com/-7_cwAEwuYSU/UFLKxSCMMWI/AAAAAAAABhs/9lNGzOnR0Lw/s320/panelMenu.boxes.png" alt="panelMenu boxes" title="panelMenu boxes" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Panel <code>_leftBox</code> (red), <code>_centerBox</code> (green), <code>_rightBox</code> (blue).</td></tr>
</tbody>

<tbody>
<tr>
<td style="text-align: center;"><a href="http://4.bp.blogspot.com/-Zyde-vmkRJc/UFLKsz6asoI/AAAAAAAABg4/LWxkvfRlymU/s1600/panelCorner.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-Zyde-vmkRJc/UFLKsz6asoI/AAAAAAAABg4/LWxkvfRlymU/s1600/panelCorner.png" alt="panelCorner" title="panelCorner"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
<code>PanelCorner</code>.</div>
</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-o8pG-IKLydA/UFLKtpQU4SI/AAAAAAAABhE/l2RURjlOCpo/s1600/panelMenu.ActivitiesButton.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-o8pG-IKLydA/UFLKtpQU4SI/AAAAAAAABhE/l2RURjlOCpo/s1600/panelMenu.ActivitiesButton.png" alt="panelMenu ActivitiesButton" title="panelMenu ActivitiesButton"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
<code>ActivitiesButton</code>.</div>
</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-Ab41_quK2rg/UFLKumuxfNI/AAAAAAAABhI/YVm736qk41E/s1600/panelMenu.AnimatedIcon.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-Ab41_quK2rg/UFLKumuxfNI/AAAAAAAABhI/YVm736qk41E/s1600/panelMenu.AnimatedIcon.png" alt="panelMenu AnimatedIcon" title="panelMenu AnimatedIcon"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
<code>AnimatedIcon</code> (red) in the <code>AppMenu</code>. The text shadowed effect is achieved using a <code>TextShadower</code>.</div>
</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://2.bp.blogspot.com/-SwWLuEnMp-I/UFLKwTBXubI/AAAAAAAABho/O5wZkpvTD1w/s1600/panelMenu.appMenu.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-SwWLuEnMp-I/UFLKwTBXubI/AAAAAAAABho/O5wZkpvTD1w/s1600/panelMenu.appMenu.png" alt="panelMenu appMenu" title="panelMenu appMenu"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
<code>AppMenu</code> with its dropdown menu.</div>
</td>
</tr>
</tbody>

- `AnimatedIcon`: handles loading an animated icon whereby the icon's underlying image is a tiled image showing stages of the animation (for example the 'process working' animation - the spinning circle in the titlebar when you start up a program).
- `TextShadower`: A label with simulated text shadowing - it actually consists of one white label and 4 'shadow' labels (black and 40% transparent). All the labels show the same text. The white label is the one you see and the 'shadow' labels sit behind and slightly offset from the white text, creating the effect of a shadow. The text in the titlebar (app title) is an example of this.
- `AppMenuButton`: This is the top titlebar (stored in `Main.panel._appMenu`). It contains a `TextShadower` showing the current app title and `AnimatedIcon` for when apps are starting up. Inherits from `PanelMenu.Button`, so it has a dropdown menu (by default showing 'Quit' (application)).
- `ActivitiesButton`: The 'Activities' button on the top-left that triggers the overview. It's a `PanelMenu.Button` but without a menu. Contains the `Layout.HotCorner` that triggers the overview.
- `PanelCorner`: You know the black rounded corners that extend down from the top panel on either side of the screen (they match the rounded corners of a maximised window)? That's what these are. They are painted onto the screen using the panel colour.
- `Panel`: The top panel, stored in `Main.panel`. It is split into three 'boxes' into which various panel elements are all placed:
  - `_leftBox`: contains the activities button and app menu button
  - `_centerBox`: contains the clock (by default; there are various extensions that move this to the right if you wish).
  - `_rightBox`: contains the status area. However when you want to insert icons into the status area you should use `Main.panel.addToStatusArea(role, myButton, position)`, where `role` is the role that button performs ('network', 'a11y', ...). There can only be one button performing each role in the status area.

Constants that could be interesting:

- `STANDARD_STATUS_AREA_ORDER`: the default order for the default status icons (left to right: accessibility, keyboard, volume, bluetooth, network, battery, user menu). Stored in `Main.overview._status_area_order` and used in `startStatusArea` which lays out all the icons.

### `panelMenu.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-AijxQ1sTQaM/UFLKvkO8ksI/AAAAAAAABhc/SEpRhlG9ugk/s1600/panelMenu.SystemStatusButton.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-AijxQ1sTQaM/UFLKvkO8ksI/AAAAAAAABhc/SEpRhlG9ugk/s1600/panelMenu.SystemStatusButton.png" alt="panelMenu SystemStatusButton" title="panelMenu SystemStatusButton"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Example of a <code>SystemStatusButton</code>, being the indicator and menu where the indicator is an icon. (Custom indicator + menu is a <code>Button</code>, custom indicator (no menu) is a <code>ButtonBox</code>).</td></tr>
</tbody>

- `ButtonBox`: The base button class for buttons in the panel (incorporates the `-minimum-hpadding` and `-natural-hpadding` attributes in the `panel-button` style class - so whatever you insert into the ButtonBox should get padded uniformly with all the other buttons in the panel.
- `Button`: Inherits from `ButtonBox` - adds a menu. So this is an object for use in the panel that will have a menu and some sort of display item (e.g. an icon), which you are responsible for defining and adding. The date menu is an example of this (its display item is a `St.Label` with the current date/time).
- `SystemStatusButton`: This is just a `Button` with an icon. Feed it in an icon name (one of the stock icon names) and it'll display it. Just about every icon you have in your status area is one of these (accessibility indicator, network indicator, ...).

### `placeDisplay.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-9YNZAgetZ68/UFLKyziuaSI/AAAAAAAABh8/vkJSCNMYu8I/s1600/placesDisplay.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-9YNZAgetZ68/UFLKyziuaSI/AAAAAAAABh8/vkJSCNMYu8I/s1600/placesDisplay.png" alt="placesDisplay" title="placesDisplay"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Example result from the <code>PlacesSearchProvider</code>.</td></tr>
</tbody>

- `PlaceInfo`: According to in-file documentation, this represents a place object, which is most likely a bookmark entry, volume/mount, or special place like Home, Computer or Network.
- `PlaceDeviceInfo`: This is a `PlaceInfo` for a mounted volume.
- `PlacesManager`: handles many places (mounted volumes, Home folder, ....). Essentially manages many `placeInfo`s.
- `PlaceSearchProvider`: Finds places matching search term(s) (e.g. the 'PLACES & DEVICES' results section in the Overview).

### `polkitAuthenticationAgent.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-XdytPPySauc/UFLKzyyCQ6I/AAAAAAAABiE/FkSRg1YwvZw/s1600/polkitAuthenticationDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="204" src="http://3.bp.blogspot.com/-XdytPPySauc/UFLKzyyCQ6I/AAAAAAAABiE/FkSRg1YwvZw/s320/polkitAuthenticationDialog.png" alt="polkitAuthenticationDialog" title="polkitAuthenticationDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>AuthenticationDialog</code>.</td></tr>
</tbody>

- `AuthenticationDialog`: The ModalDialog that appears when you have to enter your password to authenticate (e.g. installing software updates).
- `AuthenticationAgent`: Wrapper around Shell.PolkitAuthenticationAgent, listens for authentication requests and shows the AuthenticationDialog.

### `popupMenu.js`

<tbody>
<tr>
<td style="text-align: center;"><a href="http://1.bp.blogspot.com/-Kuwdhucp3rI/UFLKiiMC6aI/AAAAAAAABf8/FVfPVnxF0Kk/s1600/PopupMenu.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="284" src="http://1.bp.blogspot.com/-Kuwdhucp3rI/UFLKiiMC6aI/AAAAAAAABf8/FVfPVnxF0Kk/s320/PopupMenu.png" alt="PopupMenu" title="PopupMenu" width="320"></a></td>
<td style="text-align: center;"><a href="http://2.bp.blogspot.com/-zJeHn6uTk8M/UFLKkbGr1JI/AAAAAAAABgE/rFi_7jyNs1M/s1600/PopupMenuExpanded.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="309" src="http://2.bp.blogspot.com/-zJeHn6uTk8M/UFLKkbGr1JI/AAAAAAAABgE/rFi_7jyNs1M/s320/PopupMenuExpanded.png" alt="PopupMenuExpanded" title="PopupMenuExpanded" width="320"></a></td>
</tr>
<tr><td class="tr-caption" colspan="2" style="text-align: center;">
<code>PopupMenu</code> displaying various items. From top to bottom: <code>PopupMenuItem</code>, <code>PopupSeparator</code>, <code>PopupSliderMenuItem</code>, <code>PopupSwitchMenuItem</code>, <code>PopupSubMenuMenuItem</code>. The remaining items are within the submenu item: <code>PopupSwitchMenuItem</code> (again, with the <code>Switch</code> component outlined), <code>PopupImageMenuItem</code>, and <code>PopupComboBoxMenuItem</code>. You can put any sort of <code>Popup*MenuItem</code> into the combo box; on the right is the combo box open with a <code>PopupMenuItem</code> and <code>PopupImageMenuItem</code> in it.</td></tr>
</tbody>

- `PopupBaseMenuItem`: Base class for popup menu items - an empty popup menu item. Has an 'activate' signal that gets fired when the item is activated. Use `.addActor` to add visual elements to it (like a `St.Label`). **All** the other `Popup*MenuItem` classes inherit from this (and respond to the 'activate' signal).
- `PopupMenuItem`: A `PopupBaseMenuItem` that displays text (in a `St.Label`).
- `PopupSeparatorMenuItem`: A `PopupBaseMenuItem` that is a separator.
- `PopupAlternatingMenuItem`: A `PopupBaseMenuItem` that has two texts - one that shows by default, and one that appears upon pressing `Clutter.ModifierType.MOD1_MASK` (Alt for me). The alternating 'Suspend...'/'Power off' menu item in the user menu is one of these.
- `PopupSliderMenuItem`: A `PopupBaseMenuItem` that is a slider widget. Its value is between 0 and 1 and the item doesn't include a label showing the slider's current value, so that's your job. Example: the volume slider. Use the 'value-changed' signal to detect when the user moves the slider (gets fired with the current value as an argument), and/or the 'drag-end' signal to detect when the user has finished dragging the slider. For example, you could have a label displaying the current value of the slider that gets updated on 'value-changed', and then an action that gets taken when 'drag-end' occurs.
- `Switch`: An on-off toggle switch (_not_ a `PopupBaseMenuItem`; see `PopupSwitchMenuItem` for that).
- `PopupSwitchMenuItem`: A `PopupBaseMenuItem` containing a label/text and a `Switch` to the right. Example: Wifi/wired connection on/off switch in the network menu. Use the 'toggled' signal to determine when the user toggles it.
- `PopupImageMenuItem`: A `PopupBaseMenuItem` containing a label/text and an icon to the right. Example: in the network menu, available wifi networks have the network name and an icon indicating connection strength.
- `PopupSubMenuMenuItem`: A `PopupBaseMenuItem` defining a collapsible submenu - click on it to expand/open the submenu and reveal the items inside. Is really just a `PopupBaseMenuItem` with a label and a `PopupSubMenu`. Use `myItem.menu.addMenuItem` to add to its menu.
- `PopupComboBoxMenuItem`: A `PopupBaseMenuItem` that is a combo box. Example: the chat status combo box (available/offline) in the user menu. Use `myItem.addMenuItem(item)` to add a choice to the combo box, and `myItem.setActiveItem` to set the active item. When a selection is changed, it emits signal `active-item-changed` with the (0-based) index of the activated item.

Menus:

- `PopupMenuBase`: The base class for a popup menu (e.g. the menu that appears when you click most of the items in the status area). You don't use this directly (unless you are extending it); use any of its child classes and use `menu.addMenuItem` to add a popup menu item/submenu to it.
- `PopupMenu`: Extends `PopupMenuBase` to provide a popup menu. This is the main popup menu class (the one that gets used for all the `PanelMenu.Button`s).
- `PopupSubMenu`: A popup submenu - designed to be nested within a `PopupMenu`, has a scrollbar in case the content is too long. If you want to add it to a `PopupMenu` as a collapsible menu section, use `PopupSubMenuMenuItem`.
- `PopupMenuSection`: This acts like a `PopupSubMenu`, but to the user just looks like a normal `PopupMenu`. It can be useful to add multiple `PopupMenuSection`s to a single `PopupMenu` to 'group' items together code-wise (and to the user it looks like a flat popup menu).
- `PopupComboMenu`: Extends `PopupMenuBase`: this is the menu that drops down from a combo box. If you want a combo box, use `PopupComboBoxMenuItem`.
- `RemoteMenu` ( **GNOME 3.4 only** ): "A `PopupMenu` that tracks a `GMenuModel` and shows its actions (exposed by GApplication/GActionGroup). This adds application-specific menu items to a menu (for example in Epiphany the titlebar menu shows 'New Window', 'Bookmarks', etc).

Misc:

- `PopupMenuManager`: "Basic implementation of a menu manager. Call `addMenu` to add menus". I _think_ you use this if you want to manage multiple menus (???). For example, all the status area menus and the date menu appear to have the same manager (`Main.panel._menus`). It also looks like it handles the menus grabbing focus, responding to key events, etc.

### `remoteSearch.js` (GNOME 3.4 only)

- `SearchProviderProxy`: DBus proxy for remote search providers (on 'org.gnome.shell.SearchProvider').
- `RemoteSearchProvider`: Extends Search.SearchProvider - a search provider that acts through dbus (e.g. Google and Wikipedia). Displays its results in the Overview.

Also defines some functions for loading search providers (like Google/Wikipedia): `loadRemoteSearchProviders` and `loadRemoteSearchProvidersFromDir` (for me there are some XML files in `/usr/share/gnome-shell/open-search-providers` for Google/Wikipedia).

### `runDialog.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-FcwldNb7O5I/UFLK1mEIb2I/AAAAAAAABiI/kufHnFOgMUY/s1600/runDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="62" src="http://4.bp.blogspot.com/-FcwldNb7O5I/UFLK1mEIb2I/AAAAAAAABiI/kufHnFOgMUY/s320/runDialog.png" alt="runDialog" title="runDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;"><code>RunDialog</code></td></tr>
</tbody>

- `CommandCompleter`: command completer for the run dialog (that appears when you press `Alt+F2`).
- `RunDialog`: the run dialog that you get on `Alt+F2`. Type commands in here to have them executed. Also defines a couple of 'special' commands:
  - `lg`: opens the Looking Glass, the developer console for gnome-shell.
  - `r`, `restart`: restarts gnome-shell. Needed if you make changes to JS files.
  - `rt`: 'reload theme', reloads the shell theme (if you only make changes to CSS files this will reload them).
  - `debugexit`: quits the shell with debug info (well for me it just quits the shell, but maybe I need debug symbol packages).

### `scripting.js`

Note - all this documentation comes straight from the source, and there is much more in the source.

This module provides functionality for driving the shell user interface in an automated fashion.The primary current use case for this is automated performance testing (see `runPerfScript()`), but it could be applied to other forms of automation, such as testing for correctness as well.

When scripting an automated test we want to make a series of calls in a linear fashion, but we also want to be able to let the main loop run so actions can finish. For this reason we write the script as a generator function that yields when it want to let the main loop run.

    yield Scripting.sleep(1000);
    main.overview.show();
    yield Scripting.waitLeisure();

While it isn't important to the person writing the script, the actual yielded result is a function that the caller uses to provide the callback for resuming the script.

Provides:

- 

`sleep(milliseconds)`: Used within an automation script to pause the the execution of the current script for the specified amount of time. Use as:

    yield Scripting.sleep(500);

- 

`waitLeisure()`: Used within an automation script to pause the the execution of the current script until the shell is completely idle. Use as:

    yield Scripting.waitLeisure();

- `PerfHelper`: DBus proxy for 'org.gnome.shell.PerfHelper'.
- `createTestWindow(width, height, alpha, maximized)`:Creates a window using gnome-shell-perf-helper for testing purposes.While this function can be used with yield in an automation script to pause until the D-Bus call to the helper process returns, because of the normal X asynchronous mapping process, to actually wait until the window has been mapped and exposed, use `waitTestWindows()`.
- `waitTestWindows()`:Used within an automation script to pause until all windows previously created with `createTestWindow` have been mapped and exposed.
- `destroyTestWindows()`:Destroys all windows previously created with `createTestWindow()`.While this function can be used with yield in an automation script to pause until the D-Bus call to the helper process returns, this doesn't guarantee that Mutter has actually finished the destroy process because of normal X asynchronicity.
- `defineScriptEvent(name, description)`:Convenience function to define a zero-argument performance event within the 'script' namespace that is reserved for events defined locally within a performance automation script.
- `scriptEvent(name)`:Convenience function to record a script-local performance event previously defined with `defineScriptEvent`
- `collectStatistics()`: Convenience function to trigger statistics collection.
- `runPerfScript(scriptModule)`: module object with run and finish functions and event handlers.Runs a script for automated collection of performance data. The script is defined as a Javascript module with specified contents. See the `scripting.js` file for much more detail (it's documented in there).

### `searchDisplay.js`

- `SearchResult`: Class representing a single result of a search in the Overview. The UI side is a `St.Button` containing an `IconGrid.BaseIcon`.
- `GridSearchResults`: extends `Search.SearchResultDisplay`, a wrapper around an Icon Grid. This handles the display of search results from multiple providers in the overview.
- `SearchResults`: displays search results that don't get displayed in a grid? The Wikipedia/Google results (but these don't appear in the overview, at least for me - they get opened in a browser)?

### `search.js`

Note - this is a set of abstract classes to be subclassed and particular methods implemented in order to work. The file is very well-documented with the details; not all of them are provided here.

- `SearchResultDisplay`: Abstract class that handles the display of results from a searchProvider. It _must_ be subclassed. In particular, it must implement methods `getVisibleResultCount`, `clear` (clears all results from the display), and `renderResults`. Examples: `GridSearchResults`.
- `SearchProvider`: Abstract class representing a search provider (search engine). _Must_ be subclassed to implement methods `getInitialResultSet` (called when user first begins a search), `getSubsearchResultSet`, `getResultMetas`, `activateResult`, ... (and asynchronous versions). Should also implement `createResultContainerActor` if you wish to override how results get rendered (default is a vertical list) - should return a `SearchResultDisplay`. Examples of implementations: `ContactSearchProvider` (searches contacts), `AppSearchProvider` (searches apps), `PlaceSearchProvider` (searches volumes/places), `RemoteSearchProvider` (searches Wikipedia/Google), `WandaSearchProvider` (finds wanda if you type in the magic incantation!). Most of these just use `GridSearchResults` to render their results.
- `OpenSearchSystem`: An open search system (has multiple providers), loading its providers from `/usr/share/gnome-shell/open-search-providers` (e.g. Google/Wikipedia).
- `SearchSystem`: A search system (searches terms in multiple providers). Add search providers to it through `registerProvider`.

### `shellDBus.js`

- `GnomeShell`: GNOME shell DBus implementation (interface name `org.gnome.shell`, path `/org/gnome/Shell`)

The GNOME-shell DBus interface allows requests for the shell to:

- `Eval`: takes in a string argument of code, executes in the mainloop, and returns a boolean success and JSON representation of the result as a string.
- `ListExtensions`: Return a list of installed extensions, being an object of UUID -> extension info (see next method).
- `GetExtensionInfo`: Returns the information for a particular extension. Input is the extension UUID, output is an 'Extension Info', being an object indexed by property ('type', 'state', 'path', 'error', 'hasPrefs').
- `GetExtensionErrors`: Gets errors thrown by an extension. Input is UUID, output is an array of errors (as strings).
- `EnableExtension`: enables an extension. Input argument is the UUID of the extension.
- `DisableExtension`: disable an extension. Input argument is the UUID.
- `InstallRemoteExtension`: Install an extension remotely (from e.g.o). Input arguments: UUID and version.
- `UninstallExtension`: Uninstall an extension. Input arguments: UUID.
- `LaunchExtensionPrefs` ( **GNOME 3.4 only** ): Launch the extension prefs dialog. Input argument: UUID of which extension to show the preferences widget of.
- `ScreenshotArea`: Takes a screenshot of an area on the screen. Input arguments: position and dimensions of the area to screenshot, whether to flash the screen, and the filename to save as.
- `ScreenshotWindow`: Takes a screenshot of the focused window. Arguments are whether to include the window frame, whether to include the window cursor, whether to flash the screen upon completion, what filename to save.
- `Screenshot`: Takes a screenshot. Input arguments are whether to include the cursor, whether to flash the screen on completion, and the filename to save as.
- `FlashArea` ( **GNOME 3.4 only** ): Flash a particular area. Input arguments are the positon and dimensions of the area.

See the file for further information (it's very well-documented).

Properties on the DBus:

- `OverviewActive`: get/set whether the overview is active.
- `ApiVersion`: returns the extension system's `API_VERSION`.
- `ShellVersion`: returns GNOME-shell's version.

Signals:

- 'ExtensionStatusChanged': whenever an extension's status changes. Gives the extension's UUID, state, and any error.

### `shellEntry.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-3K4DBDUBwco/UFLK2r9MqRI/AAAAAAAABiU/3ydg4QoC3oY/s1600/shellEntry.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="140" src="http://2.bp.blogspot.com/-3K4DBDUBwco/UFLK2r9MqRI/AAAAAAAABiU/3ydg4QoC3oY/s320/shellEntry.png" alt="shellEntry" title="shellEntry" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">The context menu of the run dialog's entry via <code>ShellEntry.addContextMenu</code>.</td></tr>
</tbody>

- `_EntryMenu`: A subclass of `PopupMenu` used to provide a context menu to a `Clutter.Entry` or `St.Entry` (text box). Do not use this class directly; instead use `ShellEntry.addContextMenu(entry)`. The context menu acts like so: when the user long-presses or right-clicks the entry, they get a popup menu with 'paste' and 'copy' (unless it's a context menu for a password dialog!). If it's for a password dialog it'll have a 'show/hide characters' item too.

### `shellMountOperation.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-C9axNhJ7v1w/UFLK33EkVbI/AAAAAAAABig/RhVmm6afj9U/s1600/shellProcessesDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="169" src="http://1.bp.blogspot.com/-C9axNhJ7v1w/UFLK33EkVbI/AAAAAAAABig/RhVmm6afj9U/s320/shellProcessesDialog.png" alt="shellProcessesDialog" title="shellProcessesDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>ShellProcessesDialog</code> containing a <code>ListItem</code> per application that is holding up the volume.</td></tr>
</tbody>

- `ShellMountOperation`: Wrapper around a `Shell.MountOperation`. This is created when the user clicks a device's 'eject' button from the `autorunManager.AutorunResidentNotification`, or mounts a device. It checks if there is anything stopping the device from being ejected (e.g. it's still in use) and shows a `ShellMountQuestionDialog` if appropriate. If passwords are required for the device, it will create a new notification (`ShellMountPasswordSource` and `ShellMountPasswordNotification`).
- `ShellMountQuestionDialog`: Extends `ModalDialog` to provide a dialog that asks a question about a mount and offers choices. UPTO want a pic
- `ShellMountPasswordSource`: Extends `MessageTray.Source`: a source of notifications in the message tray that asks for a password if unmounting requires it. UPTO want a pic
- `ShellMountPasswordNotification`: Extends `MessageTray.Notification` to provide the notification in the message tray that tells you you've entered the wrong password/queries you for a password (i.e. defines the UI elements, being the text, password entry box, ...).
- `ShellProcessesDialog`: Extends `ModalDialog` to provide a dialog that shows you which applications are impeding the removal of a device. I have never actually seen this dialog and am unsure how to make it display (when I try to eject a device that is open in another process I just get 'the device is busy' with a 'Unmount anyway' or 'Cancel' choice, but not the list of processes using it).
- `ListItem`: A button displaying a particular application's icon and name, that will launch the application when clicked. These are used in the `ShellProcessesDialog`, one per application that impedes the removal of a device.

### `statusIconDispatcher.js`

- `StatusIconDispatcher`: Handles re-directoring tray icons for applications to the standard gnome-shell status icons. For example, when `gnome-volume-control-applet` or `gnome-sound-control-applet` launch and add their icons to the message tray, the dispatcher suppresses their icons as they are handled by the 'volume' status icon.

### `telepathyClient.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-vAP7p56Lajo/UFLK-ZQG_tI/AAAAAAAABjY/HZFWcbGqBs0/s1600/telepathyClient.AudioVideoNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="92" src="http://1.bp.blogspot.com/-vAP7p56Lajo/UFLK-ZQG_tI/AAAAAAAABjY/HZFWcbGqBs0/s320/telepathyClient.AudioVideoNotification.png" alt="telepathyClient AudioVideoNotification" title="telepathyClient AudioVideoNotification" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">A <code>AudioVideoNotification</code>.</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-fYqil14Dmz4/UFLK_SF73wI/AAAAAAAABjg/Bmvp_vOZLao/s1600/telepathyClient.Chat.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="178" src="http://3.bp.blogspot.com/-fYqil14Dmz4/UFLK_SF73wI/AAAAAAAABjg/Bmvp_vOZLao/s320/telepathyClient.Chat.png" alt="telepathyClient Chat" title="telepathyClient Chat" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">A <code>ChatNotification</code> (the corresponding <code>ChatSource</code> provides the avatar of the contact from whom the chat originates).</td></tr>
</tbody>

Reminder - a notification 'source' can provide many 'notification's, and a 'source' handles logic whereas the notifications are on the UI side.

- `Client`: A big wrapper around telepathy client. It communicates over DBus to receive and send your messages and display notifications/etc from the message tray.
- `ChatSource`: A `MessageTray.Source` that is tailored for chats. You have one source per contact you're chatting with and you can continue chatting with them from the message tray.
- `ChatNotification`: A `MessageTray.Notification` that pops up a notification whenever you get a new chat and defines the UI elements in the notification allowing you to chat from it.
- `ApproverSource`: A `MessageTray.Source` for approval requests (e.g. being invited into a chat room, accepting a call, file transfers, ..). The icon is relevant to the request - a microphone icon for an audio call, video icon for a video call, ...
- `RoomInviteNotification`: A `MessageTray.Notification` that pops up when you get a room invite (notifies from an `ApproverSource`).
- `AudioVideoNotification`: A `MessageTray.Notification` that pops up when you get a call (notifies from an `ApproverSource`).
- `FileTransferNotification`: A `MessageTray.Notification` that pops up when you get a file transfer request (notifies from an `ApproverSource`).
- `MultiNotificationSource`: A `MessageTray.Source` is "A notification source that can embed multiple notifications". It is used (for example) to display account notifications about failing to connect...
- `SubscriptionRequestNotification`: A `MessageTray.Notification` for subscription requests (e.g. '<alias> would like permission to see when you are online') -- has 'Accept' and 'Decline' options.</alias>
- `AccountNotification`: A `MessageTray.Notification` for account-related notifications - e.g. connection failure. Also has 'Reconnect' or 'Edit account' buttons.

### `tweener.js`

From the source - "This is a wrapper around `imports.tweener.tweener` that adds a bit of Clutter integration and some additional callbacks:

1. If the tweening target is a `Clutter.Actor`, then the tweenings will be automatically removed if the actor is destroyed.
2. If `target._delegate.onAnimationStart()` exists, it will be called when the target starts being animated.
3. If `target._delegate.onAnimationComplete()` exists, it will be called once the target is no longer being animated.

More documentation/explanation in the file, which contains functions and a class `ClutterFrameTicker` to make the magic happen (`main.js` calls `init()` in the file to get it all working).

### `userMenu.js`

<tbody>
<tr>
<td style="text-align: center;"><a href="http://2.bp.blogspot.com/-zyCuEsHQJtY/UFLLAWXbP6I/AAAAAAAABjo/0uj0ji9ncVA/s1600/userMenu.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://2.bp.blogspot.com/-zyCuEsHQJtY/UFLLAWXbP6I/AAAAAAAABjo/0uj0ji9ncVA/s320/userMenu.png" alt="userMenu" title="userMenu" width="214"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
The <code>UserMenu</code>.</div>
</td>
</tr>
<tr>
<td style="text-align: center;"><a href="http://3.bp.blogspot.com/-2faHpL3By5s/UFLLBcEyqeI/AAAAAAAABjw/xU_YeAy3ASA/s1600/userMenu_IMUserNameItem-blue_IMStatusChooserItem-red.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-2faHpL3By5s/UFLLBcEyqeI/AAAAAAAABjw/xU_YeAy3ASA/s1600/userMenu_IMUserNameItem-blue_IMStatusChooserItem-red.png" alt="userMenu_IMUserNameItem-blue_IMStatusChooserItem-red" title="userMenu_IMUserNameItem-blue_IMStatusChooserItem-red"></a></td>
<td class="tr-caption" style="text-align: center;">
<div style="text-align: left;">
<code>IMStatusChooserItem</code> (red); <code>IMUserNameItem</code> (blue); the combo box contains <code>IMStatusItem</code>s.</div>
</td>
</tr>
</tbody>

- `IMStatusItem`: A `PopupMenu.PopupBaseMenuItem` consisting of a label (like 'Away', 'Busy') and its corresponding icon. Used in the combobox in the user menu where you select your status.
- `IMUserNameItem`: A `PopupMenu.PopupBaseMenuItem` showing the user's username.
- `IMStatusChooserItem`: A `PopupMenu.PopupBaseMenuItem` that is the _entire_ avatar-username-status chooser item in the user menu. It displays user's avatar on the left (which you can click to let you change your picture), a `IMUserNameItem` to the top-right (showing the user's username), and a `PopupMenu.PopupComboBoxMenuItem` on the bottom-right that allows you to change your online status. The items in the ecombo box are `IMStatusItem`s. It also makes sure to keep your status icon up to date with your actual status. Note that only 'available' and 'offline' are _always_ shown as options in the combo box; 'busy', 'hidden', 'away' and 'idle' are only shown if that is your current status. That is, you can only set your status to 'available' or 'offline'; the other statuses are read-only (will show if that is your status but not allow you to set them as your status).
- `UserMenuButton`: This is a `PanelMenu.Button` that represents the user menu in your top panel - both the icon/username and its PopupMenu.

### `viewSelector.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-5S17gVzZkRo/UFLKlgfukBI/AAAAAAAABgM/uvJO6KB6RQg/s1600/ViewSelector.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="240" src="http://1.bp.blogspot.com/-5S17gVzZkRo/UFLKlgfukBI/AAAAAAAABgM/uvJO6KB6RQg/s320/ViewSelector.png" alt="ViewSelector" title="ViewSelector" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">ViewSelector outlined in red (currently displaying the 'Applications' tab; it also has a Windows and Search tab).</td></tr>
</tbody>

- `BaseTab`: Base class for a tab (a page in the overview, e.g. 'Windows' and 'Applications'). Requires an actor defining its title (being the thing you click on to switch to that tab) and an actor defining the tab contents.
- `ViewTab`: Extends `BaseTab` where the title actor is just a `St.Button` with some text in it. The 'windows' and 'applications' tabs are examples of this.
- `SearchTab`: Extends `BaseTab` where the title actor is a search box. The search 'tab' has a title being the `St.Entry` you enter your search into, and its page is the search results (it uses a `Search.SearchSystem` to perform the search through all of its `Search.SearchProvider`s, displaying results in a `SearchDisplay.SearchResults`. Use `addSearchProvider` and `removeSearchProvider` to add/remove providers to the search system (however if you want to add/remove search providers to the search tab in the overview, you should use `Main.overview.addSearchProvider` and `Main.overview.removeSearchProvider`, which pass the commands down to the search system in the search tab).
- `ViewSelector`: This is the notebook-like class being the 'content area' bit of the overview (the overview minus the workspace display and dash). You add pages ('tabs') to it with `addViewTab`, and switch between tabs with `switchTab`. The view selector is stored in `Main.overview._viewSelector`.

### `wanda.js` (GNOME 3.4 only)

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-sOTroZqLaJY/UFLLDRhL6bI/AAAAAAAABkE/EdQcz3J5yfQ/s1600/wanda.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-sOTroZqLaJY/UFLLDRhL6bI/AAAAAAAABkE/EdQcz3J5yfQ/s1600/wanda.png" alt="wanda" title="wanda"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>WandaIcon</code> from the <code>WandaSearchProvider</code>.</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-QFqYdojX1jM/UFLLCHqL7eI/AAAAAAAABj8/Baz135S-r64/s1600/wanda.FortuneDialog.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="220" src="http://4.bp.blogspot.com/-QFqYdojX1jM/UFLLCHqL7eI/AAAAAAAABj8/Baz135S-r64/s320/wanda.FortuneDialog.png" alt="wanda FortuneDialog" title="wanda FortuneDialog" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Example of Wanda's wisdom (popup in the middle of your screen)</td></tr>
</tbody>

- `WandaIcon`: Extends `IconGrid.BaseIcon`: it's an icon displaying an animated Wanda :).
- `WandaIconBin`: A `St.Bin` consisting of the Wanda.
- `FortuneDialog`: When you ask for wisdom from Wanda she will give it to you via a popup dialog on your screen. This is that.
- `WandaSearchProvider`: Wanda's search provider -- Wanda will only appear if you type in the magic words _exactly_ into the search box! What are the magic words to summon the Oracle? .... find out for yourself ;) (Hint: `MAGIC_FISH_KEY`).

### `windowAttentionHandler.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-udBFUzKJTmA/UFLLECAnnKI/AAAAAAAABkI/7Vpvtas0HUg/s1600/windowAttentionHandler.Source.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="62" src="http://3.bp.blogspot.com/-udBFUzKJTmA/UFLLECAnnKI/AAAAAAAABkI/7Vpvtas0HUg/s320/windowAttentionHandler.Source.png" alt="windowAttentionHandler Source" title="windowAttentionHandler Source" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Example of notification from the <code>WindowAttentionHandler</code>.</td></tr>
</tbody>

- `WindowAttentionHandler`: Handles 'window-demands-attention' signals from `global.display` and pops up the "<app> is ready" notification upon receiving it. When you start up an app it can take a while to load an in the meantime you move on to another window; when the window does actually load you get a notification letting you know the application is ready to be used.</app>
- `Source`: A [`MessageTray.Source`] tailored to window attention requests (e.g. if you focus the window then the notification is no longer relevant so it will remove itself).

### `windowManager.js`

- `WindowDimmer`: When created with an actor (for example a `Meta.WindowActor`), dims that actor. For example when you open a modal dialog from a window, that window is dimmed until you're finished with the modal dialog.
- `WindowManager`: Extra bells and whistles on the underlying window manager (being `global.windowManager`, a `Shell.WM`). This handles things like:
  - showing the workspace swicther popup upon receiving a 'switch-to-worskpace-\*' keybinding,
  - animating all your windows sliding off the screen when you switch workspaces,
  - adding animations to windows when they are minimized/maximized/mapped/destroyed,
  - dimming a parent window if you open a modal dialog for it (undimming when the dialog is dismissed),
  - showing the window switcher (Alt+Tab) popup, and
  - showing the accessibility switcher (Ctrl+Alt+Tab) popup.

### `workspace.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-BKp1BjXzVxw/UFLLGTjF85I/AAAAAAAABkk/Q3Bt8KOeOsU/s1600/workspace_Display-red_Clone-yellow_Overlay-green.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="240" src="http://2.bp.blogspot.com/-BKp1BjXzVxw/UFLLGTjF85I/AAAAAAAABkk/Q3Bt8KOeOsU/s320/workspace_Display-red_Clone-yellow_Overlay-green.png" alt="workspace_Display-red_Clone-yellow_Overlay-green" title="workspace_Display-red_Clone-yellow_Overlay-green" width="320"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>WorkspacesView.WorkspacesDisplay</code> is in red. The <code>Workspace</code> is holds all the <code>WindowClone</code>s (yellow) with the <code>WindowOverlay</code> (green, also includes the close button).</td></tr>
</tbody>

- `ScaledPoint`: A point (`x`, `y`) that has a scale applied to it in the X and Y dimensions. Contains convenience methods to interpolate between positions, or between scales. Only used for zooming in `WindowClone`s.
- `WindowClone`: The thumbnail of a window that you see in the windows tab of the Overview. You can vertical-scroll on the window to zoom in/out, click on it to activate it, drag it to move it between workspaces. One per window actor.
- `WindowOverlay`: This defines items that are overlaid on to the `WindowClone`. In particular, the window's caption and the close button (that you see on each window in the Overview).
- `Workspace`: Represents a collection of `WindowOverlay`s in the overview. Each one just looks after the overlays in its own workspace and monitor (specified at creation). It handles how to lay out its overlays (for example in GNOME 3.4 when you have 5 overlays it positions three in the top row and two in the bottom row). This is _not_ the workspace previews you see in the workspaces sidebar; that's a `WorkspaceThumbnail.WorkspaceThumbnail`.

### `workspacesView.js`

- `WorkspacesView`: A container for many `Workspace.Workspace`s. Recall that a `Workspace.Workspace` manages window thumbnails for all the windows on its _own_ workspace _and_ monitor. The `WorkspacesView` maintains a list of `Workspace`s and handles not only inter-monitor (intra-workspace) interactions (like dragging a window from one monitor to the other on the _same_ workspace, which involves moving it from the `Workspace.Workspace` for workspace `i` and monitor `j` to the `Workspace.Workspace` for workspace `i` and monitor `k`), but inter-workspace interactions (when you switch workspaces, the `WorkspacesView` should show the appropriate `Workspace.Workspace`s for that workspace, taking into account the 'workspaces-only-on-primary' setting, and also animate this action). There may be more to it than that.
- `WorkspacesDisplay`: This is essentially the 'Windows' tab in the Overview. On the right hand side it has a sidebar showing workspace thumbnails that you can choose; this is a `WorkspaceThumbnail.ThumbnailsBox`. The part that shows all the window thumbnails is a `WorkspacesView`. This class handles things like when the workspaces preview sidebar (`ThumbnailBox`) should be slidden out and in, showing/animating the rectangle about the current workspace in the sidebar animating when dynamic workspaces are added/removed, changing workspaces on scrolling over the sidebar, etc.

### `workspaceSwitcherPopup.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-f0L9g-WQUiY/UFLLElWzuYI/AAAAAAAABkQ/Sydvkcq7wKA/s1600/workspaceSwitcherPopup.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="200" src="http://3.bp.blogspot.com/-f0L9g-WQUiY/UFLLElWzuYI/AAAAAAAABkQ/Sydvkcq7wKA/s200/workspaceSwitcherPopup.png" alt="workspaceSwitcherPopup" title="workspaceSwitcherPopup" width="139"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">
<code>WorkspaceSwitcherPopup</code>.</td></tr>
</tbody>

- `WorkspaceSwitcherPopup`: This is the popup that appears when you switch workspaces (via e.g. via the keybindings) showing which workspace you've switched to.

### `workspaceThumbnail.js`

<tbody>
<tr>
<td style="text-align: center;"><a href="http://1.bp.blogspot.com/-XcIWG6Dm-XQ/UFLLFYJHhHI/AAAAAAAABkY/f-j6WF1ulkA/s1600/workspaceThumbnails.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://1.bp.blogspot.com/-XcIWG6Dm-XQ/UFLLFYJHhHI/AAAAAAAABkY/f-j6WF1ulkA/s320/workspaceThumbnails.png" alt="workspaceThumbnails" title="workspaceThumbnails" width="78"></a></td>
<td class="tr-caption" style="text-align: center;">The <code>ThumbnailsBox.</code> (yellow), with <code>WorkspaceThumbnail</code> (red) containing <code>WindowClone</code>s (green). The <code>dragPlaceholder</code> is the white bar in between the thumbnails where I'm attempting to drag a window.</td>
</tr>
</tbody>

- `ThumbnailsBox`: This is a collection of workspace thumbnails (the workspaces sidebar you see in the Overview). Handles the sliding in or out of workspaces as they are added/destroyed, and also dragging windows to create _new_ workspaces between existing ones (try dragging a window to the boundary between a two workspaces - this feature is not there in GNOME 3.2 however).
- `WorkspaceThumbnail`: This is a thumbnail of a workspace, one per workspace (seen in the workspaces sidebar in the Overview). Shows thumbnails of all the windows on that workspace (I _think_ it will only preview the primary monitor; if you have more than one monitors the other monitors & their windows will not be in the thumbnail). It is an up-to-date snapshot of its windows (updates when windows are added/removed/minimized state changed - not if they are moved or resized).
- `WindowClone`: This is a thumbnail of a window (used in a `WorkspaceThumbnail`) - one per window. It can be dragged to another workspace to switch its workspace.

### `xdndHandler.js`

- `XdndHandler`: Sets up Xdnd and passes through signals. When a non-gnome-shell object is first dragged over a gnome-shell object, the handler fires a 'drag-begin' signal. When the object being dragged leaves the gnome-shell object, the 'drag-end' signal is fired. I think it somehow incorporates with the `dnd.js` code too whereby a draggable target/object registered with `dnd.js` has the appropriate events called on it (?). Use `Main.xdndHandler` to access the instance of the handler and connect to its signals.

* * *

## Status indicators

These files all live in `js/ui/status/` and define the standardstatus indicators in the status area.

### `accessibility.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-ZQCylQz6C5I/UFLK54jYiCI/AAAAAAAABio/IXvmg_JVA98/s1600/status.accessibility.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://4.bp.blogspot.com/-ZQCylQz6C5I/UFLK54jYiCI/AAAAAAAABio/IXvmg_JVA98/s320/status.accessibility.png" alt="status accessibility" title="status accessibility" width="226"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Accessibility status icon</td></tr>
</tbody>

- `ATIndicator`: The `PanelMenu.SystemStatusButton` defining the accessibility indicator.This provides a number of `PopupSwitchMenuItem`s allowing you to toggle on and off various accessibility features (high contrast, zoom, on-screen keyboard, ...)

### `bluetooth.js`

<tbody>
<tr>
<td rowspan="2" style="text-align: center;"><a href="http://2.bp.blogspot.com/-y4s2aAi-mmM/UFMfEmoP7BI/AAAAAAAABng/pJexossiQ3U/s1600/status.bluetooth.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="320" src="http://2.bp.blogspot.com/-y4s2aAi-mmM/UFMfEmoP7BI/AAAAAAAABng/pJexossiQ3U/s320/status.bluetooth.png" width="261" alt="status bluetooth" title="status bluetooth"></a></td>
<td style="height: 160px; text-align: center;"><a href="http://2.bp.blogspot.com/-fyGSOfzSJZ0/UFMe8ZFB7LI/AAAAAAAABnI/qie-mwRnMfk/s1600/bluetooth.AuthNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="78" src="http://2.bp.blogspot.com/-fyGSOfzSJZ0/UFMe8ZFB7LI/AAAAAAAABnI/qie-mwRnMfk/s320/bluetooth.AuthNotification.png" width="320" alt="bluetooth AuthNotification" title="bluetooth AuthNotification"></a></td>
</tr>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-jstA7wrSYp0/UFMe9o_q1mI/AAAAAAAABnQ/Dp3XXbYVALo/s1600/bluetooth.ConfirmNotification.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="103" src="http://2.bp.blogspot.com/-jstA7wrSYp0/UFMe9o_q1mI/AAAAAAAABnQ/Dp3XXbYVALo/s320/bluetooth.ConfirmNotification.png" width="320" alt="bluetooth ConfirmNotification" title="bluetooth ConfirmNotification"></a></td></tr>
<tr><td class="tr-caption" colspan="2" style="text-align: center;">Bluetooth indicator icon (left); <code>AuthNotification</code> (top right); <code>ConfirmNotification</code> (bottom right).</td></tr>
</tbody>

- `Indicator`: The `PanelMenu.SystemStatusButton` defining the bluetooth indicator. Wraps around gi repository/bindings `GnomeBluetoothApplet`. Contains toggles for turning on and off bluetooth and your visibility, along with menu items to access bluetooth settings and show current bluetooth devices.
- `Source`: A `MessageTray.Source` for bluetooth notifications (pin requests, transfer requests, ...).
- `AuthNotification`: A `MessageTray.Notification` providing the notification for authorization requests, providing options 'Grant this time only', 'Reject' and 'Always grant access'.
- `ConfirmNotification`: A `MessageTray.Notification` providing the notification for pairing confirmations: "Device XYZ wants to pair with this computer. Please confirm whether PIN 'xxxx' matches the one on the device" with "Matches" and "Does not match" options.
- `PinNotification`: A `MessageTray.Notification` providing the notification for PIN requests: "Device XYZ wants to pair with this computer. Please enter the PIN mentioned on the device", with a `St.Entry` to let you enter the PIN.

### `keyboard.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://2.bp.blogspot.com/-0OGq-2Bla4k/UFLK7T8u7-I/AAAAAAAABi4/8VaJpjnoNA8/s1600/status.keyboard.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://2.bp.blogspot.com/-0OGq-2Bla4k/UFLK7T8u7-I/AAAAAAAABi4/8VaJpjnoNA8/s1600/status.keyboard.png" alt="status keyboard" title="status keyboard"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Keyboard layout status icon</td></tr>
</tbody>

- `LayoutMenuItem`: Extends `PopupMenu.PopupBaseMenuItem` consists of text and an either a label with the keyboard layout's abbreviation (eg 'en' for English (US)), or an icon with that country's flag _if_ you have gnome keyboard's 'showFlags' setting set to TRUE. In GNOME 3.2 and 3.4, this can be adjusted with dconf setting 'org.gnome.libgnomekbd.indicator.show-flags'. If you're lucky supposedly Ubuntu has the flag images in `/usr/share/pixmaps/flags` and then the flags will show. Otherwise you have to find pictures of them and put them in `$HOME/.icons/flags` named with the country's [two-letter ISO 3166-1 combination](http://www.iso.org/iso/support/country_codes/iso_3166_code_lists/iso-3166-1_decoding_table.htm). I think some packages may provide flags, but you can also get them from [gnome-look.org](http://gnome-look.org/content/search.php?search&text=language%20flags).
- `XKBIndicator`: The `PanelMenu.Button` defining the keyboard indicator. Note it is not a `SystemStatusButton` since its 'icon' is not a stock one, but either text (current keyboard layout code like 'en') or icon (flag for the country's keyboard layout). Lets you switch between keyboard layouts (only shows if you set more than one layout in the GNOME control centre -> 'Keyboard' -> 'Layout Settings').

### `network.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-vneOXZHWoow/UFMe-Zc_20I/AAAAAAAABnY/YEPReQvScOs/s1600/status.network.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="318" src="http://4.bp.blogspot.com/-vneOXZHWoow/UFMe-Zc_20I/AAAAAAAABnY/YEPReQvScOs/s320/status.network.png" width="320" alt="status network" title="status network"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Network status indicator. <code>NMWirelessSectionTitleMenuItem</code> in red;  the <code>NMDevice</code> is in blue (its title <code>PopupSwitchMenuItem</code> "Realtek RTL8188CE 802.11b/g/n Wigi Adapter" is hidden as I only have one wireless adapter; if I had more then it would display).</td></tr>
</tbody>

- `NMNetworkMenuItem`: Extends `PopupMenu.PopupBaseMenuItem`. A menu item representing a single network (which may have many access points). Shows the network name with an icon for signal strength and whether the network is secure. Shows the strength of the strongest access point.
- `NMWiredSectionTitleMenuItem`: Extends `PopupMenu.PopupSwitchMenuItem`. A menu item with an on/off toggle for the wired connection.
- `NMWirelessSectionTitleMenuItem`: Extends `PopupMenu.PopupSwitchMenuItem`. A menu item with an on/off toggle for the wifi connection (if enabled, will list the available networks as `NMNetworkMenuItem`s).
- `NMDevice`: A base class representing a particular network manager device (ethernet controller, wireless card, ...). Consists of one 'title' `PopupMenu.PopupSwitchMenuItem` that is the device name (e.g. "Realktek RTL8188CE 802.11b/g/n Wifi Adapter", "XYZ PCI Express Gigabit Ethernet Conroller") with an on/off toggle, as well as its own menu subsection under which various connections are listed (visible bluetooth devices, visible wireless networks, ...). When the toggle is switched on, it will show a status ('disconnecting...', 'authentication required', 'cable unplugged', ...) until the connection is complete, after which it just shows the 'on' toggle. The connections are sorted by strength and up to `NUM_VISIBLE_NETWORKS` (default 5) are shown with a 'More...' item. Has functions to handle checking, adding, removing, and activating particular connections. NOTE: The difference between the `NMDevice` and (say) `NMWiredSectionTitleMenuItem`: the title menu item ("Wired") is always visible. If you have _multiple_ _wired_ ethernet controllers (ports) for some reason, then there is on `NMDevice` for _each_, and _both_ appear under the "Wired" section. Then each will have an individual toggle (being the `PopupSwitchMenuItem`) allowing you to control the two wired connections separately. If you only have _one_ device for a given section, then the switch item for the Device is hidden (but the subsection with available connections is still shown).
- `NMDeviceWired`: Extends `NMDevice` for wired connections (will only display the on/off switch if you only have one wired connection port - if you have more it will have a menu section with them all).
- `NMDeviceModem`: Extends `NMDevice` for a modem (dial up/broadband). Items for individual connections have text desribing the connection with an icon for signal strength.
- `NMDeviceBluetooth`: Extends `NMDevice` for bluetooth. (NOTE: wouldn't this double up with the Bluetooth indicator?)
- `NMDeviceVPN`: Extends `NMDevice` for VPN connections.
- `NMDeviceWireless`: Extends `NMDevice` for wireless connections. The items in the submenu (one per visible network) are `NMNetworkMenuItem`s.
- `NMApplet`: The `PanelMenu.SystemStatusButton` defining the network connections indicator. Contains the various `NMDevice` subclasses (menu subsections) for each connection device you have.
- `NMMessageTraySource`: A `MessageTray.Source` for network manager notifications.

Also contains convenience functions for comparing MAC addresses and SSIDs, sorting access points by strength and converting signal strengths to a category ('strong', 'good', 'ok', 'weak'), and a constant `NUM_VISIBLE_NETWORKS` that determines the number of networks to show on the list (wifi) before adding a 'More...' item (default 5).

### `power.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-7EmFg __wJJ4/UFLK81ZyIII/AAAAAAAABjA/fJ-ojKFiG1k/s1600/status.power.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-7EmFg__ wJJ4/UFLK81ZyIII/AAAAAAAABjA/fJ-ojKFiG1k/s1600/status.power.png" alt="status power" title="status power"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Power status icon</td></tr>
</tbody>

- `Indicator`: The `PanelMenu.SystemStatusButton` defining the power indicator. Listens over DBus with object '/org/gnome/SettingsDaemon/Power' on bus 'org.gnome.SettingsDaemon' with interface 'org.gnome.SettingsDaemon.Power' for changes in your power devices (like when you switch from battery to plugged in). Displays an appropriate icon for your current power state as well as calculating estimated battery life, etc.
- `DeviceItem`: A `PopupMenu.PopupBaseMenuItem` with a label for the device type (e.g. 'AC adapter', 'Laptop battery') with a matching icon and (if appropriate) a status text (like '94%' for a battery).

### `volume.js`

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-lZRuRxQxhJ8/UFLK9raiIFI/AAAAAAAABjI/oTVkecGnpQI/s1600/status.volume.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-lZRuRxQxhJ8/UFLK9raiIFI/AAAAAAAABjI/oTVkecGnpQI/s1600/status.volume.png" alt="status volume" title="status volume"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Volume status icon</td></tr>
</tbody>

- `Indicator`: The `PanelMenu.SystemStatusButton` defining the volume indicator. Contains a `PopupSliderMenuItem` for the volume of each of your sound devices (microphone, speakers, ...), and adjusts its icon according to the volume.

* * *

# Miscellaneous files in `/usr/share/gnome-shell/js/misc`: 'imports.misc'

- `config.js`: a collection of constants that could come in handy (version numbers).
- `docInfo.js` ( **GNOME 3.2 only** ): wrappers around `Shell.DocSystem` that are used in `docDisplay.js` to allow documents to be searched for in the Overview. GNOME 3.4 doesn't have the doc search capability.
- `extensionUtils.js` ( **GNOME 3.4 only** ): set of utilities to do with extensions - some of the stuff in `extensionSystem.js` in GNOME 3.2 has been moved here, plus some extras.
- `fileUtils.js`: set of helpful functions for Gio files.
- `format.js`: an implementation of `sprintf`.
- `gnomeSession.js`: DBus stuff to do with 'org.gnome.SessionManager'.
- `history.js`: A class that saves history to a gsettings key (like looking glass command history).
- `jsParse.js` ( **GNOME 3.4 only** ): A set of functions for parsing strings of javascript code, used in the autocomplete function for the looking glass.
- `modemManager.js`: DBus stuff to do with mobile broadband.
- `params.js`: a helpful function for parsing input parameters against default parameters.
- `screenSaver.js`: DBus stuff to do with 'org.gnome.ScreenSaver'.
- `util.js`: a set of useful functions, mainly to do with spawning external processes in the background.

* * *

## Overview of classes in each file (`imports.ui`).

### `config.js`

Contains the constants:

- `PACKAGE_NAME`: 'gnome-shell' (non-localized name of the package).
- `PACKAGE_VERSION`: your gnome-shell version, a string (e.g. '3.2.2.1').
- `GJS_VERSION`: your gjs version, a string (e.g. '1.30.0').
- `HAVE_BLUETOOTH`: whether `gnome-bluetooth` is available (1 or 0).
- `SHELL_SYSTEM_CA_FILE`: the system TLS CA list (e.g. '/etc/pki/tls/certs/ca-bundle.crt').

The following constants are in GNOME 3.4 only (or 3.4+):

- `GETTEXT_PACKAGE`: 'gnome-shell'. GNOME-shell's gettext package name.
- `LOCALEDIR`: the locale directory (`/usr/share/locale`).
- `LIBEXECDIR`: `/usr/lib/gnome-shell` (maybe `lib64` for 64 bit systems).
- `SYSCONFDIR`: `/etc`.

### `docInfo.js` (GNOME 3.2 only)

- `DocInfo`: represents the info for a single document (name, timestamp, uri, mime type) along with an icon, a `launch` function to open it, and a `matchTerms` function telling you whether the given search terms match that document.
- `DocManager`: Wraps `Shell.DocSystem`, creating `DocInfo`s for documents and returning search results against search terms.

### `extensionUtils.js` (GNOME 3.4 only)

Contains the `extensions` object (maps UUID to extension object, described in `createExtensionObject`) that previously was in `extensionSystem.js` on GNOME 3.2.

Helpful functions:

- `getCurrentExtension`: call it from your extension file to get the current extension object (`imports.misc.extensionUtils.getCurrentExtension()`).
- `versionCheck`: checks if the version in `metadata.json` is compatible with the current shell version.
- `isOutOfDate`: checks if an extension is out of date (by UUID).
- `createExtensionObject`: creates an object representing an extension (used in `extensionSystem.js`). The object has members:
  - `metadata`: the metadata for the extension (`JSON.parse` of the `metadata.json` file).
  - `uuid`: the extension's UUID ('my-extension@some.domain.name').
  - `type`: the type of extension.
  - `dir`: the extension's directory (a `Gio` object).
  - `path`: the extension's directory as a string.

- other functions to do with searching for extensions and loading them.

### `fileUtils.js`

Functions:

- `listDirAsync`: give it a directory (create with e.g. `Gio.file_new_for_path`) and a callback, and it will apply the callback to the files it finds. Convenience wrapper around [`Gio.File.enumerate_children_async`](http://developer.gnome.org/gio/stable/GFile.html#g-file-enumerate-children-async).
- `deleteGFile`: deletes a (Gio) file object ("work around 'delete' being a keyword in JS" -- just calls `file.delete(null)`).
- `recursivelyDeleteDir`: recursively deletes a directory.

### `format.js`

This file defines the `format` function (that gets assigned to `String.prototype.format` in `environment.js`) - it's basically an implementation of `sprintf`.

### `gnomeSession.js`

**Remember!** I'm really confused about the words "proxy", "server", "interface" etc when it comes to DBus, so I've probably used the wrong terminology below.

- `Presence`: DBus proxy (?) for DBus object '/org/gnome/SessionManager/Presence', path 'org.gnome.SessionManager', interface 'org.gnome.SessionManager.Presence') - for getting and setting a status.
- `Inhibitor`: DBus proxy (?) for DBus path 'org.gnome.SessionManager', interface 'org.gnome.SessionManager.Inhibitor'.
- `SessionManager`: DBus proxy (?) for path 'org.gnome.SessionManager', object '/org/gnome/Sessionmanager', interface 'org.gnome.SessionManager'.

### `history.js`

- `HistoryManager`: An object that remembers text up to 512 items (`DEFAULT_LIMIT`) and optionally saves them into a gsettings key. For example, the looking glass command history is saved in gsettings key 'org.gnome.shell.looking-glass-history', and the run prompt (Alt+F2) history is saved in 'org.gnome.shell.command-history'.

### `jsParse.js` (GNOME 3.4 only)

This is a set of functions doing some basic parsing of javascript code in order to provide sensible autocompletions.

The main function you will probably want to call from external modules (according to the source) is `getCompletions(text, commandHeader, globalCompletionList)`. There are a whole bunch of other helper functions in there too. See the source for full documentation.

### `modemManager.js`

**Remember!** I'm really confused about the words "proxy", "server", "interface" etc when it comes to DBus, so I've probably used the wrong terminology below.

- `ModemGsm`: Class for interacting with DBus interface 'org.freedesktop.ModemManager.Modem.Gsm.Network' (mobile internet).
- `ModemCdma`: Class for interacting with DBus interface 'org.freedesktop.ModemManager.Modem.Cdma' (mobile internet).

### `params.js`

Contains a handy function `parse` that parses user-provided parameters against default parameters (filling in with defaults if not supplied), and throwing an error if unrecognised parameters are given (if unrecognised parameters are not allowed). Used throughout the `js/ui/*.js` code.

### `screenSaver.js`

- `ScreenSaverProxy`: A proxy for DBus object '/org/gnome/ScreenSaver' on bus 'org.gnome.ScreenSaver'.

### `util.js`

Handful of utility functions (more documentation in the source):

- `findUrls`: searches input string for URLs.
- `spawn`: spawns a process specified by the argument in array form (e.g. `['ls', '-al', '$HOME']`), handling errors by popping up a notification in the message tray.
- `spawnCommandLine`: spawns a process specified by a string (e.g. `ls -al $HOME`), handling errors by popping up a notification in the message tray (using `Main.notifyError`(#main.notifyError)).
- `killall`: kills the process specified by the given name.
- `fixupPCIDescription`: converts the description of a device to something a little shorter. Used in `status/network.js` for the network indicator applet.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2012-09-14T05:39:00-07:00">05:39</abbr>](gnome-shell-javascript-source.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=8041483659423024822&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8041483659423024822&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8041483659423024822&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8041483659423024822&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8041483659423024822&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=8041483659423024822&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2012/09/gnome-shell-javascript-source.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [code](../../search/label/code.html), [developing](../../search/label/developing.html), [gnome-shell](../../search/label/gnome-shell.html), [gnome-shell-extension](../../search/label/gnome-shell-extension.html), [javascript](../../search/label/javascript.html), [tutorial](../../search/label/tutorial.html)

