local Tree = require("../../../src/Tree")
local roblox = require("@lune/roblox")

return {
    Tests = {
        ["getAttributePropertyValue: string"] = function()
            local value = Tree.getAttributePropertyValue("test")
            assert(value.String == "test", "Expected String key with 'test'")
        end,
        ["getAttributePropertyValue: number"] = function()
            local value = Tree.getAttributePropertyValue(1234)
            assert(value.Float64 == 1234, "Expected Float64 key with 1234")
        end,
        ["getAttributePropertyValue: boolean"] = function()
            local value = Tree.getAttributePropertyValue(true)
            assert(value.Bool == true, "Expected Bool key with true")
        end
    }
}
