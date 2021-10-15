upgrades = {}
upgrades.tack_shooter = {"towers:tack_shooter", "towers:flame_shooter"}

-- register upgrader node, and money.
minetest.register_node("upgrader:upgrader", {
	description = "Node Upgrader",
	tiles = {"upgrader.png"},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local name = ""
		local formspec = "formspec_version[4]size[3,5]label[1.1,0.4;Input]list[inv;input;1,0.7;1,1;0]list[inv;output;1,3.1;1,1;0]image_button[0.5,1.9;2,1;gui_upgrader_accept;okbutton;Upgrade!;false;true;]label[1,4.4;Output]"
		local inv = meta:get_inventory()
		inv:set_size("input", 1*1)
		inv:set_size("output", 1*1)
		meta:set_string("infotext", "Node Upgrader")
		meta:set_string("formspec", formspec)
	end,
	groups = {oddly_breakable_by_hand=3}
})

