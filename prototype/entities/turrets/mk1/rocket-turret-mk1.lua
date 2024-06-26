local rocketTurretMk1 = ArmoredTrain.mk1.turrets.rocketMk1
local rocketWagonMk1 = ArmoredTrain.mk1.wagons.rocketMk1

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local e_rocket_turret_mk1 = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

-- Name
e_rocket_turret_mk1.name = rocketTurretMk1.name

-- Flags
e_rocket_turret_mk1.flags =
{
	"player-creation", -- Can draw enemies
	"placeable-off-grid",
	"not-on-map",   -- Do not show on minimap
	"not-repairable",
	"not-deconstructable",
	"not-blueprintable"
}

-- Mining
e_rocket_turret_mk1.minable = nil

-- HP
e_rocket_turret_mk1.max_health = rocketWagonMk1
	.max_health -- Same as platform hp (Critical component or will be destroyed using old script)

-- Resistance
e_rocket_turret_mk1.resistances = rocketWagonMk1.resistances -- Prevent faster damage from turret

-- Collision
e_rocket_turret_mk1.collision_box = { { -1, -1 }, { 1, 1 } }
e_rocket_turret_mk1.collision_mask = { "object-layer" } -- Fix player stuck inside wagon forever
e_rocket_turret_mk1.selection_box = { { -1.25, -1.25 }, { 1.25, 1.25 } }

-- Rotation speed
local s_base_tank_copy_param = table.deepcopy(data.raw["car"]["tank"]["turret_rotation_speed"])
e_rocket_turret_mk1.rotation_speed = s_base_tank_copy_param

-- Inventory
e_rocket_turret_mk1.inventory_size = rocketTurretMk1.inventory_size

-- Attack speed
e_rocket_turret_mk1.attacking_speed = e_rocket_turret_mk1.attacking_speed / 2

-- Animation functions
e_rocket_turret_mk1.gun_animation_render_layer = "higher-object-under"
local function rocket_turret_extension(inputs)
	return
	{
		filename = "__Armored-train_Nayfall_Fixes__/assets/turrets/rocket/mk1/sprites/rocket-turret-raising.png",
		priority = "medium",
		width = 88,
		height = 80,
		direction_count = 4,
		frame_count = inputs.frame_count or 5,
		line_length = inputs.line_length or 0,
		run_mode = inputs.run_mode or "forward",
		shift = util.by_pixel(0, -50), -- Sprite offset in world
		scale = 1,               -- Sprite scale
		axially_symmetrical = false
		-- hr version missing
	}
end

local function rocket_turret_attack(inputs)
	return
	{
		layers =
		{
			{
				width = 88,
				height = 80,
				frame_count = inputs.frame_count or 2,
				axially_symmetrical = false,
				direction_count = 64,
				shift = util.by_pixel(0, -50),
				scale = 1,
				stripes =
				{
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/turrets/rocket/mk1/sprites/rocket-turret-shooting-1.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/turrets/rocket/mk1/sprites/rocket-turret-shooting-2.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/turrets/rocket/mk1/sprites/rocket-turret-shooting-3.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/turrets/rocket/mk1/sprites/rocket-turret-shooting-4.png",
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
e_rocket_turret_mk1.folded_animation =
{
	layers =
	{
		rocket_turret_extension { frame_count = 1, line_length = 1 },
	}
}
e_rocket_turret_mk1.preparing_animation =
{
	layers =
	{
		rocket_turret_extension {},
	}
}
e_rocket_turret_mk1.prepared_animation = rocket_turret_attack { frame_count = 1 }
e_rocket_turret_mk1.attacking_animation = rocket_turret_attack {}
e_rocket_turret_mk1.folding_animation =
{
	layers =
	{
		rocket_turret_extension { run_mode = "backward" },
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
e_rocket_turret_mk1.base_picture = blank_layers

--------------
--- ATTACK ---
--------------

-- Takes this as base
local s_base_gun_copy = table.deepcopy(data.raw["gun"]["rocket-launcher"])
e_rocket_turret_mk1.attack_parameters = s_base_gun_copy.attack_parameters

-- Range
e_rocket_turret_mk1.attack_parameters.min_range = rocketTurretMk1.min_range -- Overwrite parameter
e_rocket_turret_mk1.attack_parameters.range = rocketTurretMk1.range         -- Overwrite parameter

-- Damage modifier
e_rocket_turret_mk1.attack_parameters.damage_modifier = rocketTurretMk1.damage_modifier -- Overwrite parameter

-- Cooldown
e_rocket_turret_mk1.attack_parameters.cooldown = rocketTurretMk1.cooldown  -- Overwrite parameter

e_rocket_turret_mk1.attack_parameters.projectile_center = { -0.17, -0.75 } -- Overwrite parameter

-- Write result
data:extend
({
	e_rocket_turret_mk1
})
