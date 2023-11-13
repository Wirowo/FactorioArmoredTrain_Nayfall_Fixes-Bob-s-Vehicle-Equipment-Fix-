local Utils = require("utils")
local ArmoredTrain = require("config.configInitialize")

local validEntities = {}

-- Add turret wagons to valid entities
for _, wagon in pairs(ArmoredTrain.total.wagons) do
	if not string.find(wagon.name, "cargo") and not string.find(wagon.name, "fluid") then
		table.insert(validEntities, wagon.name)
	end
end

---------------------------
-------- FUNCTIONS --------
---------------------------

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

-------------------
---- ON EVENTS ----
-------------------

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
			local entityNameId = createdEntity.name .. createdEntity.unit_number

			global.turretWagonList[entityNameId] = {
				wagon = createdEntity,
				proxy = proxy
			}
		end
	end
end
--ON BUILT /\--

-- --ON TICK \/--
local function onTickMain()
	-- Move each turret to follow its wagon
	if global.turretWagonList then
		for _, turretWagon in pairs(global.turretWagonList) do
			if turretWagon.wagon and turretWagon.wagon.valid and turretWagon.proxy and turretWagon.proxy.valid then
				local wagonEntity = turretWagon.wagon
				local turretEntity = turretWagon.proxy

				-- Teleport the turret to the wagon position
				turretEntity.teleport(wagonEntity.position)

				-- Transfer items from wagon to turret
				local wagonInventory = wagonEntity.get_inventory(defines.inventory.cargo_wagon)
				local turretInventory = turretEntity.get_inventory(defines.inventory.turret_ammo)

				-- Iterate over items in the wagon inventory
				for i = 1, #wagonInventory do
					local itemStack = wagonInventory[i]
					if itemStack and itemStack.valid_for_read then
						-- Verify if turret can accept item
						if turretInventory.can_insert(itemStack) then
							-- Insert item on turret inventory
							turretInventory.insert(itemStack)
							-- Delete item from wagon inventory
							wagonInventory.remove(itemStack)
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
		local entry = global.turretWagonList[event.entity.name .. event.entity.unit_number]
		if entry then
			if entry.proxy and entry.proxy.valid then
				entry.proxy.destroy()
			end
			global.turretWagonList[event.entity.name .. event.entity.unit_number] = nil
		end
	end
end
--ON REMOVE /\--

-- --ON DESTROY \/--
local function entityDestroyed(event)
	if isModEntity(event.entity) then
		local entry = global.turretWagonList[event.entity.name .. event.entity.unit_number]
		if entry then
			if entry.proxy and entry.proxy.valid then
				entry.proxy.destroy()
			end
			global.turretWagonList[event.entity.name .. event.entity.unit_number] = nil
		end
	end
end
--ON DESTROY /\--

-- Events
script.on_event(defines.events.on_built_entity, entityBuilt)
script.on_event(defines.events.on_robot_built_entity, entityBuilt)
script.on_event(defines.events.script_raised_built, entityBuilt)

script.on_event(defines.events.on_pre_player_mined_item, entityRemoved)
script.on_event(defines.events.on_robot_pre_mined, entityRemoved)
script.on_event(defines.events.script_raised_destroy, entityRemoved)

script.on_event(defines.events.on_entity_died, entityDestroyed)

script.on_event(defines.events.on_tick, onTickMain)

---------------
----- VTK -----
---------------

-- --ON DAMAGED \/--
local function entityDamaged(event)
	-- Verify if entity have name and unit number (When a rock or a tree is hit causes crashes)
	if event.entity.name and event.entity.unit_number then
		if global.turretWagonList then
			-- Get entity name and unit number
			local entityNameId = event.entity.name .. event.entity.unit_number

			for _, turretWagon in pairs(global.turretWagonList) do
				if turretWagon.proxy.valid and turretWagon.wagon.valid then
					-- Get turret name and unit number
					local turretNameId = turretWagon.proxy.name .. turretWagon.proxy.unit_number

					-- The turret is the entity?
					if turretNameId == entityNameId then
						local wagonEntity = turretWagon.wagon
						local turretEntity = turretWagon.proxy
						local damageTaken = event.final_damage_amount
						local vtkHealth

						local equipmentCategories = wagonEntity.grid.prototype.equipment_categories

						-- Checks if grid have vtk category
						local hasVtkArmorPlating = false
						for _, category in pairs(equipmentCategories) do
							if category == "vtk-armor-plating" then
								hasVtkArmorPlating = true
								break
							end
						end

						if global.turretWagonList[wagonEntity.name .. wagonEntity.unit_number] then
							-- Checks if grid have vtk category and vtk health is avaible
							if hasVtkArmorPlating and global.turretWagonList[wagonEntity.name .. wagonEntity.unit_number].vtkHealth then
								vtkHealth = global.turretWagonList[wagonEntity.name .. wagonEntity.unit_number]
									.vtkHealth
								-- Otherwise clears vtk health
							else
								global.turretWagonList[wagonEntity.name .. wagonEntity.unit_number].vtkHealth = nil
							end
						end

						if damageTaken > 0 then
							local wagonCurrentHealth = wagonEntity.health

							if vtkHealth then
								local maxHealth = wagonEntity.prototype.max_health
								local diff = maxHealth / vtkHealth

								-- Reduce the dmg in relation to max health and vtk health
								local reducedDamage = damageTaken * diff

								if wagonCurrentHealth <= reducedDamage then
									turretEntity.destroy()
									wagonEntity.die()
								else
									-- Set new health - reduced damage
									wagonEntity.health = wagonCurrentHealth - reducedDamage
									turretEntity.health = vtkHealth
								end
							else
								-- If no vtk set new health - direct damage
								if wagonCurrentHealth <= damageTaken then
									turretEntity.destroy()
									wagonEntity.die()
								else
									wagonEntity.health = wagonCurrentHealth - damageTaken
									turretEntity.health = wagonEntity.prototype.max_health
								end
							end
						end
						-- Once turret is find breaks loop
						break
					end
				end
			end
		end
	end
end
-- --ON DAMAGED /\--

-- Store opened wagon to do vtk health maths
local selectedWagon

local function setSelectedWagon(event)
	if isModEntity(event.entity) then
		local equipmentCategories = event.entity.grid.prototype.equipment_categories

		-- Checks if grid have vtk category
		local hasVtkArmorPlating = false
		for _, category in pairs(equipmentCategories) do
			if category == "vtk-armor-plating" then
				hasVtkArmorPlating = true
				break
			end
		end

		-- If have vtk category select the entity
		if hasVtkArmorPlating then
			selectedWagon = event.entity
			-- Otherwise clears the vtkHealth property on that entity
		else
			global.turretWagonList[event.entity.name .. event.entity.unit_number].vtkHealth = nil
		end
	end
end

local function clearSelectedWagon()
	selectedWagon = nil
end

local function updateVtkHealth()
	if selectedWagon then
		local totalHealth = selectedWagon.prototype.max_health
		local hasPlatingEquipment = false

		if selectedWagon.grid then
			for equipment, count in pairs(selectedWagon.grid.get_contents()) do
				if equipment == "vtk-armor-plating-equipment" then
					totalHealth = totalHealth + (settings.global["vtk-armor-plating-equipment-amount"].value * count)
					hasPlatingEquipment = true
				end
				if equipment == "vtk-armor-plating-equipment-energized" then
					totalHealth = totalHealth *
						(1 + (settings.global["vtk-armor-plating-equipment-energized-multiplier"].value / 100))
					hasPlatingEquipment = true
				end
			end
		end

		-- If has plating adds its total health to global
		if hasPlatingEquipment then
			global.turretWagonList[selectedWagon.name .. selectedWagon.unit_number].vtkHealth = totalHealth
			-- Otherwise clears the vtkHealth property on that entity
		else
			global.turretWagonList[selectedWagon.name .. selectedWagon.unit_number].vtkHealth = nil
		end
	end
end

-- Events
script.on_event(defines.events.on_entity_damaged, entityDamaged)

script.on_event(defines.events.on_gui_opened, setSelectedWagon)
script.on_event(defines.events.on_gui_closed, clearSelectedWagon)

script.on_event(defines.events.on_player_placed_equipment, updateVtkHealth)
script.on_event(defines.events.on_player_removed_equipment, updateVtkHealth)
