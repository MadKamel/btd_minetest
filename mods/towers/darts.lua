minetest.register_entity("towers:shot_dart", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"dart.png"},
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

minetest.register_entity("towers:shot_firedart", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"firedart.png"},
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

towers.FireDart = function(pos, speed, dir)
	dart = minetest.add_entity(pos, "towers:shot_dart")
	local dir_real = dir
	dir_real.y = 0
	minetest.log("Dart fired!")
	dart:set_velocity(vector.multiply(vector.new(dir_real), vector.new({x=speed,y=0,z=speed})))
end

towers.FireFireDart = function(pos, speed, dir)
	dart = minetest.add_entity(pos, "towers:shot_firedart")
	local dir_real = dir
	dir_real.y = 0
	minetest.log("Firedart fired!")
	dart:set_velocity(vector.multiply(vector.new(dir_real), vector.new({x=speed,y=0,z=speed})))
end

towers.FireTripleDart = function(pos, speed, dir)
	local aimoffset = 0.05
	dart0 = minetest.add_entity(pos, "towers:shot_dart")
	dart1 = minetest.add_entity(pos, "towers:shot_dart")
	dart2 = minetest.add_entity(pos, "towers:shot_dart")
	local dir_real0 = dir
	dir_real0.y = 0
	local dir_real1 = dir_real0
	local dir_real2 = dir_real0
	minetest.log(dump(dir_real2))
	minetest.log(dump(dir_real1))
	minetest.log(dump(dir_real0))
	local aimvector = {z=speed/aimoffset, y=0, x=speed/aimoffset}
	minetest.log("Dart fired!")
	minetest.log("Dart fired!")
	minetest.log("Dart fired!")
	dart0:set_velocity(vector.multiply(vector.new(dir_real0), vector.new({x=speed,y=0,z=speed})))
	dart1:set_velocity(vector.multiply(vector.add(vector.new(dir_real1), vector.new(aimvector)), vector.new({x=speed,y=0,z=speed})))
	dart1:set_velocity(vector.multiply(vector.subtract(vector.new(dir_real1), vector.new(aimvector)), vector.new({x=speed,y=0,z=speed})))
end



minetest.register_craftitem("towers:dart", {
	description = "Throwable Dart",
	inventory_image = "dart.png",
	wield_image = "dart.png",
	on_use = function(itemstack, user, pointed_thing)
		local speed = 30
		local playervector = user:get_look_dir()
		local pos = user:get_pos()
		pos.y = pos.y + 0.8
		towers.FireDart(pos, speed, user:get_look_dir())
	end
})

minetest.register_craftitem("towers:firedart", {
	description = "Throwable Firedart",
	inventory_image = "firedart.png",
	wield_image = "firedart.png",
	on_use = function(itemstack, user, pointed_thing)
		local speed = 30
		local playervector = user:get_look_dir()
		local pos = user:get_pos()
		pos.y = pos.y + 0.8
		towers.FireDart(pos, speed, user:get_look_dir())
	end
})

minetest.register_craftitem("towers:triple_dart", {
	description = "Throwable Triple Darts",
	inventory_image = "3dart.png",
	wield_image = "3dart.png",
	on_use = function(itemstack, user, pointed_thing)
		local speed = 30
		local playervector = user:get_look_dir()
		local pos = user:get_pos()
		pos.y = pos.y + 0.8
		towers.FireTripleDart(pos, speed, user:get_look_dir())
	end
})

minetest.register_chatcommand("dart", {
	params = "",
	description = "Throws a dart out of the player.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local speed = 25
		local playervector = player:get_look_dir()
		local pos = player:get_pos()
		pos.y = pos.y + 0.8
		towers.FireDart(pos, speed, player:get_look_dir())
	end
})
