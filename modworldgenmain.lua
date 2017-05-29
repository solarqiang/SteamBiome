modimport("scripts/tile_adder.lua")

GLOBAL.require("constants")
local GROUND = GLOBAL.GROUND
GLOBAL.require("map/lockandkey")
GLOBAL.require("map/tasks")
local LOCKS = GLOBAL.LOCKS
local KEYS = GLOBAL.KEYS
local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")
local SIZE_VARIATION = 3


GLOBAL.require("map/terrain")

GLOBAL.terrain.rooms.BGRocky.contents.distributeprefabs.stonehand = 0.5
GLOBAL.terrain.rooms.BGChessRocky.contents.distributeprefabs.stonehand = 0.5
GLOBAL.terrain.rooms.Rocky.contents.distributeprefabs.stonehand = 0.5
GLOBAL.terrain.rooms.RockLobsterPlains.contents.distributeprefabs.stonehand = .05
GLOBAL.terrain.rooms.BatCaveRoomAntichamber.contents.distributeprefabs.stonehand = .05
GLOBAL.terrain.filter.stonehand = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.MARSH}



AddTile("TECH", 84, "tech", {noise_texture = "levels/textures/noise_tech.tex",    runsound="dontstarve/movement/run_marble",		walksound="dontstarve/movement/walk_marble",	snowsound="dontstarve/movement/run_ice", mudsound = "dontstarve/movement/run_mud"}, {noise_texture = "levels/textures/mini_noise_tech.tex"})
AddTile("WHITEFLOOR", 86, "whitefloor", {noise_texture = "levels/textures/noise_whitefloor.tex",     runsound="dontstarve/movement/run_marble",		walksound="dontstarve/movement/walk_marble",	snowsound="dontstarve/movement/run_ice", mudsound = "dontstarve/movement/run_mud"}, {noise_texture = "levels/textures/mini_noise_whitefloor.tex"})

Layouts["Ancient1"] = StaticLayout.Get("map/static_layouts/ancient1")
Layouts["Ancient2"] = StaticLayout.Get("map/static_layouts/ancient2")
Layouts["Ancient3"] = StaticLayout.Get("map/static_layouts/ancient3")
Layouts["Ancient4"] = StaticLayout.Get("map/static_layouts/ancient4")
Layouts["Ancient5"] = StaticLayout.Get("map/static_layouts/ancient5")
Layouts["Foodgen"] = StaticLayout.Get("map/static_layouts/foodgen")
--Layouts["Orangecrystal"] = StaticLayout.Get("map/static_layouts/orangecrystal")
--Layouts["Yellowcrystal"] = StaticLayout.Get("map/static_layouts/yellowcrystal")
--Layouts["Greencrystal"] = StaticLayout.Get("map/static_layouts/greencrystal")
Layouts["Forcechest"] = StaticLayout.Get("map/static_layouts/forcechest")
Layouts["Redcrystal"] = StaticLayout.Get("map/static_layouts/redcrystal")
Layouts["Bluecrystal"] = StaticLayout.Get("map/static_layouts/bluecrystal")
Layouts["Mechacircle"] = StaticLayout.Get("map/static_layouts/mechacircle")


AddRoom("TechEntrance", {
    colour={r=0.2,g=0.0,b=0.2,a=0.3},
    value = GLOBAL.GROUND.MUD,
    tags = {"ForceConnected",   "MazeEntrance"},--"Maze",
    contents =  {
        distributepercent = 0.1,
        distributeprefabs= 
        {
            --Pawn = .2,
            --Pawnb = .2,
            mechabat = .1,
            mechamine = .2,
        },
    }
})

AddRoom("Tesla_forest", {
    colour={r=4,g=3,b=0.2,a=1.3},
    value =  GLOBAL.GROUND.TECH,
    contents =  {

        distributepercent = .2,
        distributeprefabs=
        {
            tesla = .2,
            tesla1 = .2,
            tesla2 = .2,
            tesla3 = .2,
            --chessjunk1 = .02,
            --chessjunk2 = .02,
            --chessjunk3 = .02,
            --pawn = .03,
            --pawnb = .03,
            knight = .02,
            rook = .01,
            bishop = .02,
            mechabat = .02,
            ancient2 = .02,
        },
    }
})


AddRoom("Technicroom", {
    colour={r=4,g=3,b=0.2,a=1.3},
    value =  GLOBAL.GROUND.TECH,
    contents =  {
        countstaticlayouts = 
        {
            ["Ancient1"] = 2,
            ["Ancient2"] = 2,
            ["Ancient3"] = 3,
            ["Foodgen"] = 4,
        },
        distributepercent = .05,
        distributeprefabs=
        {
            knight = .1,
            mechabat = .1,
            bishop = .1,
            mechamine = .03,
            ancient4 = .05,
            --chessjunk2 = .01,
            --chessjunk3 = .01,
        },
    }
})


AddRoom("Laboratory", {
    colour={r=4,g=3,b=0.2,a=1.3},
    value =  GLOBAL.GROUND.WHITEFLOOR,
    contents =  {
        countstaticlayouts = 
        {	
            ["Mechacircle"] = 1,
            ["Ancient4"] = 3,
            ["Ancient5"] = 1,
            ["Ancient3"] = 3,
            --			["Orangecrystal"] = 1,
            --			["Yellowcrystal"] = 1,
            --			["Greencrystal"] = 1,
        },
        distributepercent = .06,
        distributeprefabs=
        {
            mechatentacle = .9,
            ancient4 = .02,
            pawn = .1,
            ancient5 = .3,
            --rook = .1,
            --bishop = .2,
        },
    }
})


AddRoom("Treasureroom", {
    colour={r=4,g=3,b=0.2,a=1.3},
    value =  GLOBAL.GROUND.WHITEFLOOR,
    contents =  {
        countstaticlayouts = 
        {

            ["Forcechest"] = 1,

        },
        distributepercent = .01,
        distributeprefabs=
        {				           
            mechabat = .01,
        },
    }
})	


AddTask("Tech_powers", {
    locks={LOCKS.RUINS},
    keys_given=KEYS.NONE,
    entrance_room = "TechEntrance",
    room_choices={
        ["Technicroom"] = 1 + math.random(1,2),
        ["Tesla_forest"] = 3 + math.random(1,2),  
        ["Laboratory"] = 2 + math.random(1,2), 
        ["Treasureroom"] = 1, 
    }, 
    room_bg=GROUND.MUD,
    background_room="BGWilds",
    colour={r=1,g=0,b=0.6,a=1},
}) 


GLOBAL.require("map/level")
local LEVELTYPE = GLOBAL.LEVELTYPE

local function AddTaskTech(level)
    table.insert(level.tasks, "Tech_powers")
end

AddLevelPreInit("CAVE_LEVEL_2", AddTaskTech)


if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 

    GLOBAL.terrain.rooms.Magma.contents.distributeprefabs.stonehand = .075
    GLOBAL.terrain.rooms.Magma.contents.distributeprefabs.magmarock_copper = .75
    GLOBAL.terrain.rooms.MagmaVolcano.contents.distributeprefabs.stonehand = 1.25
    GLOBAL.terrain.rooms.MagmaVolcano.contents.distributeprefabs.magmarock_copper = 1
    GLOBAL.terrain.rooms.GenericMagmaNoThreat.contents.distributeprefabs.stonehand = .125
    GLOBAL.terrain.rooms.GenericMagmaNoThreat.contents.distributeprefabs.magmarock_copper = .5
    GLOBAL.terrain.rooms.MagmaSpiders.contents.distributeprefabs.magmarock_copper = .75
    GLOBAL.terrain.rooms.MagmaTallBird.contents.distributeprefabs.magmarock_copper = .45

    AddRoom("MagmaCopper", {
        colour={r=.55,g=.75,b=.75,a=.50},
        value = GROUND.MAGMAFIELD, 
        contents =  {
            distributepercent = .3,
            distributeprefabs =
            {
                magmarock = 0.8,
                magmarock_copper = 1.2, --gold
                rock1 = 0.15,
                stonehand = 0.3,
                rock_flintless = .8,
                rocks = 1,
                flint = .5,
                nitre = .35,
                coppernugget = .25,
                tallbirdnest= .2,
                sapling = .5,
                spiderden=.1,
            },
        }
    })
    AddRoom("MagmaCopperBoon", {
        colour={r=.55,g=.75,b=.75,a=.50},
        value = GROUND.MAGMAFIELD, 
        contents =  {
            distributepercent = .25,
            distributeprefabs =
            {
                magmarock_copper = 1,
                rock1 = 0.5,
                stonehand = 0.3,
                rocks = 3,
                flint = 1,
                nitre = .75,
                coppernugget = 1,
                tallbirdnest= .2,
                sapling = .5,
                spiderden=.1,
            },
        }
    })

    AddTask("IslandRockyCopper", {  
            locks=LOCKS.ISLAND3,
            keys_given={KEYS.ISLAND4},
            crosslink_factor=math.random(0,1),
            make_loop=math.random(0, 100) < 50,
            room_choices={
                ["MagmaCopperBoon"] = 1,
                ["MagmaCopper"] = 1,
                ["BeachSandHome"] = 1,
            }, 
            room_bg=GROUND.BEACH ,
            --background_room={"BeachSand", "BeachUnkept"},
            colour={r=1,g=1,b=0,a=1}
        })

    local function AddTaskSWCopper(level)
        table.insert(level.selectedtasks[5].task_choices, "IslandRockyCopper")
    end

    AddLevelPreInit("SHIPWRECKED_DEFAULT", AddTaskSWCopper)

end

