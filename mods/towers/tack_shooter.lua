minetest.register_entity("towers:shot_tack", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"tack.png"},
		show_on_minimap = false,
		tack_range = 10
	},
	projectile = true,
	on_step = function(self, dtime, moveresult)
		if moveresult.collides == true then
			self.object:remove()
		end
		--self.object:remove()
		--minetest.log(dump(moveresult))
	end,
})

minetest.register_entity("towers:shot_flame", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"flame.png"},
		show_on_minimap = false,
		tack_range = 10
	},
	projectile = true,
	on_step = function(self, dtime, moveresult)
		if moveresult.collides == true then
			self.object:remove()
		end
		--self.object:remove()
		--minetest.log(dump(moveresult))
	end,
})

TimeOut = function(seconds)
	local start = os.time()
	repeat until os.time() > start + seconds
end



towers.FireTacks = function(pos, speed)
	tack0 = minetest.add_entity(pos, "towers:shot_tack")
	tack1 = minetest.add_entity(pos, "towers:shot_tack")
	tack2 = minetest.add_entity(pos, "towers:shot_tack")
	tack3 = minetest.add_entity(pos, "towers:shot_tack")
	tack4 = minetest.add_entity(pos, "towers:shot_tack")
	tack5 = minetest.add_entity(pos, "towers:shot_tack")
	tack6 = minetest.add_entity(pos, "towers:shot_tack")
	tack7 = minetest.add_entity(pos, "towers:shot_tack")

	tack0:set_velocity({x=0, y=0, z=speed})
	tack1:set_velocity({x=0, y=0, z=0-speed})
	tack2:set_velocity({x=speed, y=0, z=0})
	tack3:set_velocity({x=0-speed, y=0, z=0})
	tack4:set_velocity({x=speed, y=0, z=speed})
	tack5:set_velocity({x=speed, y=0, z=0-speed})
	tack6:set_velocity({x=0-speed, y=0, z=speed})
	tack7:set_velocity({x=0-speed, y=0, z=0-speed})

	minetest.log("Tacks flying!")
end

towers.FireFlames = function(pos, speed)
	tack0 = minetest.add_entity(pos, "towers:shot_flame")
	tack1 = minetest.add_entity(pos, "towers:shot_flame")
	tack2 = minetest.add_entity(pos, "towers:shot_flame")
	tack3 = minetest.add_entity(pos, "towers:shot_flame")
	tack4 = minetest.add_entity(pos, "towers:shot_flame")
	tack5 = minetest.add_entity(pos, "towers:shot_flame")
	tack6 = minetest.add_entity(pos, "towers:shot_flame")
	tack7 = minetest.add_entity(pos, "towers:shot_flame")

	tack0:set_velocity({x=0, y=0, z=speed})
	tack1:set_velocity({x=0, y=0, z=0-speed})
	tack2:set_velocity({x=speed, y=0, z=0})
	tack3:set_velocity({x=0-speed, y=0, z=0})
	tack4:set_velocity({x=speed, y=0, z=speed})
	tack5:set_velocity({x=speed, y=0, z=0-speed})
	tack6:set_velocity({x=0-speed, y=0, z=speed})
	tack7:set_velocity({x=0-speed, y=0, z=0-speed})

	minetest.log("Flames flying!")
end

minetest.register_chatcommand("tacks", {
	params = "",
	description = "Creates a ring of tacks that move outward from the player.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		towers.FireTacks(vector.add(player:get_pos(), vector.new(0, 0.5, 0)), 15)
	end
})

minetest.register_chatcommand("tack", {
	params = "",
	description = "Creates a single tack that moves slowly away from the player.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local speed = 5
		minetest.add_entity(player:get_pos(), "towers:shot_tack"):set_velocity({x=0, y=0, z=speed})
	end
})



minetest.register_node("towers:tack_shooter", {
	description = "Tack Shooter",
	tiles = {"tshooter_top.png", "tshooter_bottom.png", "tshooter_side.png"},
	groups = {oddly_breakable_by_hand=3}
})

minetest.register_abm({
	nodenames = {"towers:tack_shooter"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		towers.FireTacks(pos, 15)
	end
})

minetest.register_node("towers:flame_shooter", {
	description = "Flame Shooter",
	tiles = {"tshooter_top.png", "tshooter_bottom.png", "tshooter_side.png"},
	groups = {oddly_breakable_by_hand=3}
})

minetest.register_abm({
	nodenames = {"towers:flame_shooter"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		towers.FireFlames(pos, 15)
	end
})
