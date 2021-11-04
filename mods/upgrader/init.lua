upgrades = {}
upgrades.tack_shooter = {"towers:tack_shooter", "towers:tack_shooter_large", "towers:flame_shooter"}

-- register upgrader node, and money.
minetest.register_node("upgrader:upgrader", {
	description = "Node Upgrader",
	tiles = {"upgrader.png"},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local name = ""
		local formspec = "formspec_version[4]size[10.5,7]label[1.1,0.4;Input]list[context;input;1,0.7;1,1;0]list[context;output;4.4,0.7;1,1;0]image_button[2.2,0.7;2,1;gui_upgrader_accept;okbutton;Upgrade!;false;true;]label[4.4,0.4;Output]list[current_player;main;0.4,1.9;8,4;0]"
		local inv = meta:get_inventory()
		inv:set_size("input", 1*1)
		inv:set_size("output", 1*1)
		meta:set_string("infotext", "Node Upgrader")
		meta:set_string("formspec", formspec)
	end,
	groups = {oddly_breakable_by_hand=3}
})

