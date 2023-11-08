local Utils = require("utils")
local ArmoredTrain = require("config.configInitialize")

local validEntities = {}

-- Add wagons to valid entities
for _, wagon in pairs(ArmoredTrain.total.wagons) do
	table.insert(validEntities, wagon.name)
end

--------------------------
--FUNCTIONS---------------
--------------------------

-- Is this mod entity? If yes true, othervise false
local function isModEntity(entity)
	return entity and entity.valid and Utils.tableContains(validEntities, entity.name)
end

-- Create turret as proxy to wagon (data stored to table)
local function createProxyTurret(name, position, surface, force)
	local proxy = surface.create_entity {
		name = name,
		position = position,
		force = force
	}
	return proxy
end

-- Create turretwagonList table to store data for proxy and wagon or pass data if created
local function initTurretwagonList(tableValue)
	-- If first time calling = create table
	if tableValue == nil then
		return {}
		-- If table created just pass values
	else
		return tableValue
	end
end

-------------
--ON EVENTS--
-------------

--ON BUILT \/--
local function entityBuilt(event)
	local createdEntity = event.created_entity or event.entity

	if isModEntity(createdEntity) then
		local proxyName
		if string.find(createdEntity.name, "wagon") then
			proxyName = createdEntity.name:gsub("-wagon%-", "-turret-")
		end

		if proxyName then
			local proxy = createProxyTurret(proxyName, createdEntity.position, createdEntity.surface, createdEntity
				.force)

			-- Create table "turretWagonList" and store data (if null create else just pass data)
			global.turretWagonList = initTurretwagonList(global.turretWagonList)

			-- Add created wagon and turret to table (list)
			table.insert(global.turretWagonList, { wagon = createdEntity, proxy = proxy })
		end
	end
end
--ON BUILT /\--

-- --ON TICK \/--
local function onTickMain(event)
	-- Move each turret to follow its wagon
	if global.turretWagonList then
		for _, turretWagon in ipairs(global.turretWagonList) do
			if turretWagon.wagon and turretWagon.wagon.valid and turretWagon.proxy and turretWagon.proxy.valid then
				local entity = turretWagon.wagon
				local proxy = turretWagon.proxy

				-- Teleport the turret to the wagon position
				proxy.teleport(entity.position)

				-- Apply damage taken to the wagon
				if event.tick % 20 == 3 then
					local damageTaken = entity.prototype.max_health - proxy.health

					if damageTaken > 0 then
						local wagonCurrentHealth = entity.health

						if wagonCurrentHealth <= damageTaken then
							proxy.destroy()
							entity.die()
						else
							entity.health = wagonCurrentHealth - damageTaken
							proxy.health = ArmoredTrain.bases.mk1.wagons.health
						end
					end
				end
			end
		end
	end
end
--ON TICK /\--



-- --ON REMOVE \/--
local function entityRemoved(event)
	if isModEntity(event.entity) then
		local entryIndex
		for i, value in ipairs(global.turretWagonList) do
			if value.wagon == event.entity then
				entryIndex = i
				break
			end
		end

		if entryIndex then
			local entry = table.remove(global.turretWagonList, entryIndex)
			if entry.proxy and entry.proxy.valid then
				entry.proxy.destroy()
			end
		end
	end
end
--ON REMOVE /\--

-- --ON DESTROY \/--
local function entityDestroyed(event)
	if isModEntity(event.entity) then
		local entryIndex
		for i, value in ipairs(global.turretWagonList) do
			if value.wagon == event.entity then
				entryIndex = i
				break
			end
		end

		if entryIndex then
			local entry = table.remove(global.turretWagonList, entryIndex)
			if entry.proxy and entry.proxy.valid then
				entry.proxy.destroy()
			end
		end
	end
end
--ON DESTROY /\--

-- Store opened wagon gui to do vtk health maths
local selectedEntity = nil

-- --ON PLACED EQUIPMENT \/--
local function onPlacedEquipment(event)
	-- local entity = event.entity
	-- local totalHp = entity.prototype.max_health
	-- if entity.grid ~= nil then
	-- 	for equipment, count in pairs(entity.grid.get_contents()) do
	-- 		if equipment == "vtk-armor-plating-equipment" then
	-- 			totalHp = totalHp + (settings.global["vtk-armor-plating-equipment-amount"].value * count)
	-- 		end
	-- 		if equipment == "vtk-armor-plating-equipment-energized" then
	-- 			totalHp = totalHp *
	-- 				(1 + (settings.global["vtk-armor-plating-equipment-energized-multiplier"].value / 100))
	-- 		end
	-- 	end

	-- 	log("Colocado: " .. event.equipment.name)
	-- 	log("Nueva vida de: " .. entity.name .. entity.unit_number .. "=" .. totalHp)
	-- end
end
--ON PLACED EQUIPMENT /\--

local function setSelectedEntity(event)
	if isModEntity(event.entity) then
		selectedEntity = event.entity
	end
end

-- Events
script.on_event(defines.events.on_built_entity, entityBuilt)
script.on_event(defines.events.on_robot_built_entity, entityBuilt)
script.on_event(defines.events.script_raised_built, entityBuilt)

script.on_event(defines.events.on_pre_player_mined_item, entityRemoved)
script.on_event(defines.events.on_robot_pre_mined, entityRemoved)
script.on_event(defines.events.script_raised_destroy, entityRemoved)

script.on_event(defines.events.on_entity_died, entityDestroyed)

script.on_event(defines.events.on_tick, onTickMain)

script.on_event(defines.events.on_player_placed_equipment, onPlacedEquipment)

script.on_event(defines.events.on_gui_opened, setSelectedEntity)
