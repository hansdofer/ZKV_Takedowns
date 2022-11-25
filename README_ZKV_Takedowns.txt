-- ====================================================================================================================
-- Finisher & Takedown Overhaul (ZKV_Takedowns) by Kvalyr for CP2077
-- =========================================================
:: Adds the following features ::
♦ Melee Weapon finishers as stealth takedowns (Configurable, and extensible with new animations from other mods)
♦ Takedowns without grappling first - Initiate grapple OR takedown from stealth (See screenshots)
♦ Mantis Blades finisher: Use aerial takedown animation instead of normal finisher animation, either 50% of the time or all the time (See screenshots)
• • The aerial takedown animation works surprisingly well from a standing position, and arguably looks better and less janky than the normal Mantis Blades finisher.
♦ Fixes a bug in the Mantis Blades aerial takedown added in 1.5 that would leave the victim unconscious instead of dead despite being stabbed through the neck/head.


:: Configuration ::
There's no configuration UI yet. Edit the `config.lua` file to change settings, but be careful and heed the warnings.
A future version will improve on this.


:: Known Issues ::
♦ Weapon in hand during aerial takedowns
• • Not a huge problem. It actually looks better, IMO. You can choose to holster your weapon first, or treat it as a pistol-whip.
♦ Lack of suitable takedown animations for most weapons
• • This mod does not add new animations - It just reuses and repurposes animations already in the game.
• • Some weapons (Knife, Machete, Monowire, etc.) don't have great takedown animations and mostly share a default.
• • There are no good animations for takedowns using knives, etc. - So we use those from other weapons, or keep the weapon in-hand while doing an unarmed takedown.
♦ Minimal playtesting so far
• • I've mostly tested this with Mantis Blades, Katana, Knife and Bare Fists. Other weapons should work fine, but report issues with other weapons if you find them
• • No testing done with perks that enable in-combat grappling or takedown-and-dispose. In theory, these should work exactly as before - As this mod doesn't touch grappling.
♦ Existing CP2077 problems with T-posing, bad ragdolls, un-synced animations, etc.
• • The base game's implementations of Takedowns, Finishers, Ragdolls and synced-animations are flaky already without mods. Don't expect perfection here.


:: Future Plans ::
♦ Configuration UI in-game
♦ More animations (Unlikely, as I'm not an animator - but if another mod adds new takedowns or finishers, this mod will automatically support them)


:: Requirements ::
♦ Cyberpunk 2077 v1.61
♦ Cyber Engine Tweaks (latest version) ( https://www.nexusmods.com/cyberpunk2077/mods/107 )
♦ redscript (latest version) ( https://www.nexusmods.com/cyberpunk2077/mods/1511 )
♦ cybercmd (If using redmod) ( https://www.nexusmods.com/cyberpunk2077/mods/5176 )


:: Installation
♦ Install manually by extracting the bin, archive and r6 folders to your CP2077 main folder. (Drag and drop from the .zip)
♦ Vortex installation is not supported. It might work, it might not. I don't use Vortex myself and can't help you with it.


:: Compatibility & Technical details ::

The following redscript methods are replaced:
♦ TakedownUtils.TakedownActionNameToEnum
♦ TakedownExecuteTakedownEvents.OnEnter
♦ LocomotionTakedownEvents.SelectSyncedAnimationAndExecuteAction
♦ DamageSystem.PlayFinisherGameEffect


The following workspots were modified:
♦ archive\base\gameplay\workspots\takedowns\takedowns_mantisblades\enemy_aerial_takedown_back_mantisblades.workspot
♦ archive\base\gameplay\workspots\takedowns\takedowns_mantisblades\enemy_aerial_takedown_forward_mantisblades.workspot
♦ archive\base\gameplay\workspots\takedowns\takedowns_mantisblades\player_aerial_takedown_back_mantisblades.workspot
♦ archive\base\gameplay\workspots\takedowns\takedowns_mantisblades\player_aerial_takedown_forward_mantisblades.workspot
(The only modification was adding the necessary tags to these workspots to give the player the same invulnerability during this takedown animation as they get during finishers)


Mods that also modify/replace the above functions/files will likely be incompatible with this mod.
Known compatibility risks:
♦ Breach Takedown by Scissors123454321 ( https://www.nexusmods.com/cyberpunk2077/mods/4808 )
• • ZKV_Takedowns and Breach Takedown both modify the `LocomotionTakedownEvents.SelectSyncedAnimationAndExecuteAction` method; but this mod incorporates the same fix to that method and as long as this mod loads last, they might work okay together. No guarantees.
• • I'll make changes for compatibility if necessary in a later version.


::  CREDITS ::
♦ The developers behind Cyber Engine Tweaks & redscript, without which this mod wouldn't be possible whatsoever
♦ The CP2077 modding discord members for answering questions


:: Source Code ::
GitHub link to follow
