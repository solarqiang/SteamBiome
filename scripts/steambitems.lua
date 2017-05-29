local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

local alchemy_metal = (GetModConfigData("Alchemy Recipe")=="metal")
local alchemy_original = (GetModConfigData("Alchemy Recipe")=="original")

local fire_metal = (GetModConfigData("Fire Recipe")=="metal")
local fire_original = (GetModConfigData("Fire Recipe")=="original")

local ice_metal = (GetModConfigData("Ice Recipe")=="metal")
local ice_original = (GetModConfigData("Ice Recipe")=="original")
local ice_magic = (GetModConfigData("Ice Recipe")=="magic")
local ice_both = (GetModConfigData("Ice Recipe")=="both")


--Drop Loot Metal from Bishop
local function AddBishopLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',1.0)
end

AddPrefabPostInit("bishop", AddBishopLoot)

--Drop Loot Metal from Bishop Nightmare
local function AddBishopnLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',0.8)
end

AddPrefabPostInit("bishop_nightmare", AddBishopnLoot)

--Drop Loot Metal from Knight
local function AddKnightLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',1.0)
end

AddPrefabPostInit("knight", AddKnightLoot)

--Drop Loot Metal from Knight Nightmare
local function AddKnightnLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',0.8)
end

AddPrefabPostInit("knight_nightmare", AddKnightnLoot)

--Drop Loot Metal from Rook
local function AddRookLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',1.0)
end

AddPrefabPostInit("rook", AddRookLoot)

--Drop Loot Metal from Rook Nightmare
local function AddRooknLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('metal',0.8)
end

AddPrefabPostInit("rook_nightmare", AddRooknLoot)


--Drop Loot Copper from Flintless
local function AddCopperLoot(prefab)
    prefab.components.lootdropper:AddChanceLoot('coppernugget',1.0)
    prefab.components.lootdropper:AddChanceLoot('coppernugget',0.5)
end

AddPrefabPostInit("rock_flintless", AddCopperLoot)

local function oncharge(inst, target, doer)
    if doer.SoundEmitter then
        doer.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_addpart")
        doer.SoundEmitter:PlaySound("dontstarve/HUD/repair_clothing")
    end
end


local function MakeCharger(inst)
    inst:AddComponent("charger")
    inst.components.charger.chargefuel = "RECHARGER"
    inst.components.charger.oncharge = oncharge
end
AddPrefabPostInit("transistor", MakeCharger)


--Transmutable Gold Nugget
--[[local function AddGoldTrans(inst)
inst:AddComponent("extractable")
inst.components.extractable.product = "coppernugget"
end

AddPrefabPostInit("goldnugget", AddGoldTrans)]]

local metal2 = Ingredient("metal", 2)
metal2.atlas = "images/inventoryimages/metal.xml"

local metal4 = Ingredient("metal", 4)
metal4.atlas = "images/inventoryimages/metal.xml"

local metal5 = Ingredient("metal", 5)
metal5.atlas = "images/inventoryimages/metal.xml"

local metal6 = Ingredient("metal", 6)
metal6.atlas = "images/inventoryimages/metal.xml"

local teslaing = Ingredient("teslarod", 1)
teslaing.atlas = "images/inventoryimages/teslarod.xml"

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then

--Drop Loot Metal from Floaty Boaty Knight
    local function AddKnightboatLoot(prefab)
        prefab.components.lootdropper:AddChanceLoot('metal',1.0)
    end
    AddPrefabPostInit("knightboat", AddKnightboatLoot)

    --Gear Sword recipe
    local crafting_recipe8 = Recipe("mechasword", {metal4 ,Ingredient("gears", 2),Ingredient("pigskin",1)}, RECIPETABS.WAR, {SCIENCE=2}, GLOBAL.RECIPE_GAME_TYPE.COMMON)
    crafting_recipe8.atlas = "images/inventoryimages/mechasword.xml"

    --Gear Gun recipe
    local crafting_recipe9 = Recipe("mechagun", {metal5 ,Ingredient("trinket_6", 1), teslaing}, RECIPETABS.WAR, {SCIENCE=2}, GLOBAL.RECIPE_GAME_TYPE.VANILLA)
    crafting_recipe9.atlas = "images/inventoryimages/mechagun.xml"

else
    --Gear Sword recipe

    local crafting_recipe8 = Recipe("mechasword", {metal4 ,Ingredient("gears", 2),Ingredient("pigskin",1)}, RECIPETABS.WAR, {SCIENCE=2})
    crafting_recipe8.atlas = "images/inventoryimages/mechasword.xml"

    --Gear Gun recipe

    local crafting_recipe9 = Recipe("mechagun", {metal5 ,Ingredient("trinket_6", 1), teslaing}, RECIPETABS.WAR, {SCIENCE=2})
    crafting_recipe9.atlas = "images/inventoryimages/mechagun.xml"

end
--Change Science Machine recipe

-- local crafting_recipe1 = Recipe("researchlab", {Ingredient("goldnugget", 2),Ingredient("log", 4),Ingredient("rocks",4)}, RECIPETABS.SCIENCE, TECH.NONE, "researchlab_placer")
if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 
    --Change Alchemy Engine recipe
    if alchemy_metal then
        local crafting_recipe2 = Recipe("researchlab2", {Ingredient("boards", 4), metal6, Ingredient("goldnugget", 3)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "researchlab2_placer")
    end

    --Change Fire Suppresor recipe
    if fire_metal then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe3 = Recipe("firesuppressor", {metal6, Ingredient("ice", 15), Ingredient("transistor", 2)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"firesuppressor_placer")
        end
    end

    --Change Icebox recipe
    if ice_metal then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe4 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("ice", 8)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"icebox_placer", 1.5)
        else
            local crafting_recipe3 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"icebox_placer", 1.5)
        end
    end

    if ice_magic then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("cutstone", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"icebox_placer", 1.5)
        else
            local crafting_recipe3 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"icebox_placer", 1.5)
        end
    end

    if ice_both then
        local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), metal4}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON,"icebox_placer", 1.5)
    end

else
    --Change Alchemy Engine recipe
    if alchemy_metal then
        local crafting_recipe2 = Recipe("researchlab2", {Ingredient("boards", 4), metal6, Ingredient("goldnugget", 3)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_ONE, "researchlab2_placer")
    end

    --Change Fire Suppresor recipe
    if fire_metal then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe3 = Recipe("firesuppressor", {metal6, Ingredient("ice", 15), Ingredient("transistor", 2)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_TWO, "firesuppressor_placer")
        end
    end

    --Change Icebox recipe
    if ice_metal then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe4 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("ice", 8)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
        else
            local crafting_recipe3 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
        end
    end

    if ice_magic then
        if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
            local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("cutstone", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
        else
            local crafting_recipe3 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
        end
    end

    if ice_both then
        local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), metal4}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    end
end
--Change Alchemy Engine recipe
if alchemy_metal then
    local crafting_recipe2 = Recipe("researchlab2", {Ingredient("boards", 4), metal6, Ingredient("goldnugget", 3)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_ONE, "researchlab2_placer")
end

--Change Fire Suppresor recipe
if fire_metal then
    if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
        local crafting_recipe3 = Recipe("firesuppressor", {metal6, Ingredient("ice", 15), Ingredient("transistor", 2)}, RECIPETABS.SCIENCE,  TECH.SCIENCE_TWO, "firesuppressor_placer")
    end
end

--Change Icebox recipe
if ice_metal then
    if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
        local crafting_recipe4 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("ice", 8)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    else
        local crafting_recipe3 = Recipe("icebox", {metal4, Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    end
end

if ice_magic then
    if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
        local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("cutstone", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    else
        local crafting_recipe3 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), Ingredient("boards", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    end

    if ice_both then
        local crafting_recipe4 = Recipe("icebox", {Ingredient("bluegem", 1), Ingredient("gears", 1), metal4}, RECIPETABS.FARM,  TECH.SCIENCE_TWO, "icebox_placer", 1.5)
    end

end

--Change Thulecite Crown recipe

-- local crafting_recipe5 = Recipe("ruinshat", {Ingredient("thulecite", 4), Ingredient("nightmarefuel", 4), Ingredient("redgem", 1)}, RECIPETABS.ANCIENT, TECH.ANCIENT_FOUR, nil, nil, true)

for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Steampunk" then 

        local marmor = Ingredient("metalarmor", 1)
        marmor.atlas = "images/inventoryimages/metalarmor.xml"


        if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then

            --Gear Sword recipe
            local crafting_recipe8 = Recipe("mechasword", {metal4 ,Ingredient("gears", 2),Ingredient("pigskin",1)}, RECIPETABS.GEAR_TAB, {SCIENCE=2}, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            crafting_recipe8.atlas = "images/inventoryimages/mechasword.xml"

            --Gear Gun recipe
            local crafting_recipe9 = Recipe("mechagun", {metal5 ,Ingredient("trinket_6", 1), teslaing}, RECIPETABS.GEAR_TAB, {SCIENCE=2}, GLOBAL.RECIPE_GAME_TYPE.VANILLA)
            crafting_recipe9.atlas = "images/inventoryimages/mechagun.xml"

            --Change Steampunk recipes

            local gear_torchrecipe0 = Recipe( "gear_torch", { Ingredient("lightbulb", 1),Ingredient("gears", 1),metal2 }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.VANILLA)
            gear_torchrecipe0.atlas = "images/inventoryimages/gear_torch.xml"

            -- local gear_torchrecipe2 = Recipe( "gear_torch", { Ingredient("bioluminescence", 1),Ingredient("gears", 1),metal2 }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_ONE, GLOBAL.RECIPE_GAME_TYPE.SHIPWRECKED)
            -- gear_torchrecipe2.atlas = "images/inventoryimages/gear_torch.xml"

            local gear_helmetrecipe = Recipe( "gear_helmet", { Ingredient("beehat", 1),Ingredient("gears", 3),metal4}, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            gear_helmetrecipe.atlas = "images/inventoryimages/gear_helmet.xml"


            local gear_armorrecipe = Recipe( "gear_armor", { marmor,Ingredient("gears", 4),Ingredient("charcoal", 5) }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            gear_armorrecipe.atlas = "images/inventoryimages/gear_armor.xml"

            local sentinelerecipe = Recipe( "sentinel", { Ingredient("gears", 1),metal2,Ingredient("flint", 4) }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            sentinelerecipe.atlas = "images/inventoryimages/sentinel.xml"

            local ws_03recipe = Recipe( "ws_03", { Ingredient("spiderhat",1), Ingredient("gears", 6),metal6 }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON)
            ws_03recipe.atlas = "images/inventoryimages/ws_03.xml"

        else

            --Gear Sword recipe
            local crafting_recipe8 = Recipe("mechasword", {metal4 ,Ingredient("gears", 2),Ingredient("pigskin",1)}, RECIPETABS.GEAR_TAB, {SCIENCE=2})
            crafting_recipe8.atlas = "images/inventoryimages/mechasword.xml"

            --Gear Gun recipe

            local crafting_recipe9 = Recipe("mechagun", {metal5 ,Ingredient("trinket_6", 1), teslaing}, RECIPETABS.GEAR_TAB, {SCIENCE=2})
            crafting_recipe9.atlas = "images/inventoryimages/mechagun.xml"

            --Change Steampunk recipes

            local gear_torchrecipe = Recipe( "gear_torch", { Ingredient("lightbulb", 1),Ingredient("gears", 1),metal2 }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_ONE)
            gear_torchrecipe.atlas = "images/inventoryimages/gear_torch.xml"

            local gear_helmetrecipe = Recipe( "gear_helmet", { Ingredient("beehat", 1),Ingredient("gears", 3),metal4}, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO)
            gear_helmetrecipe.atlas = "images/inventoryimages/gear_helmet.xml"


            local gear_armorrecipe = Recipe( "gear_armor", { marmor,Ingredient("gears", 4),Ingredient("charcoal", 5) }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO)
            gear_armorrecipe.atlas = "images/inventoryimages/gear_armor.xml"

            local sentinelerecipe = Recipe( "sentinel", { Ingredient("gears", 1),metal2,Ingredient("flint", 4) }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO)
            sentinelerecipe.atlas = "images/inventoryimages/sentinel.xml"

            local ws_03recipe = Recipe( "ws_03", { Ingredient("spiderhat",1), Ingredient("gears", 6),metal6 }, RECIPETABS.GEAR_TAB, TECH.SCIENCE_TWO)
            ws_03recipe.atlas = "images/inventoryimages/ws_03.xml"

        end
    end
end
