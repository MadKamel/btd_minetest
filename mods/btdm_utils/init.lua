utils = {}
utils.has_projectiles = function(tab, val)
    for index, value in ipairs(tab) do
	--minetest.log(dump(value:get_luaentity().object))
	if value:is_player() then
		return false
        elseif value:get_luaentity().name == val then
        	return true
        end
    end
    return false
end

utils.get_projectile = function(tab, val)
    for index, value in ipairs(tab) do
        if value:get_luaentity().name == val then
            return value:get_luaentity()
        end
    end
    return nil
end