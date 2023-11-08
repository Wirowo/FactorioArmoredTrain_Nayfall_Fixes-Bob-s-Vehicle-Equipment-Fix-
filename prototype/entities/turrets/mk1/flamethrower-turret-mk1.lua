local flamethrowerTurretMk1 = ArmoredTrain.mk1.turrets.flamethrowerMk1
local flamethrowerWagonMk1 = ArmoredTrain.mk1.wagons.flamethrowerMk1

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local l_flamethrower_turret_mk1 = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

-- Name
l_flamethrower_turret_mk1.name = flamethrowerTurretMk1.name

-- Flags
l_flamethrower_turret_mk1.flags =
{
	"player-creation", -- Can draw enemies
	"placeable-off-grid",
	"not-on-map",   -- Do not show on minimap
	"not-repairable",
	"not-deconstructable",
	"not-blueprintable"
}

-- Mining
l_flamethrower_turret_mk1.minable = nil

-- HP
l_flamethrower_turret_mk1.max_health = flamethrowerWagonMk1
	.health -- Same as platform hp (Critical component or will be destroyed using old script)

-- Resistance
l_flamethrower_turret_mk1.resistances = flamethrowerWagonMk1.resistances

-- Collision
l_flamethrower_turret_mk1.collision_box = { { -1, -1 }, { 1, 1 } }
l_flamethrower_turret_mk1.collision_mask = { "object-layer" } -- Fix player stuck inside wagon forever
l_flamethrower_turret_mk1.selection_box = { { -1.25, -1.25 }, { 1.25, 1.25 } }

-- Rotation speed
local l_base_tank_copy_param = util.table.deepcopy(data.raw["car"]["tank"]["turret_rotation_speed"])
l_flamethrower_turret_mk1.rotation_speed = l_base_tank_copy_param

-- Inventory
l_flamethrower_turret_mk1.inventory_size = flamethrowerTurretMk1.inventorySize

-- Attack speed
l_flamethrower_turret_mk1.attacking_speed = l_flamethrower_turret_mk1.attacking_speed * 4

-- Animation functions
l_flamethrower_turret_mk1.gun_animation_render_layer = "higher-object-under"
local function flamethrower_turret_extension(inputs)
	return
	{
		filename = "__Armored-train_Nayfall_Fixes__/assets/flamethrower-turret-mk1/sprites/flamethrower-turret-raising.png",
		priority = "medium",
		width = 152,
		height = 128,
		direction_count = 4,
		frame_count = inputs.frame_count or 15, -- Match base flamethrower
		line_length = inputs.line_length or 0,
		run_mode = inputs.run_mode or "forward",
		shift = util.by_pixel(0, -75), -- Sprite offset in world
		scale = 0.5,             -- Sprite scale
		axially_symmetrical = false
		-- hr version missing
	}
end

local function flamethrower_turret_attack(inputs)
	return
	{
		layers =
		{
			{
				width = 158,
				height = 128,
				frame_count = inputs.frame_count or 2,
				axially_symmetrical = false,
				direction_count = 64,
				shift = util.by_pixel(-1, -74), -- Actual sprite offset (different atlas)
				scale = 0.5,
				stripes =
				{
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/flamethrower-turret-mk1/sprites/flamethrower-turret-shooting-1.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/flamethrower-turret-mk1/sprites/flamethrower-turret-shooting-2.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/flamethrower-turret-mk1/sprites/flamethrower-turret-shooting-3.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/flamethrower-turret-mk1/sprites/flamethrower-turret-shooting-4.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					}
				}
				-- hr version missing and mask and shadow
			}
		}
	}
end

-- Animation calls
l_flamethrower_turret_mk1.folded_animation =
{
	layers =
	{
		flamethrower_turret_extension { frame_count = 1, line_length = 1 },
	}
}
l_flamethrower_turret_mk1.preparing_animation =
{
	layers =
	{
		flamethrower_turret_extension {},
	}
}
l_flamethrower_turret_mk1.prepared_animation = flamethrower_turret_attack { frame_count = 1 }
l_flamethrower_turret_mk1.attacking_animation = flamethrower_turret_attack {}
l_flamethrower_turret_mk1.folding_animation =
{
	layers =
	{
		flamethrower_turret_extension { run_mode = "backward" },
	}
}

-- Base picture
local blank_layers =
{
	layers =
	{
		{
			filename = "__Armored-train_Nayfall_Fixes__/assets/utils/fakeTransparent.png",
			direction_count = 1,
			height = 16,
			width = 16
		}
	}
}
l_flamethrower_turret_mk1.base_picture = blank_layers

--------------
--- ATTACK ---
--------------

-- Takes this as base
local l_base_gun_copy = util.table.deepcopy(data.raw["gun"]["flamethrower"])
l_flamethrower_turret_mk1.attack_parameters = l_base_gun_copy.attack_parameters

-- Range
l_flamethrower_turret_mk1.attack_parameters.min_range = flamethrowerTurretMk1.minRange
l_flamethrower_turret_mk1.attack_parameters.range = flamethrowerTurretMk1.range

-- Damage modifier
l_flamethrower_turret_mk1.attack_parameters.damage_modifier = flamethrowerTurretMk1.damageModifier

l_flamethrower_turret_mk1.attack_parameters.gun_center_shift = { 0, -3.25 } --  default -1.15

-- Write result
data:extend
({
	l_flamethrower_turret_mk1
})
