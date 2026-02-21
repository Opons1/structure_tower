structure_tower = {}
structure_tower.floors = {
    "tower_ores.mts",
    "tower_farm.mts",
    "tower_hot.mts",
}
function structure_tower.generate(pos)
    core.remove_node(pos)
    for i = 0, 50 do
        core.emerge_area({x=pos.x, y=pos.y+i*8, z=pos.z}, {x=pos.x+15, y=pos.y+(i+1)*8-1, z=pos.z+15})
        if i == 0 then
            core.place_schematic({x=pos.x, y=pos.y, z=pos.z}, core.get_modpath("structure_tower").."/schematics/tower_base.mts", "0", nil, true)
        else
            core.place_schematic({x=pos.x, y=pos.y+i*8, z=pos.z}, core.get_modpath("structure_tower").."/schematics/"..structure_tower.floors[math.random(#structure_tower.floors)], "0", nil, true)
        end
    end
end
core.register_node("structure_tower:temp",{
    tiles = {"default_stone.png"},
    description = "Temporary Tower Node",
    groups = {cracky = 3},
    on_construct = function(pos)
            structure_tower.generate(pos)
    end,
})
--WIP TEXTURE
core.register_node("structure_tower:loot_farm",{
    tiles = {"default_chest_inside.png"},
    description = "Temporary Tower Decoration",
    groups = {oddly_breakable_by_hand = 1},
    drop = {
        max_items = 40, 
        items = {
            {items = {"default:apple 3"}, rarity = 2},
            {items = {"default:coal_lump 2"}, rarity = 2},
            {items = {"default:hoe_wood"}, rarity = 5},
            {items = {"bucket:bucket_water"}, rarity = 5},
            {items = {"farming:seed_cotton 3"}, rarity = 2},
            {items = {"farming:seed_wheat 3"}, rarity = 2},
    }
    },
})
core.register_decoration({
    name = "structure_tower:temp_decoration",
    deco_type = "simple",
    place_on = {"default:dirt_with_grass"},
    sidelen = 16,
    fill_ratio = 0.01,
    y_max = 31000,
    y_min = -31000,
    decoration = "structure_tower:temp",
    place_desc = "structure_tower:temp",
})
core.register_lbm({
    name = "structure_tower:temp_lbm",
    nodenames = {"structure_tower:temp"},
    run_at_every_load = true,
    action = function(pos, node)
        core.remove_node(pos)
        structure_tower.generate(pos)
    end,
})