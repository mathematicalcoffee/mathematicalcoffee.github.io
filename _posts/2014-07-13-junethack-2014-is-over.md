---
layout:   post
title:    "Junethack 2014 is over!"
date:     2014-07-13 19:48 +1000
comments: true
categories: ~
tags: [games, junethack, nethack]
authors: [amy]
---
### Junethack 2014 is over!

This is a rather long post about Junethack (mainly to do with improving unique deaths), so I've provided a table of contents.

- Some fun
- Some fun death analysis
  - Favoured variants
  - Favoured classes
  - Deadliest deaths
  - Most common deaths (after cleaning)

- Ideas for next time (unique deaths)
  - GruntHack's "killed by a falling {foo}" death
  - Shopkeeper deaths
  - GruntHack's "killed by a {foo}'s {bar}" deaths
  - Deaths of the form "killed by {foo}, while {bar}"
  - Killed by a ghost of {playername}
  - Food poisoning
  - Deities
  - Minions of deities
  - Priests and priestesses
  - GruntHack's change of the kill prefix
  - GruntHack's Racial monsters

- Appendix: Implementation
- Appendix: filter unique deaths
- Appendix: data
  - `deaths` table
  - `users` table
  - `junethack.users` table
  - `clans` table

June is finally over, and with it [Junethack](http://junethack.de/). Check out the individual scoreboard [here](https://junethack.de/scoreboard) and the clan scoreboard [here](https://junethack.de/clan_competition).

I managed to take out the most unique deaths trophy ( [my clan](https://junethack.de/clan/overcaffeinated) consisted of just me), and also to ascend once. I had planned to ascend more often, but [clan demilichens](https://junethack.de/clan/demilichens) put up some pretty fierce competition for unique deaths, so I had to focus solely on it.

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-Hb7_3NedONE/U8M-t8N2m3I/AAAAAAAAEHc/x24f9idYVsc/s1600/victory_avatar.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-Hb7_3NedONE/U8M-t8N2m3I/AAAAAAAAEHc/x24f9idYVsc/s1600/victory_avatar.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Woohoo!</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-AZ5HZAMVKBE/U8M-7R9X0aI/AAAAAAAAEHg/mdXzDJpdFrc/s1600/most_unique_deaths.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-AZ5HZAMVKBE/U8M-7R9X0aI/AAAAAAAAEHg/mdXzDJpdFrc/s640/most_unique_deaths.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">clan demilichens put up very strong competition</td></tr>
</tbody>

<tbody>
<tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-nJDhgtOPrPw/U8M_KetC_oI/AAAAAAAAEHo/qbY2fBxUgs0/s1600/fastest_ascension_nethack4.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-nJDhgtOPrPw/U8M_KetC_oI/AAAAAAAAEHo/qbY2fBxUgs0/s640/fastest_ascension_nethack4.png"></a></td></tr>
<tr><td class="tr-caption" style="text-align: center;">Somehow I managed to get the second fastest ascension (by turns) for nethack4</td></tr>
</tbody>

A big thanks to all the organisers of Junethack, and also to member jonadab (from demilichens) who was the main unique deaths player from that clanned, and with whom it was very fun competing.

I definitely had a lot of fun going for unique deaths (after 500 or so they start to become quite hard to get, short of startscumming for wands of polymorph which I didn't do (it is perfectly acceptable, but I have a personal preference not to)).

I have a few comments to make, most (all) of which relate to unique deaths. You can see a list of all unique deaths attained throughout the month [here](https://junethack.de/deaths#unique_deaths).

I was personally proud of these deaths:

- "killed by touching {artifact}", where I managed to get every aligned artifact (not just Quest artifacts). Looots of fountain quaffing. I was the only clan/person to obtain all of these.
- "pissed off deity", obtained by #pray-ing in nethack1.3d until the deity smites you. One other clan did obtain this but I told them how to do it.
- "disintegrated by amateur-hour horseshit": as an incantifier in dnethack, die of oversatiating while hallucinating. Incantifiers are a new race in dnethack who eat magic rather than food.

## Some fun

Overall:

- 12919 games were played, of which
- 6416 were actually played, and
- 6503 were scummed (quit or escaped on turn <= 10).

The top 3 most games played:

<caption>Most games played</caption><colgroup>
<col width="29%">
<col width="6%">
<col width="8%">
<col width="27%">
<col width="5%">
</colgroup><thead>
<tr class="header">
<th align="center">Junethack.Username</th>
<th align="center">N</th>
<th align="left"></th>
<th align="center">Clan</th>
<th align="center">N</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">jonadab</td>
<td align="center">1228</td>
<td align="left"><strong>1</strong></td>
<td align="center">demilichens</td>
<td align="center">2126</td>
</tr>
<tr class="even">
<td align="center">coffeebug</td>
<td align="center">746</td>
<td align="left"><strong>2</strong></td>
<td align="center">overcaffeinated</td>
<td align="center">1312</td>
</tr>
<tr class="odd">
<td align="center">coffeebeetle</td>
<td align="center">566</td>
<td align="left"><strong>3</strong></td>
<td align="center">BlackjackAndHookers</td>
<td align="center">620</td>
</tr>
<tr class="even">
<td align="center">Wooble</td>
<td align="center">462</td>
<td align="left"><strong>4</strong></td>
<td align="center">TeamSplat</td>
<td align="center">366</td>
</tr>
<tr class="odd">
<td align="center">Ecthel</td>
<td align="center">327</td>
<td align="left"><strong>5</strong></td>
<td align="center">Justice</td>
<td align="center">327</td>
</tr>
</tbody>

Who was responsible for the ~50% of scummed games? Note: these could be attempts at conducts or particular unique deaths, like rolling a wizard until you get a wand of polymorph to zap your pet with to get an out-of-depth monster. Not all players agree with start-scumming (for example in the case of unique deaths I didn't do any), but to be honest it is a perfectly valid/accepted tactic.

<caption>Most games scummed</caption><colgroup>
<col width="29%">
<col width="6%">
<col width="8%">
<col width="16%">
<col width="5%">
</colgroup><thead>
<tr class="header">
<th align="center">Junethack.Username</th>
<th align="center">N</th>
<th align="left"></th>
<th align="center">Clan</th>
<th align="center">N</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">Ecthel</td>
<td align="center">3101</td>
<td align="left"><strong>1</strong></td>
<td align="center">demilichens</td>
<td align="center">3146</td>
</tr>
<tr class="even">
<td align="center">DeuceofJune</td>
<td align="center">2244</td>
<td align="left"><strong>2</strong></td>
<td align="center">Goonsinjune</td>
<td align="center">2247</td>
</tr>
<tr class="odd">
<td align="center">the88kod</td>
<td align="center">858</td>
<td align="left"><strong>3</strong></td>
<td align="center">hi</td>
<td align="center">52</td>
</tr>
<tr class="even">
<td align="center">nooodl</td>
<td align="center">47</td>
<td align="left"><strong>4</strong></td>
<td align="center">Justice</td>
<td align="center">21</td>
</tr>
<tr class="odd">
<td align="center">timco</td>
<td align="center">37</td>
<td align="left"><strong>5</strong></td>
<td align="center">Smile_Mold</td>
<td align="center">16</td>
</tr>
</tbody>

What does the average nethack game look like?

<colgroup>
<col width="8%">
<col width="19%">
<col width="26%">
<col width="20%">
<col width="15%">
<col width="8%">
</colgroup><thead>
<tr class="header">
<th align="center">variant</th>
<th align="center">Average length game (ascension)</th>
<th align="center">Average length game (death)</th>
<th align="center">Number of ascensions</th>
<th align="center">Number of games</th>
<th align="center">Rate (%)</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">vanilla</td>
<td align="center">39704</td>
<td align="center">669</td>
<td align="center">108</td>
<td align="center">8217</td>
<td align="center">1.31</td>
</tr>
<tr class="even">
<td align="center">nethack4</td>
<td align="center">39411</td>
<td align="center">6168</td>
<td align="center">20</td>
<td align="center">116</td>
<td align="center">17.24</td>
</tr>
<tr class="odd">
<td align="center">acehack</td>
<td align="center">36304</td>
<td align="center">739</td>
<td align="center">16</td>
<td align="center">1345</td>
<td align="center">1.19</td>
</tr>
<tr class="even">
<td align="center">unnethack</td>
<td align="center">31184</td>
<td align="center">1991</td>
<td align="center">8</td>
<td align="center">1125</td>
<td align="center">0.71</td>
</tr>
<tr class="odd">
<td align="center">dnethack</td>
<td align="center">76620</td>
<td align="center">2607</td>
<td align="center">1</td>
<td align="center">239</td>
<td align="center">0.42</td>
</tr>
<tr class="even">
<td align="center">grunthack</td>
<td align="center">50257</td>
<td align="center">483</td>
<td align="center">1</td>
<td align="center">1418</td>
<td align="center">0.07</td>
</tr>
<tr class="odd">
<td align="center">sporkhack</td>
<td align="center">40914</td>
<td align="center">3006</td>
<td align="center">1</td>
<td align="center">169</td>
<td align="center">0.59</td>
</tr>
<tr class="even">
<td align="center">oldhack</td>
<td align="center">NaN</td>
<td align="center">368</td>
<td align="center">0</td>
<td align="center">290</td>
<td align="center">0</td>
</tr>
</tbody>

- dnetgames are very long
- no-one ascended oldhack
- nethack4 had the highest rate (it's not popular; people tend not to play it unless they specifically wanted the ascension for a trophy, for example)
- vanilla is the most played variant (no surprises there)
- only 1 ascension for dnethack, GruntHack and sporkhack (stth...)!
- GruntHack and oldhack games are very short, probably because oldhack was mainly used for its unique deaths, and GruntHack was also a major unique-death variant.

## Some fun death analysis

Note: see also [Jonadab's unique death comments](http://74.135.83.0:8018/nethack-stuff/junethack-unique-deaths-comments-2014-jonadab.html).

Here I'll just focus on the overcaffeinated (777) and demilichens (767) clans as there was a decent break between these two and the rest (but very well done to BlackjackAndHookers (341) too).

In total, 12919 unique deaths were obtained over the month.

It's hard to achieve a different death every time you play. Here's how we went. The "unique deaths (proposed)" column lists unique deaths under the scheme I propose later.

<caption>statistics</caption><colgroup>
<col width="14%">
<col width="13%">
<col width="20%">
<col width="25%">
<col width="25%">
</colgroup><thead>
<tr class="header">
<th align="center">clan</th>
<th align="center">games played</th>
<th align="center">unique deaths (raw)</th>
<th align="center">unique deaths (junethack)</th>
<th align="center">unique deaths (proposed)</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">demilichens</td>
<td align="center">5272</td>
<td align="center">888 (17%)</td>
<td align="center">767 (15%)</td>
<td align="center">458 (9%)</td>
</tr>
<tr class="even">
<td align="center">overcaffeinated</td>
<td align="center">1313</td>
<td align="center">812 (62%)</td>
<td align="center">777 (59%)</td>
<td align="center">520 (40%)</td>
</tr>
</tbody>

Note: demilichens did not exclusively focus on unique deaths, so disregard their percentages.

### Favoured variants

For jonadab (the main deaths-player from demilichens) and I, here are some further stats:

<tbody>
<tr><td style="text-align: center;">
<a href="http://4.bp.blogspot.com/-apDkE-j8D6U/U8NAgsDtXgI/AAAAAAAAEH0/beOwW8VqUgo/s1600/games_for_deaths.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/-apDkE-j8D6U/U8NAgsDtXgI/AAAAAAAAEH0/beOwW8VqUgo/s1600/games_for_deaths.png"></a>
</td></tr>
<tr><td class="tr-caption" style="text-align: center;">Breakdown of games played per variant</td></tr>
</tbody>

As you can see, we both used GruntHack heavily (it has the most verbose death messages), jonadab used acehack heavily whereas I used NAO heavily. I didn't play any vanilla games on the acehack server, and jonadab didn't play vanilla games on the NAO server.

### Favoured classes

What classes do we like to deathscum in? (restricting to vanilla classes only):

<tbody>
<tr><td style="text-align: center;">
<a href="http://4.bp.blogspot.com/-KotnL0lp8yc/U8NA197PGbI/AAAAAAAAEH8/lGfsRuPIntc/s1600/roles_for_deaths.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://4.bp.blogspot.com/-KotnL0lp8yc/U8NA197PGbI/AAAAAAAAEH8/lGfsRuPIntc/s1600/roles_for_deaths.png"></a>
</td></tr>
<tr><td class="tr-caption" style="text-align: center;">Favourite roles for death scumming</td></tr>
</tbody>

I heavily favour arcs because of the ability to grab them and dig down in order to find harder monsters (E takes care of most monsters you /don't/ want to die to).

Wizards are popular for two reasons:

- to use acehack's ability to reroll the starting inventory for a wand of polymorph. The wand can then be zapped at the pet to obtain out-of-depth monsters to die to.
- they start with a cloak of magic resistance, so if you want to die to "M[rs]. Foo, the shopkeeper" as opposed to their wands (recorded in most variants as "killed by a (wand|magic missile)"), the cloak of magic resistance lets you survive the wands until the shopkeeper starts melee-ing you. (Shopkeepers all start with at least a wand of striking, and 25% chance for a wand of magic missile).

Priests can also be popular in order to die to the "wrath of {deity}" for deities that are unavailable as starting deities. For example, one can never start with a neutral knight: to become neutral, you must convert. Priests, however, get a random deity from the pantheon. Hence if you really wanted to be killed by Brigit you could play a knight and hope to find somewhere to convert relatively early on, or just keep rolling neutral priests until you got Brigit.

### Deadliest deaths

As mentioned earlier, it's hard to be killed by something different each time. What were we killed by the most? Note: from now on, I will concentrate on just jonadab as the demilichens representative, because he was the main deaths-player and seemed to focus just on deaths. Including other demilichens members whose sole purpose was /not/ to obtain unique deaths would misrepresent the statistics.

<caption>deadliest killers (combined)</caption><colgroup>
<col width="40%">
<col width="16%">
<col width="12%">
</colgroup><thead>
<tr class="header">
<th align="center">unique.death.junethack</th>
<th align="center">coffeebug</th>
<th align="center">jonadab</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">killed by a dwarf</td>
<td align="center">8</td>
<td align="center">38</td>
</tr>
<tr class="even">
<td align="center">killed by a water moccasin</td>
<td align="center">34</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">killed by a jackal</td>
<td align="center">13</td>
<td align="center">12</td>
</tr>
<tr class="even">
<td align="center">killed by a sewer rat</td>
<td align="center">14</td>
<td align="center">10</td>
</tr>
<tr class="odd">
<td align="center">killed by the wrath of Thoth</td>
<td align="center">3</td>
<td align="center">20</td>
</tr>
</tbody>

<caption>deadliest killers (individual)</caption><colgroup>
<col width="35%">
<col width="15%">
<col width="37%">
<col width="11%">
</colgroup><thead>
<tr class="header">
<th align="center">unique.death.junethack</th>
<th align="center">coffeebug</th>
<th align="center">unique.death.junethack</th>
<th align="center">jonadab</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">killed by a water moccasin</td>
<td align="center">34</td>
<td align="center">killed by a dwarf</td>
<td align="center">38</td>
</tr>
<tr class="even">
<td align="center">killed by a water demon</td>
<td align="center">19</td>
<td align="center">killed by the wrath of Thoth</td>
<td align="center">20</td>
</tr>
<tr class="odd">
<td align="center">killed by a sewer rat</td>
<td align="center">14</td>
<td align="center">killed by the wrath of Odin</td>
<td align="center">15</td>
</tr>
<tr class="even">
<td align="center">killed by a small mimic</td>
<td align="center">13</td>
<td align="center">escaped</td>
<td align="center">14</td>
</tr>
<tr class="odd">
<td align="center">killed by a fox</td>
<td align="center">13</td>
<td align="center">killed by the wrath of Anhur</td>
<td align="center">14</td>
</tr>
</tbody>

No surprise that I was disproportionately killed by water moccasins and demons. I obtained 26 deaths to touching artifacts (and one "due to inadvisable haste" which required wishing for an artifact in dnethack). All of these required wishing bar Sting and Orcrist, so there was a lot of fountain scumming.

Jonadab was killed by dwarves a lot --- I'm not sure what to make of that. Perhaps expeditions to Minetown for all the shopkeepers one could die to there? I imagine the wrath of Thoth (neutral wiz) could be a way of ending a game that was not going well (Jonadab's favoured class was wizard as mentioned earlier)?

I'm not sure why I had so many deaths to E-able monsters (besides the water foo); perhaps overconfidence? In the case of mimics, they can kill a level 1 player in one hit (3d4 damage), particularly if you encounter a second one while running away from the first. I'm inclined to believe overconfidence, though. I did manage 6 minotaur deaths (one in nh1.3d, the others in the other variants) which I'm quite proud of; they were all at the Castle with level 1 or 2 characters.

### Most common deaths (after cleaning)

Here are the most common deaths, after the suggestions I made have been implemented.

<caption>deadliest killers (individual)</caption><colgroup>
<col width="37%">
<col width="14%">
<col width="37%">
<col width="11%">
</colgroup><thead>
<tr class="header">
<th align="center">unique.death.me</th>
<th align="center">coffeebug</th>
<th align="center">unique.death.me</th>
<th align="center">jonadab</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">killed by a shopkeeper's wand</td>
<td align="center">74</td>
<td align="center">killed by the wrath of a deity</td>
<td align="center">268</td>
</tr>
<tr class="even">
<td align="center">killed by the wrath of a deity</td>
<td align="center">52</td>
<td align="center">killed by a minion of a deity</td>
<td align="center">58</td>
</tr>
<tr class="odd">
<td align="center">poisoned by a rotted corpse</td>
<td align="center">51</td>
<td align="center">killed by a shopkeeper</td>
<td align="center">57</td>
</tr>
<tr class="even">
<td align="center">killed by a shopkeeper</td>
<td align="center">42</td>
<td align="center">poisoned by a rotted corpse</td>
<td align="center">49</td>
</tr>
<tr class="odd">
<td align="center">killed by a shopkeeper's magic missile</td>
<td align="center">40</td>
<td align="center">killed by a shopkeeper's wand</td>
<td align="center">48</td>
</tr>
</tbody>

You can see we would have saved a lot of time dying to shopkeepers (me) or #praying for minions/smites (jonadab), or eating lots of rotted corpses.

## Ideas for next time (unique deaths)

In light of the month gone by, I have some suggestions re unique deaths to cut down on those deaths that are not "truly different".

In general I think the competition went quite well, but there are definitely some improvements to be made next year (mostly to do with GruntHack's very verbose way of reporting deaths).

I'm not sure how far to take condensing the deaths though. If you can argue that "poisoned by a rotten {monster} corpse" should be condensed to "poisoned by a rotten corpse" for all monsters, why can't "killed by a {monster}" be condensed to "killed by a monster"? But then there would be no fun to it.

Note: many of these suggestions are already implemented in NAO's "reduced deaths" page for each player. See [DeathRobin's](http://alt.org/nethack/player-endings-reduced.php?player=DeathRobin) for an example.

### GruntHack's "killed by a falling {foo}" death

**Must** be converted to "killed by a falling object", to be in line with all the other variants (besides "killed by a falling rock", which comes from dying to a rock trap).

Otherwise one could simply keep renaming their playerfruit and die over and over to it (by throwing it up in the air and having it fall onto them, which causes some small amount of damage). This would generate an infinite number of deaths that are currently counted as unique. (This is the very reason "killed by kicking {foo}" is converted currently).

For interest, in June 2014 the only deaths of this nature were "killed by a falling slime mold", "killed by a falling statue of a newt", and "killed by a falling dart". I know I was certainly aware of this death as was demilichens, and after testing it a couple of times we mutually agreed not to do it (it would explode the number of possible deaths given then large number of items easily available in nethack. Particularly with GruntHack's addition of materials to the item name, e.g. 'plastic pick-axe', 'gold pick-axe').

### Shopkeeper deaths

There are many, many shopkeepers that one can die to. In all the variants but GruntHack, you need a way to survive the shopkeeper's wands in order to be killed by the shopkeeper themselves (e.g. be a wizard since you start with the CoMR).

With GruntHack's verbose death reporting (next section), the number of deaths that can be obtained just from shopkeepers explodes, and isn't really worth it.

I suggest to change "M[rs]. Foo, the shopkeeper" to "a shopkeeper" (this is what the NAO "reduced deaths" does).

### GruntHack's "killed by a {foo}'s {bar}" deaths

GruntHack is very verbose in its death reasons. If you are killed by a wand of striking zapped by a gnome, the other variants record this as "killed by a wand". GruntHack records this as "killed by a gnome's wand".

In general, this is great (you know specifically what killed you). For unique deaths, this means that in practice one can run around attacking every shopkeeper one finds and die to their magic missile or wand of striking (or if a wizard, the shopkeeper themselves once the wands run out). Every shopkeeper is guaranteed to have a wand of striking, and has a 25% chance to have a wand of magic missile.

Given the huge number of shopkeepers (some of the variants have more), this makes shopkeeper-related deaths (and wand deaths) quite tedious. In practice, the deaths are the same.

The case of shopkeepers can be largely dealt with with the above fix (all shopkeepers become "a shopkeeper"), but in general, one could convert "killed by {foo}'s {bar}" to "killed by a monster's {bar}".

This is to stop tedious deaths where one throws/gives their attack wand to the first intelligent monster they see so that it will zap the wand at the player (and kill them). Granted, in practice this may not be particularly easy to do (I haven't tried), and you'd want to be a wizard to improve the chance of starting with an attack wand.

The regex would also be hard to implement, due to valid deaths with apostrophes in them, such as

- "killed by a gas spore's explosion" would become "killed by a monster's explosion"
- "quit while already on Charon's boat" --> "quit while already on monster's boat"
- "killed by Durin's Bane" (a monster in unnethack) --> "killed by monster's Bane"

These are clearly nonsensical, but also there could be too many counterexamples to simply exclude them in a regex.

### Deaths of the form "killed by {foo}, while {bar}"

Vanilla nethack only has ", while helpless" deaths but the patched version of vanilla on NAO is more detailed in the types of helplessness, and some of the variants add even more.

Some of these are non-trivial to obtain (e.g. "while being scared by rattling") and I think that one of each death should count.

For example, "{kill message}, while {bar}" could be "killed, while {bar}".

A single death such as "killed by a gnome, while frozen by a monster's gaze" would count as the single death "killed, while frozen by a monster's gaze" (it is up to you to be killed by a gnome while not frozen in order to get "killed by a gnome").

There is actually a huge range of conditions that one can die while experiencing.

- getting stoned: delayed stoning by a footrice
- fumbling: while fumbling (fumble boots/gloves or ice, I think)
- sleeping: sleeping (e.g. by a trap or spell or wand or potion)
- hiding from thunderstorm: during a lightning strike on the Plane of Air
- stuck in a spider web: stuck in a spider web trap
- reading a book: reading a spellbook
- being frightened to death: ghost from a milky bottle, or haunted temple
- frozen by a potion: paralysis potion
- sleeping off a magical draught: sleeping from the _vapour_ of a sleep potion (quaffing is "while sleeping").
- gazing into a mirror: you are a floating eye and looked into a mirror, freezing yourself
- ringing a bell: you rang a cursed bell and summoned a nymph, then there's a chance you simply take some time to ring the bell.
- jumping around: while jumping (either magical or non-magical)
- moving through the air: from Newton's third law
- taking off clothes: while a nymph is stealing armour from you
- paralyzed by a monster: as a result of it hitting you (e.g. guardian nagas have a paralysing bite attack)
- digesting something: while digesting a monster, e.g. polymorphed into a purple worm. You have a better chance of this if you have slow digestion as digestion is slower then.
- frozen by a monster's gaze: frozen because (e.g.) you hit the ubiquitous floating eye
- frozen by a monster: frozen because you hit a gelatinous cube (cv "paralyzed by a monster", it hit you)
- frozen by a trap: some chest traps will freeze you.
- being scared by rattling: skeletons rattle their bones when you #chat to them. Scary.
- being terrified of a demon: when you summon a demon after chaotic same-race sacrifice, you are momentarily terrified.
- trying to turn the monsters: while using #turn
- praying: while #praying.
- disrobing: while taking off armour
- dressing up: while putting on armour
- dragging an iron ball: while punished
- pretending to be a pile of gold: while polymorphed into a mimic, and pretending to be a pile of gold.
- unconscious from rotten food: self-explanatory
- fainted from lack of food: self-explanatory
- vomiting: if you eat a rotten egg, for example.
- being scared stiff: being scared by Magicbane
- opening a container: It takes one turn to open a container. I _think_ if you are paralyzed by a trap you get that instead. Or perhaps tins, which take some time to open.
- gazing into a crystal ball: Using a crystal ball takes time.
- helpless: anything not covered by the above (while engraving, for example).

In vanilla I'm not sure that you can actually obtain deaths that involve you being polymorphed (because when you die you either revert to human form meaning you don't die, or if you're wearing an amulet of unchanging you always get "killed while stuck in creature form"). However I think some of the other variants have fixed this. For example in GruntHack if you are polymorphed into a paper golem and are caught in a fire trap, you will get "burned away" (or something like that) if you wearing the amulet of unchanging instead of "killed while stuck in creature form".

### Killed by a ghost of {playername}

Strip the player names. Sure, it'd be hard to actually exploit this (you'd have to organise with a few other players to all play at the same time and die on particular levels in an attempt to load each other's ghosts), but these deaths are all really the same.

I suppose you could keep those ghosts whose names are hard-coded into the source (they are the names of the nethack devs), but again, they're the same deaths.

### Food poisoning

When you eat a tainted corpse and get "poisoned by a rotted {monster} corpse", perhaps this could be converted to "poisoned by a rotted corpse". I suppose you need to draw the line at condensing deaths somehow (for example, one could argue that condensing these deaths was the same as condensing "killed by a {monster}" to "killed by a monster" for all monsters). But I think there are still enough unique deaths available that condensing these will encourage players to go for different types of deaths.

### Deities

Many, many deaths of the form "killed by the wrath of {deity}". These are obtained by starting a character with the appropriate alignment and simply #pray-ing until smitten by your god.

One _could_ condense these to "killed by the wrath of a deity" (a la nethack 1.3d's "pissed off deity"), though one could also argue that there are only a relatively small number of deities (39) so this is not much of an issue.

To obtain deaths to deities that can not normally be accessed (for example, a knight can never start neutral), you can either convert (in my opinion this requires some skill and hence these deaths should somehow be noted), _or_ you can simply roll a neutral priest, who will get a random neutral deity, and hope that you get Brigit. The latter doesn't require skill, just luck and the willingness to keep rerolling until you get the right deity.

### Minions of deities

Sometimes when you #pray to a deity they will send a minion to smite you. Minions can be any A bar ki-rin and Archon (lawful deities), any E (neutral), or any & (demon) that is not a lord or prince, and is either nonaligned or chaotically-aligned (for example, erinyes are lawful).

There are many "killed by a {monster} of {deity}" deaths that are somewhat tedious to obtain, because really the only way to do it is to #pray repeatedly and hope you get a minion before you get smitten. You could also farm the high altar for minions but it seems like a bit too much work to get all the way to the high altar only to summon a single minion to die to.

I think these could either be converted to "killed by a minion of {deity}" or "killed by a minion of a deity" or "killed by a water elemental of {deity}" for each minion. NAO's "reduced deaths" version uses the latter, though I prefer the middle.

### Priests and priestesses

At the very least, priests and priestesses should be the same, i.e. "killed by a priest(ess) of {deity}". One could conceivably condense this to "killed by a priest(ess) of a deity", which I favour, but again there is the question of condensing too much.

### GruntHack's change of the kill prefix

In GruntHack, rather than being "killed by a freezing sphere", you are "frozen by a freezing sphere". The kill prefix is changed to match the damage type ("frozen by", "burned by", "shocked by", ...).

This means that you can obtain both "frozen by a freezing sphere" and "killed by a freezing sphere" depending on which variant to play, though those of these are really the same death.

One could strip off the kill prefix "(killed|frozen|burned|shocked|disintegrated) by" completely, though I haven't thought about this hard enough to decide yet whether this could merge deaths that are different. One example that comes to mind is being killed by a black dragon hitting you, as opposed to being disintegrated by one. In this case vanilla nethack has 'killed by a black dragon' and 'killed by a blast of disintegration', but perhaps there are other similar cases.

Ahh, grunt again. For example, water elementals have engulfing attacks. You can be "killed by a water elemental" (it melees you to death) or "suffocated by a water elemental" (it engulfs you), and these are fundamentally different. Silly grunt!

### GruntHack's Racial monsters

GruntHack introduces racial monsters, for example there are ogre werejackals, elven werejackals, ettin werejackals, ... Soldiers, sergeants, captains, lieutenants, mummies, zombies, vampire foo, werefoo, nurses, guards, prisoners, watchmen, watch captains, shopkeepers, and priests/priestesses can be racial, leading to a huge number of deaths by the same monster of different races.

I probably **wouldn't** bother condensing these, since it does appear that races add to the difficulty of the monsters and hence affect their generation. For example, ettin werefoo have a much higher difficulty level than kobold werefoo and are hence only encountered much deeper in the dungeon.

The one exception is in the case of shopkeepers and priest(esse)s. Shopkeepers have been addressed previously (and their races are not recorded in the death message). I think races should be stripped from priests because rather than having difficulties and so on, they are only generated in temples so to hope to encounter a good spread of the clergy in various races is unlikely.

# Appendix: Implementation

Here's some code similar to [Junethack's `normalize_death`](https://github.com/junethack/Junethack/blob/master/lib/junethack/normalize_death.rb) code, but it implements my suggestions. It's written in [R](http://www.r-project.org/):

<caption>conversions made</caption><colgroup>
<col width="41%">
<col width="41%">
</colgroup><thead>
<tr class="header">
<th align="center">from</th>
<th align="center">to</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">killed by a {foo}, while {bar}</td>
<td align="center">killed, while {bar}</td>
</tr>
<tr class="even">
<td align="center">killed by a hallucinogen-distorted {foo}</td>
<td align="center">killed by a hallucinogen-distorted monster</td>
</tr>
<tr class="odd">
<td align="center">killed by a invisible {foo}</td>
<td align="center">killed by a invisible monster</td>
</tr>
<tr class="even">
<td align="center">killed by a falling {not 'rock'}</td>
<td align="center">killed by a falling object</td>
</tr>
<tr class="odd">
<td align="center">ghost of {name}</td>
<td align="center">ghost</td>
</tr>
<tr class="even">
<td align="center">poisoned by a rotted {monster} corpse</td>
<td align="center">poisoned by a rotted corpse</td>
</tr>
<tr class="odd">
<td align="center">wrath of {deity}</td>
<td align="center">wrath of a deity</td>
</tr>
<tr class="even">
<td align="center">priest/priestess</td>
<td align="center">priest(ess)</td>
</tr>
<tr class="odd">
<td align="center">M[rs]. {name}, the shopkeeper</td>
<td align="center">a shopkeeper</td>
</tr>
<tr class="even">
<td align="center">killed by touching {artifact}</td>
<td align="center">killed by touching an artifact</td>
</tr>
<tr class="odd">
<td align="center">killed by a {minion} of {deity}</td>
<td align="center">killed by a minion of a deity</td>
</tr>
</tbody>

Notes:

- naming a monster strips _everything_ after the name, _including_ ", while bar" (if present). Otherwise I could name (say) my dog "foo, while helpless" and be killed by it to get "killed by a little dog named foo, while helpless" in an attempt to get "killed, while helpless".
- "invisible hallucinogen-distorted" as a combination counts as unique.
- deaths with ", while" attempt to preserve the first word. For example "burned by asdf, while helpless" and "killed by asdf, while helpless" counts as two different deaths. I'm not sure if this could lead to some nonsensical deaths.

    normalize.deaths.extra <- function (deaths) {
        # sic. the 'killey' is a typo on that site.
        deaths <- gsub('^killey by an ', 'killed by a ', deaths)
    
    
        # convert 'killed by a foo, while bar' to 'killed, while bar'
        # (up to you to be killed by them while *not* bar)
        # NOTE: preserve first verb, is this nonsensical?
        # NOTE: ', while' occurs AFTER 'named', so do not die to a named animal
        # or you will lose this.
        deaths <- gsub('^([^]+).*, while (.*)$', '\\1, while \\2', deaths)
    
    
        # 'hallucinogen-distorted'
        deaths <- gsub('hallucinogen-distorted .*', 'hallucinogen-distorted monster', deaths)
    
    
        # 'invisible'
        deaths <- gsub('by (the )?invisible ', 'by ', deaths)
        deaths <- gsub('by (an|a) invisible ', 'by a ', deaths)
        deaths <- gsub('by invisible ', 'by a ', deaths)
        deaths <- gsub('by a invisible (hallucinogen-distorted )?.*', 'by an invisible \\1monster', deaths)
        
        
        deaths <- gsub(' (her|his) ', ' eir ', deaths)
        deaths <- gsub(' (her|him)self ', ' eirself ', deaths)
        deaths <- gsub(' (her|him)self$', ' eirself', deaths)
        
        
        # note: named strips everything after it, so don't try to get ', while bar'
        # conditions with a named monster.
        deaths <- gsub(' (called|named) .*', '', deaths)
    
    
        deaths <- gsub(' \\(with the Amulet\\)$', '', deaths)
        
        
        deaths <- gsub('choked on .*', 'choked on something', deaths)
        
        
        deaths <- gsub('killed by kicking .*', 'killed by kicking something', deaths)
       
       
        # killed by a falling {foo}
        deaths <- gsub("^killed by a falling (?!rock).*$", "killed by a falling object", deaths, perl=T)
    
    
        # strip ghost names
        deaths <- gsub(" ghost of .*", " ghost", deaths)
    
    
        # food poisoning
        deaths <- gsub("^poisoned by a rotted .* corpse", "poisoned by a rotted corpse", deaths)
    
    
        # deities
        deaths <- gsub(" wrath of .*", " wrath of a deity", deaths)
    
    
        # priests and priestesses
        deaths <- gsub("priest(ess)?", "priest(ess)", deaths)
    
    
        # shopkeepers
        deaths <- gsub("M[rs]\\. [A-Z].*, the shopkeeper", "a shopkeeper", deaths)
    
    
        # a {monster}'s {item}: tricky because of general regex looking for `'`
        # e.g. Durin's Bane, gas spore's explosion, quit while already on Charon's boat
        # while frozen by a monster's gaze
        # deaths <- gsub("^(\\w+) by (an?|the) .*'s (?!explosion.*)$", "\\1 by a monster's \\2", deaths, perl=T)
        # narrow it down to wands only?
    
    
        # ?? touching (an artifact)?
        deaths <- gsub("killed by touching .*", "killed by touching an artifact", deaths)
        
        
        # ?? minions of deities? "minion of a deity"? "minion of {deity}"? "{minion} of a deity"?
        # the first: 1 death. the second: 39 deaths (#gods). third: #minions deaths.
        deaths <- gsub("(\\w+ elemental|Aleax|couatl|Angel|\\w+ demon|\\w+ devil|(suc|in)cubus|balrog|pit fiend|nalfeshnee|hezrou|vrock|marilitherinyes) of [A-Z].*", "minion of a deity", deaths)
    
    
        # ?? racial priest*s?
    
    
        # return
        deaths
    }

# Appendix: filter unique deaths

The implementation for Junethack 2014, ported to [R](http://www.r-project.org/). Taken from [`normalize_death.rb` on the junethack GitHub repository](https://github.com/junethack/Junethack/blob/master/lib/junethack/normalize_death.rb)

    normalize.deaths <- function(deaths) {
        # sic. the 'killey' is a typo on that site.
        deaths <- gsub('^killey by an ', 'killed by a ', deaths)
        deaths <- gsub(', while .*', '', deaths)
    
    
        deaths <- gsub('hallucinogen-distorted ', '', deaths)
        
        
        deaths <- gsub('by (the )?invisible ', 'by ', deaths)
        deaths <- gsub('by (an|a) invisible ', 'by a ', deaths)
        deaths <- gsub('by invisible ', 'by a ', deaths)
        
        
        deaths <- gsub(' (her|his) ', ' eir ', deaths)
        deaths <- gsub(' (her|him)self ', ' eirself ', deaths)
        deaths <- gsub(' (her|him)self$', ' eirself', deaths)
        
        
        deaths <- gsub(' (called|named) .*', '', deaths)
        
        
        deaths <- gsub(' \\(with the Amulet\\)$', '', deaths)
        
        
        deaths <- gsub('choked on .*', 'choked on something', deaths)
        
        
        deaths <- gsub('killed by kicking .*', 'killed by kicking something', deaths)
        
        
        # deaths <- gsub('^killed by (the|an?) ', 'killed by ', deaths)
        return(deaths)
    }

# Appendix: data

If you're after data for all games from participating players in Junethack, I am making it available in two formats:

- 

all bundled as an [R](http://www.r-project.org/) `RData` file as data.frames (or data.tables, if you care to load that package):

    load('junethack.2014.rda') # tables deaths, users, junethack.users, clans

- 

an archive of CSVs. Comma-separated, string fields quoted (there should not be embedded quotes, but if there are they are escaped), non-values are 'NA' (no quotes).

The RData file is at [https://bitbucket.org/mathematicalcoffee/junethack-analysis/downloads](https://bitbucket.org/mathematicalcoffee/junethack-analysis/downloads/junethack.2014.rda).  
The CSV zipfile is at [https://bitbucket.org/mathematicalcoffee/junethack-analysis/downloads](https://bitbucket.org/mathematicalcoffee/junethack-analysis/downloads/junethack.2014.zip).

There are 4 tables provided. Yes, there is redundancy between the tables because I know nothing about databases and found it useful in writing these posts.

The tables do not include games that Junethack counted as "junk games" (explore, polyinit, debug, or multiplayer games).

(The script used to generate these files is [here](https://bitbucket.org/mathematicalcoffee/junethack-analysis/src/master/package.junethack.data.r); it worked for me but **is not guaranteed to work for you** , and is not really in a release-ready state. Use at your own risk).

### `deaths` table

<caption>Sample from the deaths table (continued below)</caption><colgroup>
<col width="4%">
<col width="3%">
<col width="6%">
<col width="5%">
<col width="6%">
<col width="12%">
<col width="12%">
<col width="6%">
<col width="5%">
<col width="5%">
<col width="6%">
<col width="11%">
<col width="7%">
<col width="4%">
</colgroup><thead>
<tr class="header">
<th align="center">mode</th>
<th align="center">exp</th>
<th align="center">xplevel</th>
<th align="center">align0</th>
<th align="center">gender0</th>
<th align="center">endtime</th>
<th align="center">starttime</th>
<th align="center">carried</th>
<th align="center">event</th>
<th align="center">turns</th>
<th align="center">conduct</th>
<th align="center">death</th>
<th align="center">name</th>
<th align="center">align</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center">Cha</td>
<td align="center">Mal</td>
<td align="center">2014-06-20 09:29:19</td>
<td align="center">2014-06-20 09:24:38</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">1170</td>
<td align="center">3976</td>
<td align="center">killed by a rothe</td>
<td align="center">coffeebug</td>
<td align="center">Cha</td>
</tr>
<tr class="even">
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center">Neu</td>
<td align="center">Mal</td>
<td align="center">2014-06-04 01:22:42</td>
<td align="center">2014-06-04 01:22:39</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">1</td>
<td align="center">4095</td>
<td align="center">quit</td>
<td align="center">DeuceofJune</td>
<td align="center">Neu</td>
</tr>
</tbody>

<caption>Table continues below</caption><colgroup>
<col width="5%">
<col width="4%">
<col width="4%">
<col width="3%">
<col width="7%">
<col width="7%">
<col width="5%">
<col width="5%">
<col width="3%">
<col width="5%">
<col width="7%">
<col width="7%">
<col width="5%">
<col width="6%">
<col width="10%">
<col width="5%">
</colgroup><thead>
<tr class="header">
<th align="center">gender</th>
<th align="center">race</th>
<th align="center">role</th>
<th align="center">uid</th>
<th align="center">birthdate</th>
<th align="center">deathdate</th>
<th align="center">deaths</th>
<th align="center">maxhp</th>
<th align="center">hp</th>
<th align="center">maxlvl</th>
<th align="center">deathlev</th>
<th align="center">deathdnum</th>
<th align="center">points</th>
<th align="center">version</th>
<th align="center">server</th>
<th align="center">variant</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">Mal</td>
<td align="center">Gno</td>
<td align="center">Bar</td>
<td align="center">5</td>
<td align="center">2014-06-20</td>
<td align="center">2014-06-20</td>
<td align="center">1</td>
<td align="center">38</td>
<td align="center">-2</td>
<td align="center">4</td>
<td align="center">4</td>
<td align="center">2</td>
<td align="center">794</td>
<td align="center">0.6.3</td>
<td align="center">sporkhack.com</td>
<td align="center">sporkhack</td>
</tr>
<tr class="even">
<td align="center">Mal</td>
<td align="center">Gno</td>
<td align="center">Wiz</td>
<td align="center">5</td>
<td align="center">2014-06-04</td>
<td align="center">2014-06-04</td>
<td align="center">0</td>
<td align="center">11</td>
<td align="center">11</td>
<td align="center">1</td>
<td align="center">1</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center">3.4.3</td>
<td align="center">nethack.alt.org</td>
<td align="center">vanilla</td>
</tr>
</tbody>

<caption>Table continues below</caption><colgroup>
<col width="6%">
<col width="6%">
<col width="5%">
<col width="8%">
<col width="7%">
<col width="8%">
<col width="7%">
<col width="7%">
<col width="7%">
<col width="6%">
<col width="15%">
<col width="10%">
</colgroup><thead>
<tr class="header">
<th align="center">realtime</th>
<th align="center">achieve</th>
<th align="center">flags</th>
<th align="center">dnetachieve</th>
<th align="center">endtimeus</th>
<th align="center">starttimeus</th>
<th align="center">temporary</th>
<th align="center">intrinsic</th>
<th align="center">extrinsic</th>
<th align="center">charname</th>
<th align="center">unique.death.junethack</th>
<th align="center">unique.death.me</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">280</td>
<td align="center">0</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center">killed by a rothe</td>
<td align="center">killed by a rothe</td>
</tr>
<tr class="even">
<td align="center">2</td>
<td align="center">0</td>
<td align="center">0</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center">quit</td>
<td align="center">quit</td>
</tr>
</tbody>

<colgroup>
<col width="20%">
<col width="20%">
</colgroup><thead>
<tr class="header">
<th align="center">startscummed</th>
<th align="center">clan</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">FALSE</td>
<td align="center">overcaffeinated</td>
</tr>
<tr class="even">
<td align="center">TRUE</td>
<td align="center">Goonsinjune</td>
</tr>
</tbody>

This is essentially the xlogfile for each server, filtered to contain just games by Junethack participants. See the nethackwiki pages for the [Xlogfile](http://nethackwiki.com/wiki/Xlogfile) and [logfile](http://nethackwiki.com/wiki/Logfile) for information on these fields. If the xlogfile for a particular server does not support that value, it is listed as NA.

    Columns of note:
    * `death`: the original death.
    * `starttime`, `endtime`: start and end time of the game. In the CSV formats they are left as-is (seconds since UNIX epoch); in the Rdata file they are POSIXct objects with GMT timezone.
    * `name`: the character's name, but on the nethack4 server it is the name of the nethack4 account and `charname` is the character's name (on nethack4 you can pick your character name freely of your account name).
    
    
    Columns I've added:
    * `server`: the server on which the game was played
    * `variant`: name of the variant
    * `clan`: the clan this user was from (if any)
    * `startscummed`: whether the game is considered startscummed or not (reason for death was escaped/quit and turns less than or equal to 10).
    * `unique.death.junethack`: the death as Junethack counted it.
    * `unique.death.me`: the death with my proposed changes.

### `users` table

<caption>Sample from the users table</caption><colgroup>
<col width="29%">
<col width="20%">
<col width="22%">
<col width="13%">
<col width="9%">
</colgroup><thead>
<tr class="header">
<th align="center">Junethack.Username</th>
<th align="center">Account</th>
<th align="center">Server</th>
<th align="center">Variant</th>
<th align="center">Clan</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">MrSnide</td>
<td align="center">MrSnide</td>
<td align="center">acehack.de</td>
<td align="center">acehack</td>
<td align="center">Justice</td>
</tr>
<tr class="even">
<td align="center">schistosomatic</td>
<td align="center">schistosomatic</td>
<td align="center">nethack.alt.org</td>
<td align="center">vanilla</td>
<td align="center">Justice</td>
</tr>
</tbody>

Information about users on Junethack. Note: when you register for Junethack, you pick an account name for Junethack (say 'coffeebug'). Then, on each server, you may register an account (from the server) to your Junethack username.

For example, I registered 'coffeebug' on NAO and 'coffeebeet' on the dnethack server.

The columns of the users table:

- `Junethack.Username`: your Junethack account name (e.g. 'coffeebug')
- `Account`: the name of the account on a specific server (e.g. 'coffeebeet')
- `Server`: the name of the server that account is on (e.g. 'dnethack.ilbelkyr.de')
- `Variant`: the variant (e.g. 'dnethack'. Note: the acehack.de server has oldhack, vanilla, and acehack variants and you can register an account for each).
- `Clan`: the clan this Junethack user is in (if any).

If you look up all the rows for a particular Junethack.Username, that's just like the table on that user's Junethack page that lists their accounts on each server.

To look up all deaths for a given _account_ on a _server_ (e.g. all of my acehack.de acehack deaths), I'd look for rows in `deaths` where `name` was 'coffeebug' (my `Account` for acehack.de), `server` was 'acehack.de', and `variant` was 'acehack'.

To look up all deaths for my coffeebug _Junethack_ account, I'd take all rows corresponding to `Junethack.Username='coffeebug'` from the users table, and join to `deaths` where the users `(Account, Server, Variant)` matches the `deaths` `(name, server, variant)`.

### `junethack.users` table

<caption>Sample from the junethack.users table</caption><colgroup>
<col width="24%">
<col width="12%">
<col width="9%">
<col width="12%">
<col width="10%">
<col width="11%">
<col width="17%">
</colgroup><thead>
<tr class="header">
<th align="center">Junethack.Username</th>
<th align="center">Accounts</th>
<th align="center">Games</th>
<th align="center">Trophies</th>
<th align="center">Played</th>
<th align="center">Scummed</th>
<th align="center">Clan</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">coffeebeetle</td>
<td align="center">2</td>
<td align="center">567</td>
<td align="center">1</td>
<td align="center">566</td>
<td align="center">1</td>
<td align="center">overcaffeinated</td>
</tr>
<tr class="even">
<td align="center">coffeebug</td>
<td align="center">8</td>
<td align="center">746</td>
<td align="center">19</td>
<td align="center">746</td>
<td align="center">0</td>
<td align="center">overcaffeinated</td>
</tr>
</tbody>

This is essentially the Junethack users table (https://junethack.de/users), with the number of start-scummed games added and the user's clan.

The 'Junethack.Username' column here matches up with the same column from the 'users' table.

### `clans` table

<caption>Sample from the clans table</caption><colgroup>
<col width="17%">
<col width="9%">
<col width="21%">
<col width="32%">
<col width="19%">
</colgroup><thead>
<tr class="header">
<th align="center">Username</th>
<th align="center">Role</th>
<th align="center">User trophies</th>
<th align="center">Last game played (UTC)</th>
<th align="center">Clan</th>
</tr>
</thead><tbody>
<tr class="odd">
<td align="center">coffeebeetle</td>
<td align="center">member</td>
<td align="center">1</td>
<td align="center">2014-06-19 06:38</td>
<td align="center">overcaffeinated</td>
</tr>
<tr class="even">
<td align="center">coffeebug</td>
<td align="center">admin</td>
<td align="center">19</td>
<td align="center">2014-06-30 15:01</td>
<td align="center">overcaffeinated</td>
</tr>
</tbody>

This is just the 'Clan members' table from each clan page, joined together.

The 'Username' column here corresponds to the 'Junethack.Username' column in `users` and `clans`.

* * *

P.S. turns out that although I pronounce "deity" in the way that suggests the correct spelling, I have been spelling it "diety" for years. Hahaha!.

Posted by [mathematical.coffee](http://www.blogger.com/profile/15453196627437456098 "author profile")at [<abbr class="published" title="2014-07-13T19:48:00-07:00">19:48</abbr>](junethack-2014-is-over.html "permanent link") [![](http://img2.blogblog.com/img/icon18_edit_allbkg.gif)](http://www.blogger.com/post-edit.g?blogID=7039473604287682752&postID=477143744066216194&from=pencil "Edit Post")
 [Email This](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=477143744066216194&target=email "Email This") [BlogThis!](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=477143744066216194&target=blog "BlogThis!") [Share to Twitter](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=477143744066216194&target=twitter "Share to Twitter") [Share to Facebook](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=477143744066216194&target=facebook "Share to Facebook") [Share to Pinterest](http://www.blogger.com/share-post.g?blogID=7039473604287682752&postID=477143744066216194&target=pinterest "Share to Pinterest")
<plusone source="blogger:blog:plusone" href="http://mathematicalcoffee.blogspot.com/2014/07/junethack-2014-is-over.html" size="medium" width="300" annotation="inline"></plusone>

Labels: [games](../../search/label/games.html), [junethack](../../search/label/junethack.html), [nethack](../../search/label/nethack.html)

