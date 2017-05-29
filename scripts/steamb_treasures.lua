local steamb_treasure =
{
    ["MechaBattle"] = 
    {
        {
            treasure_set_piece = "BuriedTreasureLayout",
            treasure_prefab = "buriedtreasure",
            map_prefab = "messagebottle",
            loot = "mecha_battlesuit",
        }
    }
}

local steamb_loot =
{
    ["mecha_battlesuit"] =
    {
        loot =
        {
            mechagun = 1,
            mechasword = 1,
            forcefieldn = 1,
            transistor = 2,
        },

        random_loot =
        {
            redgem = 1,
            bluegem = 1,
            papyrus = 1,
            tunacan = 1,
            blueprint = 1,
            coppernugget = 1,
            gears = 1,
            purplegem = 1,
            rope =1,
            metal =1,
        },

        chance_loot =
        {
            gears = 2,
            transistor = 1,
            coppernugget = 1,
            metal = 1,
        }
    }
}

for name, data in pairs(steamb_treasure) do
    AddTreasure(name, data)
end

for name, data in pairs(steamb_loot) do
    AddTreasureLoot(name, data)
end
