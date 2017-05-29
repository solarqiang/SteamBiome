local assets=
{
	Asset("ANIM", "anim/tesla.zip"),
	Asset("ATLAS", "images/inventoryimages/tesla_map.xml"),
    Asset("IMAGE", "images/inventoryimages/tesla_map.tex"),
	--Asset("SOUNDPACKAGE", "sound/tesla.fev"),
	--Asset("SOUND", "sound/tesla.fsb"),
}

local prefabs =
{
    "log",
    "twigs",
    "charcoal",
	"teslarod",
}

SetSharedLootTable( 'tesla_tree1',
{
    {'twigs',  1.0},
    {'log',    1.0},
	{'log',    1.0},
	{'log',    1.0},
	{'teslarod',    0.1},
})

SetSharedLootTable( 'tesla_burnt',
{
    {'charcoal',  1.0},
    {'charcoal',    1.0},
})

local function chop_tree(inst, chopper, chops)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")          
    inst.AnimState:PlayAnimation("chop")
	inst.AnimState:PushAnimation("idle2", true)
	
	--[[if chopper.components.combat then
        chopper.components.combat:GetAttacked(inst, TUNING.MARSHBUSH_DAMAGE)
        chopper:PushEvent("thorns")
	end]]
	
end

local function set_stump(inst)
    inst:RemoveComponent("workable")
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
	-- inst:RemoveComponent("prototyper")
	inst.SoundEmitter:KillSound("idlesound")
	inst.Light:Enable(false)
    RemovePhysicsColliders(inst)
    inst:AddTag("stump")
end

local function dig_up_stump(inst, chopper)
	inst:Remove()
	inst.components.lootdropper:SpawnLootPrefab("log")
end


local function chop_down_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")          
    inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")
    inst.AnimState:PlayAnimation("fall_down2")
	inst.AnimState:PushAnimation("stump", false)
    set_stump(inst)
    inst.components.lootdropper:DropLoot()
    
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up_stump)
    inst.components.workable:SetWorkLeft(1)
end

local function chop_down_burnt_tree(inst, chopper)
    inst.SoundEmitter:PlaySound("dontstarve/forest/treeCrumble")          
    inst.SoundEmitter:PlaySound("dontstarve/wilson/use_axe_tree")          
	inst.AnimState:PlayAnimation("burnt_fall")
    set_stump(inst)
    inst.Physics:ClearCollisionMask()
	inst:ListenForEvent("animover", function() inst:Remove() end)
    inst.components.lootdropper:DropLoot()
end


local function OnBurnt(inst)
    inst:RemoveComponent("burnable")
    inst:RemoveComponent("propagator")
	-- inst:RemoveComponent("prototyper")
	inst.SoundEmitter:KillSound("idlesound")
	inst.Light:Enable(false)
    
    inst.components.lootdropper:SetChanceLootTable('tesla_burnt')
    
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(nil)
    inst.components.workable:SetOnFinishCallback(chop_down_burnt_tree)
    inst.AnimState:PlayAnimation("burnt_idle", true)
    inst:AddTag("burnt")
end

local function tree_burnt(inst)
    OnBurnt(inst)
end

local function inspect_tree(inst)
    if inst:HasTag("burnt") then
       	STRINGS.CHARACTERS.GENERIC.DESCRIBE.TESLA1 = {	
			"View isn't quite as electrifying...",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.TESLA1 = {	
		"BURNED.",

		}
    elseif inst:HasTag("stump") then
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.TESLA1 = {	
			"It is easy to destroy, more difficult to create.",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.TESLA1 = {	
		"ERROR: SOURCE MISSING.",

		}
		
    elseif inst.components.burnable and inst.components.burnable:IsBurning() then
       STRINGS.CHARACTERS.GENERIC.DESCRIBE.TESLA1 = {	
		"That's burning fast!",
		"Burn baby burn!",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.TESLA1 = {	
		"SOURCE WASTED.",

		}
	else
       STRINGS.CHARACTERS.GENERIC.DESCRIBE.TESLA1 = {	
		"I think it's damaged...",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.TESLA1 = {	
		"DAMAGED SOURCE.",

		}
    end
end

	-- local function onturnon(inst)
	-- 	inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_lvl2_idle_LP","idlesound")
	-- end

	-- local function onturnoff(inst)
	-- 	inst.SoundEmitter:KillSound("idlesound")
	-- end

local function onsave(inst, data)
    if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
    if inst:HasTag("stump") then
        data.stump = true
    end
end
        
local function onload(inst, data)
    if data then
        if data.burnt then
            OnBurnt(inst)
        elseif data.stump then
            inst:RemoveComponent("workable")
            inst:RemoveComponent("burnable")
            inst:RemoveComponent("propagator")
            inst:RemoveComponent("growable")
            RemovePhysicsColliders(inst)
            inst.AnimState:PlayAnimation("stump", false)
            inst:AddTag("stump")
            
            inst:AddComponent("workable")
            inst.components.workable:SetWorkAction(ACTIONS.DIG)
            inst.components.workable:SetOnFinishCallback(dig_up_stump)
            inst.components.workable:SetWorkLeft(1)
        end
    end
end   



	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon( "tesla_map.tex" )
	    
		-- inst:AddTag("prototyper")
		
		local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(1.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(143/255,141/255,141/255)
		
	    anim:SetBank("tesla")
	    anim:SetBuild("tesla")
	    anim:PlayAnimation("idle2",true)
	    anim:SetTime(math.random()*2)
		
		-- inst:AddComponent("prototyper")
		-- inst.components.prototyper.onturnon = onturnon
		-- inst.components.prototyper.onturnoff = onturnoff

		MakeObstaclePhysics(inst, .25)   
		inst:AddTag("tree")
			
		inst:AddComponent("lootdropper") 
		inst.components.lootdropper:SetChanceLootTable('tesla_tree1')
		
		
	    inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = inspect_tree
		
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.CHOP)
		inst.components.workable:SetWorkLeft(10)
		inst.components.workable:SetOnWorkCallback(chop_tree)
		inst.components.workable:SetOnFinishCallback(chop_down_tree)
		
		MakeLargeBurnable(inst)
		inst.components.burnable:SetOnBurntFn(tree_burnt)
		MakeLargePropagator(inst)
	    
	    return inst
	end   

STRINGS.NAMES.TESLA1 = "Tesla Tree"

return Prefab( "common/tesla1", fn, assets, prefabs)
