
local Stack = require("src/util/Stack")

local ErrorHandler = {}

function ErrorHandler:registerErrorLabel(errorLabel)
    self.errorLabel = errorLabel
end

function ErrorHandler:setError(error)
    if not self.errorStack:contains(error) then
        self.errorStack:push(error)
        self.errorLabel.caption = self.errorStack:peek()
    end
end

function ErrorHandler:clearError(error)
    if self.errorStack:contains(error) then
        self.errorStack:remove(error)
        if self.errorStack:size() > 0 then
            self.errorLabel.caption = self.errorStack:peek()
        else
            self.errorLabel.caption = ""
        end
    end
end

function ErrorHandler.new()
    local self = Object.new(ErrorHandler)
    self.errorStack = Stack:create()
    return self
end

return ErrorHandler