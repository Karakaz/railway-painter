
local Object = {}

function Object.new(class)
    local instance = {}

    for k,v in pairs(class) do
        if not (type(k) == 'function' and k == 'new') then
            instance[k] = v
        end
    end

    return instance
end

return Object