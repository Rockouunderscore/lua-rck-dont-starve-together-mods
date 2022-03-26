local a = (GetModConfigData("sound")=="0")
local b = (GetModConfigData("sound")=="1")
local c = (GetModConfigData("sound")=="2")
local d = (GetModConfigData("sound")=="3")
--local e = (GetModConfigData("sound")=="4")
--local f = (GetModConfigData("sound")=="5")
--local g = (GetModConfigData("sound")=="6")
--local h = (GetModConfigData("sound")=="7")
--local i = (GetModConfigData("sound")=="8")
--local j = (GetModConfigData("sound")=="9")

Assets = {
    Asset("SOUNDPACKAGE", "sound/circus.fev"),
    Asset("SOUND", "sound/circus.fsb"),
    Asset("SOUNDPACKAGE", "sound/fnree.fev"),
    Asset("SOUND", "sound/fnree.fsb"),
    Asset("SOUNDPACKAGE", "sound/REE.fev"),
    Asset("SOUND", "sound/REE.fsb"),
    Asset("SOUNDPACKAGE", "sound/airhorn.fev"),
    Asset("SOUND", "sound/airhorn.fsb")
}

if a then
    RemapSoundEvent("dontstarve/common/horn_beefalo", "fnree/fnree/fnree")
end

if b then
    RemapSoundEvent("dontstarve/common/horn_beefalo", "REE/REE/REE")
end

if c then
    RemapSoundEvent("dontstarve/common/horn_beefalo", "airhorn/AHMLG/airhorn")
end

if d then
    RemapSoundEvent("dontstarve/common/horn_beefalo", "circus/circus/circus")
end




--manual changes
--Fucking normies REE	"fnree/fnree/fnree"
--REE	"REE/REE/REE"
--MLG Air horn	"airhorn/AHMLG/airhorn"
--circus song "circus/circus/circus"