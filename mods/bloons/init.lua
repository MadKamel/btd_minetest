bloons = {}


-- Import bloons.lua
dofile(minetest.get_modpath("bloons").."/bloons.lua")

-- Here we register bloons.
local modifier = 1
bloons.register_bloon("red", {type=0, speed=0.5*modifier, size=0.9, armoured=false})
bloons.register_bloon("blue", {type=1, speed=1*modifier, size=1.0, armoured=false})
bloons.register_bloon("green", {type=2, speed=1.5*modifier, size=1.1, armoured=false})
bloons.register_bloon("yellow", {type=3, speed=2*modifier, size=1.2, armoured=false})
bloons.register_bloon("pink", {type=4, speed=2.5*modifier, size=1.4, armoured=false})
bloons.register_bloon("black", {type=5, speed=1.5*modifier, size=0.5, armoured=false})
bloons.register_bloon("white", {type=5, speed=1.5*modifier, size=0.5, armoured=false})
bloons.register_bloon("zebra", {type=6, speed=1.5*modifier, size=1.2, armoured=false})
bloons.register_bloon("rainbow", {type=7, speed=2*modifier, size=1.4, armoured=false})
bloons.register_bloon("lead", {type=8, speed=0.5*modifier, size=1.0, armoured=true})
bloons.register_moab("ceramic", {type=1, speed=1.75*modifier, size=1.0, armoured=false, health=10})

minetest.register_chatcommand("bloon", {
	params = "",
	description = "Spawns a red bloon.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		newpos = {x=player:get_pos().x, y=player:get_pos().y+0.5, z=player:get_pos().z}
		bloons.add_bloon(newpos, "red")
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
	interval = 1,
	chance = 1,
	action = function(pos, yada, yada2, dunno)
		bloons.add_bloon(pos, "pink")
	end
})
