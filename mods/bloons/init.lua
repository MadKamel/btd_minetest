bloons = {}


-- Import bloons.lua
dofile(minetest.get_modpath("bloons").."/bloons.lua")

-- Here we register bloons.
local modifier = 1
bloons.register_bloon("red", {type=0, speed=0.5*modifier, size=0.9})
bloons.register_bloon("blue", {type=1, speed=1*modifier, size=1.0})
bloons.register_bloon("green", {type=2, speed=1.5*modifier, size=1.1})
bloons.register_bloon("yellow", {type=3, speed=2*modifier, size=1.2})
bloons.register_bloon("pink", {type=4, speed=2.5*modifier, size=1.4})
bloons.register_bloon("black", {type=5, speed=1.5*modifier, size=0.5})
bloons.register_bloon("white", {type=5, speed=1.5*modifier, size=0.5})
bloons.register_bloon("zebra", {type=6, speed=1.5*modifier, size=1.2})
bloons.register_bloon("rainbow", {type=7, speed=2*modifier, size=1.4})

minetest.register_chatcommand("bloon", {
	params = "",
	description = "Spawns a red bloon.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		bloons.add_bloon(player:get_pos(), "red")
	end
})



minetest.register_node("bloons:path", {
	description = "Bloon Track",
	tiles = {"bloon_track_arrow.png", "default_sand.png"},
	groups = {oddly_breakable_by_hand=3, path=1},
	paramtype2 = "facedir"
})



minetest.register_node("bloons:spawner", {
	description = "Spawner",
	drawtype = "raillike",
	tiles = {"spawn_platform_open.png"},
	groups = {oddly_breakable_by_hand=3}
})

minetest.register_abm({
	nodenames = {"bloons:spawner"},
	interval = 6,
	chance = 1,
	action = function(pos, yada, yada2, dunno)
		bloons.add_bloon(pos, "rainbow")
	end
})