local tableContains = require("utils").tableContains
local combatWagons = require("config.values.combatWagonsValues")

local validEntities = {}

-- Add wagons to valid entities
for _, wagon in pairs(combatWagons) do
	table.insert(validEntities, wagon.name)
end

--------------------------
--FUNCTIONS---------------
--------------------------

-- Is this mod entity? If yes true, othervise false
local function isModEntity(entity)
	return entity and entity.valid and tableContains(validEntities, entity.name)
end

-- Create turret as proxy to platform (data stored to table)
local function createProxyTurret(name, position, surface, force)
	local proxy = surface.create_entity {
		name = name,
		position = position,
		force = force
	}
	return proxy
end

-- Create turretPlatformList table to store data for proxy and platform or pass data if created
local function initTurretPlatformList(tableValue)
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
		if string.find(createdEntity.name, "platform") then
			proxyName = createdEntity.name:gsub("-platform%-", "-turret-")
		elseif string.find(createdEntity.name, "wagon") then
			proxyName = createdEntity.name:gsub("-wagon%-", "-turret-")
		end

		if proxyName then
			local proxy = createProxyTurret(proxyName, createdEntity.position, createdEntity.surface, createdEntity
				.force)

			-- Create table "turretPlatformList" and store data (if null create else just pass data)
			global.turretPlatformList = initTurretPlatformList(global.turretPlatformList)

			-- Add created platform and turret to table (list)
			table.insert(global.turretPlatformList, { platform = createdEntity, proxy = proxy })
		end
	end
end
--ON BUILT /\--

-- --ON TICK \/--
local function onTickMain(event)
	-- Move each turret to follow its wagon
	if global.turretPlatformList then
		for _, turretPlatform in ipairs(global.turretPlatformList) do
			if turretPlatform.platform and turretPlatform.platform.valid and turretPlatform.proxy and turretPlatform.proxy.valid then
				local entity = turretPlatform.platform
				local proxy = turretPlatform.proxy

				-- Teleport the turret to the wagon position
				proxy.teleport(entity.position)

				-- Apply damage taken to the wagon
				if event.tick % 20 == 3 then
					local damageTaken = WagonsMk1Health - proxy.health

					if damageTaken > 0 then
						local platformCurrentHealth = entity.health

						if platformCurrentHealth <= damageTaken then
							proxy.destroy()
							entity.die()
						else
							entity.health = platformCurrentHealth - damageTaken
							proxy.health = WagonsMk1Health
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
		for i, value in ipairs(global.turretPlatformList) do
			if value.platform == event.entity then
				entryIndex = i
				break
			end
		end

		if entryIndex then
			local entry = table.remove(global.turretPlatformList, entryIndex)
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
		for i, value in ipairs(global.turretPlatformList) do
			if value.platform == event.entity then
				entryIndex = i
				break
			end
		end

		if entryIndex then
			local entry = table.remove(global.turretPlatformList, entryIndex)
			if entry.proxy and entry.proxy.valid then
				entry.proxy.destroy()
			end
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
