# BetterNightVision
> Code for BetterNightVision DST Mod

### Code given by Community in Steam Workshop comments


> From Tony `modmain.lua` - Can be found in the mod's comments

`6` `local function InGame()`

`7` `return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()`

`8` `end`

`12` `if not InGame() then return end`

> From Fuzzy Waffle `modmain.lua` - Can be found in the mod's Discusions "Bugs / Crashs"

`13` `if GLOBAL.ThePlayer == nil then return else`
