minetest.register_node("towers:spike_factory", {
	description = "Spike Factory",
	tiles = {"factory_top.png", "factory_bottom.png", "factory_side.png"},
	groups = {oddly_breakable_by_hand=3}
})

minetest.register_node("towers:spike_factory_open", {
	description = "Open Spike Factory",
	tiles = {"factory_top_open.png", "factory_bottom.png", "factory_side.png"},
	groups = {oddly_breakable_by_hand=3, spike_maker=1},
	drop = "towers:spike_factory"
})



minetest.register_abm({
	nodenames = {"group:path"},
	neighbors = {"group:spike_maker"},
	interval = 1,
	chance = 2,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local pos = {x = pos.x, y = pos.y + 1, z = pos.z}
		minetest.set_node(pos, {name = "towers:spikes"})
	end
})

minetest.register_abm({
	nodenames = {"towers:spike_factory"},
	interval = 4,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		minetest.set_node(pos, {name = "towers:spike_factory_open"})
	end
})

minetest.register_abm({
	nodenames = {"towers:spike_factory_open"},
	interval = 0.1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		minetest.set_node(pos, {name = "towers:spike_factory"})
	end
})