--todo:   Make a bloon that regrows, depending on a parameter passed to it by the last layer popped.
--      For instance, a lead bloon that leaves behind two black bloons would be passing a parameter {"lead"}
--      or some similar bloon identifier, then those black bloons would themselves pass a parameter {"lead", "black"}
--      to the next generation, the two pink bloons that are inside. Of course, these bloons would be
--      called something more like "regen_lead" instead of just "lead", so that adjustment would be
--      useful. Maybe instead of using the already-made bloons.register_bloon function for making regens,
--      I could make a bloons.register_regen_bloon() function for regens specifically. Of course, they would
--      also need their own PopMe() function... maybe PopMeRegen()?

bloons.register_bloon = function(type, defs)
	minetest.register_entity("bloons:"..type, {
		initial_properties = {
			physical = false,
			collide_with_objects = false,
			visual = "sprite",
			visual_size = {x = defs.size, y = defs.size, z = defs.size},
			textures = {type.."_bloon.png"},
			show_on_minimap = true,
			type = defs.type,
			speed = defs.speed,
			is_armoured = defs.armoured
		},
		on_punch = function(self)
			PopMe(self)
		end,
		on_step = function(self, dtime, moveresult)
			--if CheckForSpikes(self) then --Old Bloon Code
			--	MoveUp(self)
			--end
			if CheckForSpikes(self) then
				if CheckForProjectiles(self) then
					NB_SetVelByHeading(self, NB_CheckHeading(self), self.initial_properties.speed)
				end
			end
		end
	})	
end

bloons.register_moab = function(type, defs) -- Taken straight from the above function
	minetest.register_entity("bloons:moab_"..type, {
		initial_properties = {
			physical = false,
			collide_with_objects = false,
			visual = "sprite",
			visual_size = {x = defs.size, y = defs.size, z = defs.size},
			textures = {type.."_moab.png"},
			show_on_minimap = true,
			type = defs.type,
			speed = defs.speed,
			is_armoured = defs.armoured,
			total_health= defs.health
		},
		on_punch = function(self)
			PopMOAB(self)
		end,
		on_activate = function(self, staticdata)
			self.data = minetest.deserialize(staticdata) or {}
		end,
		get_staticdata = function(self)
			return minetest.serialize(self.data)
		end,
		on_step = function(self, dtime, moveresult)
			self.object:remove()
			--if CheckForSpikes(self) then --Old Bloon Code
			--	MoveUp(self)
			--end
			--if MOABCheckForSpikes(self) then
			--	if MOABCheckForProjectiles(self) then
			--		NB_SetVelByHeading(self, NB_CheckHeading(self), self.initial_properties.speed)
			--	end
			--end
		end
	})	
end

bloons.pop_bloon = function(bloon)
	PopMe(bloon)
end

bloons.add_bloon = function(pos, type)
	minetest.add_entity(vector.add(pos, vector.new(0, 0.5, 0)), "bloons:"..type)
	minetest.log("Spawned "..type.." bloon!")
end



PopMe = function(self)
	minetest.log("Popped bloon!")
	minetest.sound_play({name="bloon_pop"}, {pos=self.object:get_pos()})
	if self.initial_properties.type == 1 then
		minetest.add_entity(self.object:get_pos(), "bloons:red")
	elseif self.initial_properties.type == 2 then
		minetest.add_entity(self.object:get_pos(), "bloons:blue")
	elseif self.initial_properties.type == 3 then
		minetest.add_entity(self.object:get_pos(), "bloons:green")
	elseif self.initial_properties.type == 4 then
		minetest.add_entity(self.object:get_pos(), "bloons:yellow")
	elseif self.initial_properties.type == 5 then
		minetest.add_entity(self.object:get_pos(), "bloons:pink")
		minetest.add_entity(self.object:get_pos(), "bloons:pink")
	elseif self.initial_properties.type == 6 then
		minetest.add_entity(self.object:get_pos(), "bloons:black")
		minetest.add_entity(self.object:get_pos(), "bloons:white")
	elseif self.initial_properties.type == 7 then
		minetest.add_entity(self.object:get_pos(), "bloons:black")
		minetest.add_entity(self.object:get_pos(), "bloons:black")
		minetest.add_entity(self.object:get_pos(), "bloons:white")
		minetest.add_entity(self.object:get_pos(), "bloons:white")
	elseif self.initial_properties.type == 8 then
		minetest.add_entity(self.object:get_pos(), "bloons:black")
		minetest.add_entity(self.object:get_pos(), "bloons:black")
	end
	self.object:remove()
end

PopMOAB = function(self) --Experimental script.
	minetest.log("Popped MOAB!")
	minetest.sound_play({name="bloon_pop"}, {pos=self.object:get_pos()})
	local data = self.deserialize()
	if data.current_health >= 1 then
		data.current_health = data.current_health - 1
	else
		if self.initial_properties.type == 1 then
			minetest.add_entity(self.object:get_pos(), "bloons:red")
		end
		self.object:remove()
	end
end

MOABCheckForProjectiles = function(self)
	obj_nearby = minetest.get_objects_inside_radius(self.object:get_pos(), 1)
	if next(obj_nearby) == nil then
		minetest.log("BLOON DOES NOT EXIST!")
		return true
	else
		local armoured = self.initial_properties.is_armoured or false
		if utils.has_projectiles(obj_nearby, "towers:shot_flame") then
			--minetest.log(dump(obj_nearby))
			local popper = utils.get_projectile(obj_nearby, "towers:shot_flame")
			popper.object:remove()
			PopMOAB(self)
			return false
		elseif utils.has_projectiles(obj_nearby, "towers:shot_firedart") then
			--minetest.log(dump(obj_nearby))
			local popper = utils.get_projectile(obj_nearby, "towers:shot_firedart")
			popper.object:remove()
			PopMOAB(self)
			return false
		elseif not armoured then
			if utils.has_projectiles(obj_nearby, "towers:shot_tack") then
				--minetest.log(dump(obj_nearby))
				local popper = utils.get_projectile(obj_nearby, "towers:shot_tack")
				popper.object:remove()
				PopMOAB(self)
				return false
			elseif utils.has_projectiles(obj_nearby, "towers:shot_dart") then
				--minetest.log(dump(obj_nearby))
				local popper = utils.get_projectile(obj_nearby, "towers:shot_dart")
				popper.object:remove()
				PopMOAB(self)
				return false
			end
		end
	end
	return true
end

MOABCheckForSpikes = function(self)
	local pos = self.object:get_pos()
	local pos_down = vector.subtract(pos, vector.new(0, 1, 0))
	--minetest.log(dump(minetest.get_node(pos_down)))
	if minetest.get_node(pos_down).name == "towers:spikes" then
		towers.RemoveSpike(pos_down)
		PopMOAB(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_4" then
		towers.RemoveSpike(pos_down)
		PopMOAB(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_3" then
		towers.RemoveSpike(pos_down)
		PopMOAB(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_2" then
		towers.RemoveSpike(pos_down)
		PopMOAB(self)
	elseif minetest.get_node(pos_down).name == "towers:spikes_1" then
		towers.RemoveSpike(pos_down)
		PopMOAB(self)
	else
		return true
	end
end

NB_CheckHeading = function(self) -- This function uses context clues to determine the current heading of the track.
	local pos = self.object:get_pos()
	local track = vector.subtract(pos, vector.new(0, 2, 0))
	local trackdir = minetest.get_node(track).param2
	local dest = {y=0,x=0,z=0}
	if minetest.get_node(track).name == "bloons:path" then
		return trackdir
	else
		return -1
	end
end

NB_SetVelByHeading = function(self, heading, speed) -- This function takes the last program's output and turns the bloon accordingly.
	--minetest.log(dump(heading))
	if heading == 0 then
		self.object:set_velocity({x=0, y=0, z=speed})
	elseif heading == 1 then
		self.object:set_velocity({x=speed, y=0, z=0})
	elseif heading == 2 then
		self.object:set_velocity({x=0, y=0, z=0-speed})
	elseif heading == 3 then
		self.object:set_velocity({x=0-speed, y=0, z=0})
	else
		PopMe(self)
	end
end

CheckForProjectiles = function(self)
	obj_nearby = minetest.get_objects_inside_radius(self.object:get_pos(), 1)
	if next(obj_nearby) == nil then
		minetest.log("BLOON DOES NOT EXIST!")
		return true
	else
		local armoured = self.initial_properties.is_armoured or false
		if utils.has_projectiles(obj_nearby, "towers:shot_flame") then
			--minetest.log(dump(obj_nearby))
			local popper = utils.get_projectile(obj_nearby, "towers:shot_flame")
			popper.object:remove()
			PopMe(self)
			return false
		elseif utils.has_projectiles(obj_nearby, "towers:shot_firedart") then
			--minetest.log(dump(obj_nearby))
			local popper = utils.get_projectile(obj_nearby, "towers:shot_firedart")
			popper.object:remove()
			PopMe(self)
			return false
		elseif not armoured then
			if utils.has_projectiles(obj_nearby, "towers:shot_tack") then
				--minetest.log(dump(obj_nearby))
				local popper = utils.get_projectile(obj_nearby, "towers:shot_tack")
				popper.object:remove()
				PopMe(self)
				return false
			elseif utils.has_projectiles(obj_nearby, "towers:shot_dart") then
				--minetest.log(dump(obj_nearby))
				local popper = utils.get_projectile(obj_nearby, "towers:shot_dart")
				popper.object:remove()
				PopMe(self)
				return false
			end
		end
	end
	return true
end

CheckForSpikes = function(self)
	local pos = self.object:get_pos()
	local pos_down = vector.subtract(pos, vector.new(0, 1, 0))
	--minetest.log(dump(minetest.get_node(pos_down)))
	local armoured = self.initial_properties.is_armoured or false
	if minetest.get_node(pos_down).name == "towers:spikes" then
		towers.RemoveSpike(pos_down)
		if not armoured then
			PopMe(self)
		end
	elseif minetest.get_node(pos_down).name == "towers:spikes_4" then
		towers.RemoveSpike(pos_down)
		if not armoured then
			PopMe(self)
		end
	elseif minetest.get_node(pos_down).name == "towers:spikes_3" then
		towers.RemoveSpike(pos_down)
		if not armoured then
			PopMe(self)
		end
	elseif minetest.get_node(pos_down).name == "towers:spikes_2" then
		towers.RemoveSpike(pos_down)
		if not armoured then
			PopMe(self)
		end
	elseif minetest.get_node(pos_down).name == "towers:spikes_1" then
		towers.RemoveSpike(pos_down)
		if not armoured then
			PopMe(self)
		end
	else
		return true
	end
end

NB_CheckHeading = function(self) -- This function uses context clues to determine the current heading of the track.
	local pos = self.object:get_pos()
	local track = vector.subtract(pos, vector.new(0, 2, 0))
	local trackdir = minetest.get_node(track).param2
	local dest = {y=0,x=0,z=0}
	if minetest.get_node(track).name == "bloons:path" then
		return trackdir
	else
		return -1
	end
end

NB_SetVelByHeading = function(self, heading, speed) -- This function takes the last program's output and turns the bloon accordingly.
	--minetest.log(dump(heading))
	if heading == 0 then
		self.object:set_velocity({x=0, y=0, z=speed})
	elseif heading == 1 then
		self.object:set_velocity({x=speed, y=0, z=0})
	elseif heading == 2 then
		self.object:set_velocity({x=0, y=0, z=0-speed})
	elseif heading == 3 then
		self.object:set_velocity({x=0-speed, y=0, z=0})
	else
		PopMe(self)
	end
end

MoveUp = function(self)
	local pos = self.object:get_pos()
	--minetest.log(dump(pos))
	local pos_down = vector.subtract(pos, vector.new(0, 1, 0))
	local track = vector.subtract(pos, vector.new(0, 2, 0))
	local trackdir = minetest.get_node(track).param2
	local dest = {y=0,x=0,z=0}
	if minetest.get_node(track).name == "bloons:path" then
		if trackdir == 0 then
			dest = vector.add(pos, vector.new(0, 0, 1))
		elseif trackdir == 1 then
			dest = vector.add(pos, vector.new(1, 0, 0))
		elseif trackdir == 2 then
			dest = vector.subtract(pos, vector.new(0, 0, 1))
		elseif trackdir == 3 then
			dest = vector.subtract(pos, vector.new(1, 0, 0))
		end
	else
		PopMe(self)
	end
	self.object:move_to(dest)
end
