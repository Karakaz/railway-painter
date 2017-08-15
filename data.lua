
data.raw["gui-style"].default["railway-painter_gui_button"] = {
    type = "button_style",
    parent = "button_style",
    font = "railway-painter_small_font"
}

data:extend({
    {
        type = "font",
        name = "railway-painter_small_font",
        from = "default",
        size = 14
    },
    {
        type = "item",
        name = "railway-painter_icon_item",
        icon = "__railway-painter__/resources/railway-painter_logo_32.png",
        flags = {"hidden"},
        stack_size = 1
    },
    {
        type = "tile",
        name = "blank",
        collision_mask = {"ground-tile"},
        layer = 70,
        variants = {
            main = {
                {
                    picture = "__railway-painter__/resources/blank_32.png",
                    count = 1,
                    size = 1
                },
                {
                    picture = "__railway-painter__/resources/blank_128.png",
                    count = 1,
                    size = 4
                },
            },
            inner_corner = {
                picture = "",
                count = 0
            },
            outer_corner = {
                picture = "",
                count = 0
            },
            side = {
                picture = "",
                count = 0
            }
        },
        map_color = {r = 0, g = 0, b = 0},
        ageing = 0
    },
    {
        type = "technology",
        name = "railway-painter_technology",
        icon = "__railway-painter__/resources/railway-painter_logo_128.png",
        icon_size = 128,
        prerequisites = {"automated-rail-transportation"},
        unit = {
            count = 100,
            ingredients = {
                {"science-pack-1", 1},
                {"science-pack-2", 1}
            },
            time = 30
        }
    }
})
