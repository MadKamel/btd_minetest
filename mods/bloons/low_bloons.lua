PopMe = function(self)
	if self.initial_properties.type == 1 then
		minetest.add_entity(self.object:get_pos(), "bloons:red")
	elseif self.initial_properties.type == 2 then
		minetest.add_entity(self.object:get_pos(), "bloons:blue")
	elseif self.initial_properties.type == 3 then
		minetest.add_entity(self.object:get_pos(), "bloons:green")
	elseif self.initial_properties.type == 4 then
		minetest.add_entity(self.object:get_pos(), "bloons:yellow")
	end
	self.object:remove()
end

bloon_get_next_keyframe = function(self)
	local pos = self.object:get_pos()
	--minetest.log("chat", dump(pos))
	local pos_down = vector.subtract(pos, vector.new(0, 1, 0))
	local track = vector.subtract(pos, vector.new(0, 2, 0))
	local trackdir = minetest.get_node(track).param2
	if minetest.get_node(track).name == "bloons:path" then
		if trackdir == 0 then
			return vector.add(pos, vector.new(0, 0, 1))
		elseif trackdir == 1 then
			return vector.add(pos, vector.new(1, 0, 0))
		elseif trackdir == 2 then
			return vector.subtract(pos, vector.new(0, 0, 1))
		elseif trackdir == 3 then
			return vector.subtract(pos, vector.new(1, 0, 0))
		else
			return {y=0, x=0, z=0}
		end
	else
		return {y=0, x=0, z=0}

	end
end

bloon_syspanic = function(self)
	self.object:remove()
end

bloon_checkforspikes = function(self)
	local pos = self.object:get_pos()
	local pos_down = vector.subtract(pos, vector.new(0, 1, 0))
	if minetest.get_node(pos_down).name == "towers:spikes" then
		towers.RemoveSpike(pos_down)
		PopMe(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_4" then
		towers.RemoveSpike(pos_down)
		PopMe(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_3" then
		towers.RemoveSpike(pos_down)
		PopMe(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_2" then
		towers.RemoveSpike(pos_down)
		PopMe(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_1" then
		towers.RemoveSpike(pos_down)
		PopMe(self)
	end
end

bloon_thinknext = function(self, dtime, moveresult)
	local destination = bloon_get_next_keyframe(self)
	if destination == {y=0, x=0, z=0} then
		bloon_syspanic(self)
	else
		--minetest.log("chat", dump(destination))
		self.object:move_to(destination)
	end
end



minetest.register_entity("bloons:red", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"red_bloon.png"},
		show_on_minimap = true,
		waittime = 10,
		counter = 0,
		type = 0
	},
	on_step = function(self, dtime, moveresult)
		--bloon_syspanic(self)
		self.initial_properties.counter = self.initial_properties.counter + 1
		--minetest.log(self.initial_properties.counter)
		bloon_checkforspikes(self)
		if self.initial_properties.counter > self.initial_properties.waittime then
			bloon_thinknext(self, dtime, moveresult)
			self.initial_properties.counter = 0
		end
	end
})

minetest.register_entity("bloons:blue", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"blue_bloon.png"},
		show_on_minimap = true,
		waittime = 9,
		counter = 0,
		type = 1
	},
	on_step = function(self, dtime, moveresult)
		--bloon_syspanic(self)
		self.initial_properties.counter = self.initial_properties.counter + 1
		--minetest.log(self.initial_properties.counter)
		bloon_checkforspikes(self)
		if self.initial_properties.counter > self.initial_properties.waittime then
			bloon_thinknext(self, dtime, moveresult)
			self.initial_properties.counter = 0
		end
	end
})

minetest.register_entity("bloons:green", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"green_bloon.png"},
		show_on_minimap = true,
		waittime = 8,
		counter = 0,
		type = 2
	},
	on_step = function(self, dtime, moveresult)
		--bloon_syspanic(self)
		self.initial_properties.counter = self.initial_properties.counter + 1
		--minetest.log(self.initial_properties.counter)
		bloon_checkforspikes(self)
		if self.initial_properties.counter > self.initial_properties.waittime then
			bloon_thinknext(self, dtime, moveresult)
			self.initial_properties.counter = 0
		end
	end
})

minetest.register_entity("bloons:yellow", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"yellow_bloon.png"},
		show_on_minimap = true,
		waittime = 7,
		counter = 0,
		type = 3
	},
	on_step = function(self, dtime, moveresult)
		--bloon_syspanic(self)
		self.initial_properties.counter = self.initial_properties.counter + 1
		--minetest.log(self.initial_properties.counter)
		bloon_checkforspikes(self)
		if self.initial_properties.counter > self.initial_properties.waittime then
			bloon_thinknext(self, dtime, moveresult)
			self.initial_properties.counter = 0
		end
	end
})

minetest.register_entity("bloons:pink", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x = 1, y = 1, z = 1},
		textures = {"pink_bloon.png"},
		show_on_minimap = true,
		waittime = 6,
		counter = 0,
		type = 4
	},
	on_step = function(self, dtime, moveresult)
		--bloon_syspanic(self)
		self.initial_properties.counter = self.initial_properties.counter + 1
		--minetest.log(self.initial_properties.counter)
		bloon_checkforspikes(self)
		if self.initial_properties.counter > self.initial_properties.waittime then
			bloon_thinknext(self, dtime, moveresult)
			self.initial_properties.counter = 0
		end
	end
})



minetest.register_craftitem("bloons:bloonmover", {
	description = "Bloon Prod!",
	inventory_image = "popper.png",
	wield_image = "popper.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "object" then
			local pos = pointed_thing.ref:get_pos()
			pointed_thing.ref:move_to({ x = pos.x+1, y = pos.y, z = pos.z })
		elseif pointed_thing.type == "node" then
			minetest.log("chat", minetest.get_node(pointed_thing.under).param2)
		end
	end
})