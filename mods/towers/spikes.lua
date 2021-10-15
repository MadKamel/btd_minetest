minetest.register_node("towers:spikes", {
	drawtype = "raillike",
	paramtype = "light",
	walkable = false,
	description = "Road Spikes",
	tiles = {"spikes.png"},
	groups = {spikes=1, oddly_breakable_by_hand=3},
})

minetest.register_node("towers:spikes_4", {
	drawtype = "raillike",
	paramtype = "light",
	walkable = false,
	description = "Road Spikes (4 left)",
	tiles = {"spikes_4.png"},
	groups = {spikes=1, oddly_breakable_by_hand=3},
})

minetest.register_node("towers:spikes_3", {
	drawtype = "raillike",
	paramtype = "light",
	walkable = false,
	description = "Road Spikes (3 left)",
	tiles = {"spikes_3.png"},
	groups = {spikes=1, oddly_breakable_by_hand=3},
})

minetest.register_node("towers:spikes_2", {
	drawtype = "raillike",
	paramtype = "light",
	walkable = false,
	description = "Road Spikes (2 left)",
	tiles = {"spikes_2.png"},
	groups = {spikes=1, oddly_breakable_by_hand=3},
})

minetest.register_node("towers:spikes_1", {
	drawtype = "raillike",
	paramtype = "light",
	walkable = false,
	description = "Road Spike (1 left)",
	tiles = {"spikes_1.png"},
	groups = {spikes=1, oddly_breakable_by_hand=3},
})

function towers.RemoveSpike(pos)
	local node = minetest.get_node(pos)
	--minetest.log("chat", dump(node))
	--minetest.log("chat", node.name)
	if node.name == "towers:spikes" then
		minetest.swap_node(pos, {name="towers:spikes_4"})
	elseif node.name == "towers:spikes_4" then
		minetest.swap_node(pos, {name="towers:spikes_3"})
	elseif node.name == "towers:spikes_3" then
		minetest.swap_node(pos, {name="towers:spikes_2"})
	elseif node.name == "towers:spikes_2" then
		minetest.swap_node(pos, {name="towers:spikes_1"})
	elseif node.name == "towers:spikes_1" then
		minetest.swap_node(pos, {name="air"})
	end
end

minetest.register_craftitem("towers:spike_popper", {
	description = "Spike Popper!",
	inventory_image = "popper.png",
	wield_image = "popper.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			--minetest.log("chat", dump(pointed_thing.under))
			towers.RemoveSpike(pointed_thing.under)
		end
	end
})