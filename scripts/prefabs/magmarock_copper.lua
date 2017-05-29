local assets =
{
	Asset("ANIM", "anim/rock_magma_copper.zip"),
	Asset("MINIMAP_IMAGE", "rockmagma"),
}

local prefabs =
{
	"rocks",
	"flint",
	"coppernugget",
	"redgem",
	"bluegem",
	"flamegeyser"
}

local onworkedgeyser = nil

local function GetLoot(loot_table, num)

	local total = 0
	for k,v in pairs(loot_table) do
		total = total + v
	end

	local loot = {}

	for i = 1, num do
		local rand = math.random() * total
		for k,v in pairs(loot_table) do
			rand = rand - v
			if rand <= 0 then
				table.insert(loot, k)
				break
			end
		end
	end

	return loot
end

--This isn't used anymore!
local function onworkedgeyser(inst, worker, workleft)
	if workleft <= 0 then 
		local geyser = SpawnPrefab("flamegeyser")
		geyser.Transform:SetPosition(inst:GetPosition():Get())
		geyser:OnErupt()
		--inst.components.lootdropper.speed = 8 + (math.random() * 6)
		local loot = GetLoot(inst.loot, math.random(2,3))
		inst.components.lootdropper:ExplodeLoot(nil, 6 + (math.random() * 8), loot)
		--[[for k,v in pairs(loot) do
			local newprefab = inst.components.lootdropper:SpawnLootPrefab(v)
			local vx, vy, vz = newprefab.Physics:GetVelocity()
			newprefab.Physics:SetVel(vx, 35, vz )
			
		end]]

		inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/dig_rockpile")

		inst:Remove()
	end 
end


local STAGES =
{
	{
        animation = "low",
        work = 2,
        stage_initfn = function(inst)
			--if math.random() < TUNING.FLAMEGEYSER_SPAWN_CHANCE then
			--	inst.components.workable:SetOnWorkCallback(onworkedgeyser)
			--end
    	end
	},
	{
        animation = "med",
        work = 4,
	},
	{
        animation = "full",
        work = 6,
	},
}


local function SetStage(inst, stage)
	inst.stage = stage
	inst.AnimState:PlayAnimation(STAGES[inst.stage].animation)
	--inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)
	
	if STAGES[inst.stage].stage_initfn ~= nil then
		STAGES[inst.stage].stage_initfn(inst)
	end
end

local function onworked(inst, worker, workleft)

	inst.SoundEmitter:PlaySound("dontstarve_DLC002/common/dig_rockpile")
	
	local nextStage = 3 
	if workleft <= 0 then 
		nextStage = 0
	elseif workleft <= 2 then 
		nextStage = 1
	elseif workleft <= 4 then 
		nextStage = 2
	end 
	
	local numDrops = inst.stage - nextStage

	local doGeyser = nextStage == 0 and math.random() < TUNING.FLAMEGEYSER_SPAWN_CHANCE

	if doGeyser then 
		local geyser = SpawnPrefab("flamegeyser")
		geyser.Transform:SetPosition(inst:GetPosition():Get())
		geyser:OnErupt()
	end 

	for i = 1, numDrops do 
		local loot = GetLoot(inst.loot, math.random(2,3))
		if doGeyser then 
			inst.components.lootdropper:ExplodeLoot(nil, 6 + (math.random() * 8), loot)
		else 
			inst.components.lootdropper:DropLoot(nil, loot)
		end 
	end 

	if nextStage ~= inst.stage then 
		if nextStage == 0 then
			if not doGeyser and inst.components.growable then
				inst.components.growable:SetStage(1)
			else
				inst:Remove()
			end
		else
			SetStage(inst, nextStage)
		end
	end 
end

local function SetEmpty(inst)
	local sm = GetSeasonManager()
	local days = sm:GetSeasonLength(SEASONS.MILD) + sm:GetSeasonLength(SEASONS.WET) + sm:GetSeasonLength(SEASONS.GREEN) + sm:GetSeasonLength(SEASONS.DRY)
	inst.components.growable:StartGrowing(days * TUNING.TOTAL_DAY_TIME)
	inst.Physics:SetCollides(false)
	inst:AddTag("NOCLICK")
	inst:Hide()
	inst.MiniMapEntity:SetEnabled(false)
end

local function SetFull(inst)
	SetStage(inst, 3)
	inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)
	inst.components.growable:StopGrowing()
	inst.Physics:SetCollides(true)
	inst:RemoveTag("NOCLICK")
	inst:Show()
	inst.MiniMapEntity:SetEnabled(true)
end

local grow_stages =
{
	{name="empty", fn=SetEmpty},
	{name="full", fn=SetFull},
}

local function SetRegen(inst)
	inst:AddComponent("growable")
	inst.components.growable.stages = grow_stages
	inst.components.growable:SetStage(2)
	inst.components.growable.loopstages = false
	inst.components.growable.growonly = false
	inst.components.growable.springgrowth = false
	inst.components.growable.growoffscreen = true
end

local function OnSave(inst, data)
	data.stage = inst.stage
end

local function OnLoad(inst, data)
	if data and data.stage then
		SetStage(inst, data.stage)
		inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)
	end
	if data and data.regen and data.regen == true then
		SetRegen(inst)
	end
end


----------COPPER ROCKS------------

local copper_loot_table =
{
	["rocks"] = 0.75,
	["flint"] = 0.25,
	["coppernugget"] = 0.25,
	["redgem"] = 0.005,
	["bluegem"] = 0.0025,
}

local function copper_commonfn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()

	MakeObstaclePhysics(inst, 1)

	inst.MiniMapEntity:SetIcon( "rockmagma.png" )

    inst.AnimState:SetBank("rock_magma_copper")
    inst.AnimState:SetBuild("rock_magma_copper")

	inst:AddComponent("inspectable")

	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.DIG)
	inst.components.workable:SetWorkLeft(6)
	inst.components.workable:SetOnWorkCallback(onworked)

	inst:AddComponent("lootdropper")
	inst.loot = copper_loot_table

	inst.components.inspectable.nameoverride = "magmarock_copper"
	inst.displaynamefn = function(inst) return STRINGS.NAMES["MAGMAROCK_COPPER"] end

	inst.stage = 3
	SetStage(inst, inst.stage)

	inst.OnLoad = OnLoad
	inst.OnSave = OnSave

	return inst
end

local function copper_full_fn()
	local inst = copper_commonfn()

	inst.stage = 3
	SetStage(inst, inst.stage)
	inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)

	return inst
end

local function copper_med_fn()
	local inst = copper_commonfn()

	inst.stage = 2
	SetStage(inst, inst.stage)
	inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)

	return inst
end

local function copper_low_fn()
	local inst = copper_commonfn()

	inst.stage = 1
	SetStage(inst, inst.stage)
	inst.components.workable:SetWorkLeft(STAGES[inst.stage].work)

	return inst
end


STRINGS.NAMES.MAGMAROCK_COPPER = "Magma Pile"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGMAROCK_COPPER = {	
	"I see a ... copper opportunity?",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.MAGMAROCK_COPPER = {	
	"SENSING BARELY CONTAINED, UNSTABLE FORCES",
}

return Prefab("magmarock_copper", copper_full_fn, assets, prefabs),
Prefab("magmarock_copper_full", copper_full_fn, assets, prefabs),
Prefab("magmarock_copper_med", copper_med_fn, assets, prefabs),
Prefab("magmarock_copper_low", copper_low_fn, assets, prefabs)
