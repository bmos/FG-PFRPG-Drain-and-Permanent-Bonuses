# PFRPG Drain and Permanent Bonuses
One shortcoming of Fantasy Grounds' Pathfinder implementation is that  permanent bonuses need to be tracked by modifying the ability score on  the character sheet's main tab. This is very risky, as it's easy to lose  track of everything that is included or even what the base score is (everyone makes mistakes after all and sometimes we have an item  equipped for months of real time). Mitigating this has often  necessitated some method of logging changes, often on the Notes tab. The situation regarding ability drain is very similar. It cannot be  tracked in the program without the same approach of changing the base  ability score, which is sub-optimal for the reasons stated above.

Many people respond to this by using effects, but these use the rules for temporary bonuses (which impose penalties on most uses of the score for every two points of drain rather than changing the base score  itself), which means that oddly-numbered base scores display improper behavior. The same is true of the ability drain if entered in the ability dmg fields, although it is further compounded by the nature of ability damage healing itself a little with each long rest (which is not the proper behavior for ability drain).

Enter this extension.<br>
Now the Abilities section of the character sheet's main tab contains sub-menus for tracking permanent bonuses and ability drain with individual labels. Bonuses with the same type selected will not stack (the highest of each type of bonus will be used). Bonus types for negative numbers are ignored.

NOTE: As with the FG stock implementation, permanent bonuses and temporary bonuses need to be manually vetted for stacking. This means that an effect with a +2 enhancement bonus to CON will also stack with +2 Perm bonus to CON unless you adjust the effect accordingly.

# Compatibility
This extension has been tested with [FantasyGrounds Unity](https://www.fantasygrounds.com/home/FantasyGroundsUnity.php) 4.0.10 (2021-02-04).

# Video Demonstration (click for video)
[<img src="https://i.ytimg.com/vi_webp/TVdIZTwUvF8/hqdefault.webp">](https://youtu.be/TVdIZTwUvF8)
