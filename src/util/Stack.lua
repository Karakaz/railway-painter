
local Stack = {}

function Stack:create()

    local stack = {}
    stack.elements = {}

    function stack:push(...)
        if ... then
            local targs = {...}
            for _,v in ipairs(targs) do
                table.insert(self.elements, v)
            end
        end
    end

    function stack:pop(num)

        local num = num or 1

        local entries = {}

        for i = 1, num do
            if #self.elements ~= 0 then
                table.insert(entries, self.elements[#self.elements])
                table.remove(self.elements)
            else
                break
            end
        end
        return unpack(entries)
    end

    function stack:peek()
        return self.elements[self:size()]
    end

    function stack:remove(element)
        for i,v in pairs(self.elements) do
            if v == element then
                table.remove(self.elements, i)
            end
        end
    end

    function stack:size()
        return #self.elements
    end

    function stack:contains(element)
        for _,v in pairs(self.elements) do
            if v == element then
                return true
            end
        end
    end
    return stack
end

return Stack