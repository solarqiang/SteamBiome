PrefabFiles = {
	"bar",
	"foodgen",
	"tesla",
	"tesla1",
	"tesla2",
	"tesla3",
	"ancient1",
	"ancient2",
	"ancient3",
	"ancient4",
	"ancient5",
	"pawn",
	"pawnb",
	"coppernugget",
	"metal",
	"teslarod",
	"metalarmor",
	"schest",
	"greenfieldfx",
	"mechatentacle",
	"stonehand",
	"mechabat",
	"forcefieldn",
    "magmarock_copper",
	"mechasword",
	"mechagun",
	"mechamine",
	"mechalance",
}

-- Map Icon -------------------------------------------------
local assets=
{

	Asset("ATLAS", "images/inventoryimages/foodgen_map.xml"),
    Asset("IMAGE", "images/inventoryimages/foodgen_map.tex"),
	Asset("ATLAS", "images/inventoryimages/tesla_map.xml"),
    Asset("IMAGE", "images/inventoryimages/tesla_map.tex"),
	Asset("ATLAS", "images/inventoryimages/ancient1_map.xml"),
    Asset("IMAGE", "images/inventoryimages/ancient1_map.tex"),
	Asset("ATLAS", "images/inventoryimages/ancient2_map.xml"),
    Asset("IMAGE", "images/inventoryimages/ancient2_map.tex"),
	Asset("ATLAS", "images/inventoryimages/ancient3_map.xml"),
    Asset("IMAGE", "images/inventoryimages/ancient3_map.tex"),
	Asset("ATLAS", "images/inventoryimages/ancient4_map.xml"),
    Asset("IMAGE", "images/inventoryimages/ancient4_map.tex"),
	Asset("ATLAS", "images/inventoryimages/mechamine.xml"),
    Asset("IMAGE", "images/inventoryimages/mechamine.tex"),
	
---------------------------------------------------------------
-- Tile textures --------------------------------------------------
	Asset( "IMAGE", "levels/textures/noise_tech.tex" ),
	Asset( "IMAGE", "levels/textures/mini_noise_tech.tex" ),
	Asset( "IMAGE", "levels/tiles/tech.tex" ),
	Asset( "FILE", "levels/tiles/tech.xml" ),
	
	Asset( "IMAGE", "levels/textures/noise_whitefloor.tex" ),
	Asset( "IMAGE", "levels/textures/mini_noise_whitefloor.tex" ),
	Asset( "IMAGE", "levels/tiles/whitefloor.tex" ),
	Asset( "FILE", "levels/tiles/whitefloor.xml" ),

----------------------------------------------------------------
}

--GLOBAL.STRINGS.NAMES.TURF_TEST = "Test Turf"


AddMinimapAtlas("images/inventoryimages/foodgen_map.xml")
AddMinimapAtlas("images/inventoryimages/tesla_map.xml")
AddMinimapAtlas("images/inventoryimages/ancient1_map.xml")
AddMinimapAtlas("images/inventoryimages/ancient2_map.xml")
AddMinimapAtlas("images/inventoryimages/ancient3_map.xml")
AddMinimapAtlas("images/inventoryimages/ancient4_map.xml")
AddMinimapAtlas("images/inventoryimages/mechamine.xml")
