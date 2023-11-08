local minigunTurretMk1 = ArmoredTrain.mk1.turrets.minigunMk1
local minigunWagonMk1 = ArmoredTrain.mk1.wagons.minigunMk1

--------------
--- ENTITY ---
--------------

-- Deep copy base data and create new one with custom parametres
local l_minigun_turret_mk1 = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

-- Name
l_minigun_turret_mk1.name = minigunTurretMk1.name

-- Flags
l_minigun_turret_mk1.flags =
{
	"player-creation", -- Can draw enemies
	"placeable-off-grid",
	"not-on-map",   -- Do not show on minimap
	"not-repairable",
	"not-deconstructable",
	"not-blueprintable"
}

-- Mining
l_minigun_turret_mk1.minable = nil

-- HP
l_minigun_turret_mk1.max_health = minigunWagonMk1
	.health -- Same as platform hp (Critical component or will be destroyed using old script)

-- Resistance
l_minigun_turret_mk1.resistances = minigunWagonMk1.resistances -- Prevent faster damage from turret

-- Collision
l_minigun_turret_mk1.collision_box = { { -1, -1 }, { 1, 1 } }
l_minigun_turret_mk1.collision_mask = { "object-layer" } -- Fix player stuck inside wagon forever
l_minigun_turret_mk1.selection_box = { { -1.25, -1.25 }, { 1.25, 1.25 } }

-- Rotation speed
local l_base_tank_copy_param = util.table.deepcopy(data.raw["car"]["tank"]["turret_rotation_speed"])
l_minigun_turret_mk1.rotation_speed = l_base_tank_copy_param

-- Inventory
l_minigun_turret_mk1.inventory_size = minigunTurretMk1.inventorySize

-- Animation functions
l_minigun_turret_mk1.gun_animation_render_layer = "higher-object-under"
local function minigun_turret_extension(inputs)
	return
	{
		filename = "__Armored-train_Nayfall_Fixes__/assets/minigun-turret-mk1/sprites/minigun-turret-raising.png",
		priority = "medium",
		width = 130,
		height = 126,
		direction_count = 4,
		frame_count = inputs.frame_count or 5,
		line_length = inputs.line_length or 0,
		run_mode = inputs.run_mode or "forward",
		shift = util.by_pixel(0, -40), -- Sprite offset in world
		scale = 0.5,             -- Sprite scale
		axially_symmetrical = false
		-- hr version missingewde
	}
end

local function minigun_turret_attack(inputs)
	return
	{
		layers =
		{
			{
				width = 132,
				height = 130,
				frame_count = inputs.frame_count or 2,
				axially_symmetrical = false,
				direction_count = 64,
				shift = util.by_pixel(0, -40),
				scale = 0.5,
				stripes =
				{
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-1.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-2.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-3.png",
						width_in_frames = inputs.frame_count or 2,
						height_in_frames = 16
					},
					{
						filename =
						"__Armored-train_Nayfall_Fixes__/assets/minigun-turret-mk1/sprites/minigun-turret-shooting-4.png",
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
l_minigun_turret_mk1.folded_animation =
{
	layers =
	{
		minigun_turret_extension { frame_count = 1, line_length = 1 },
	}
}
l_minigun_turret_mk1.preparing_animation =
{
	layers =
	{
		minigun_turret_extension {},
	}
}
l_minigun_turret_mk1.prepared_animation = minigun_turret_attack { frame_count = 1 }
l_minigun_turret_mk1.attacking_animation = minigun_turret_attack {}
l_minigun_turret_mk1.folding_animation =
{
	layers =
	{
		minigun_turret_extension { run_mode = "backward" },
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
l_minigun_turret_mk1.base_picture = blank_layers

--------------
--- ATTACK ---
--------------

-- Range
l_minigun_turret_mk1.attack_parameters.range = minigunTurretMk1.range

-- Damage modifier
l_minigun_turret_mk1.attack_parameters.damage_modifier = minigunTurretMk1.damageModifier

l_minigun_turret_mk1.attack_parameters.projectile_center = { -0.15625, -0.07812 * 7 } -- Overwrite parameter

-- Write result
data:extend
({
	l_minigun_turret_mk1
})
