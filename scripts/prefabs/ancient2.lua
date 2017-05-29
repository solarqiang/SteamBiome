local assets=
{
	Asset("ANIM", "anim/ancient2.zip"),
	Asset("ATLAS", "images/inventoryimages/ancient2_map.xml"),
    Asset("IMAGE", "images/inventoryimages/ancient2_map.tex"),
	Asset("SOUND", "sound/common.fsb"),

}

local prefabs = 

{
	"metal",
	"teslarod",
	"trinket_11",
	"thulecite", 

}

SetSharedLootTable( 'ancientloot2',
{
	{'metal',  0.7},
	{"teslarod", 0.6},
	{"trinket_11", 0.5},	
	{"trinket_5", 0.5},
	{"trinket_5", 0.5},
	{'thulecite',  0.3},
	
})

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("idle")
	--inst.AnimState:PushAnimation("idle")
end


local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "ancient2_map.tex" )
    
    inst:AddTag("structure")
   MakeObstaclePhysics(inst, .5)
    
    inst.AnimState:SetBank("ancient2")
    inst.AnimState:SetBuild("ancient2")
	inst.AnimState:PlayAnimation("idle")
		
    inst:AddComponent("inspectable")
	
	
	inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('ancientloot2')
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 
	
	
    return inst
end


STRINGS.NAMES.ANCIENT2 = "Pipes"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANCIENT2 = {	
	"Must be plenty of them under the floor.",
	 
}

STRINGS.CHARACTERS.WX78.DESCRIBE.ANCIENT2 = {	
	"PART OF THE SYSTEM.",
	 
}

return Prefab( "common/ancient2", fn, assets, prefabs)