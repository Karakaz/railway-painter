
local entity_util = {}

function entity_util.getCenterOfEntity(entity)
    local leftTop = entity.bounding_box.left_top
    local rightBottom = entity.bounding_box.right_bottom
    return {x = (leftTop.x + rightBottom.x) / 2,
            y = (leftTop.y + rightBottom.y) / 2}
end

return entity_util