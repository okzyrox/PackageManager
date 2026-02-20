local roblox = require("@lune/roblox")
local Tree = require("../../../src/Tree")

return {
    Tests = {
        ["getInstanceProperties extracts basic properties"] = function()
            local part = roblox.Instance.new("Part")
            part.Transparency = 0.5
            part.Anchored = true
            local props = Tree.getInstanceProperties(part)
            assert(props.Transparency == 0.5, "Expected 0.5 Transparency")
            assert(props.Anchored == true, "Expected to be Anchored")
            assert(props.CastShadow == nil, "Expected CastShadow to be ignored as default")
        end,
        ["getInstanceProperties includes tags"] = function()
            local part = roblox.Instance.new("Part")
            part:AddTag("Important")
            part:AddTag("Collectible")
            local props = Tree.getInstanceProperties(part)
            assert(props.Tags ~= nil, "Expected Tags")
            assert(#props.Tags == 2, "Expected all tags")
            assert(table.find(props.Tags, "Important"), "Expected tag 1")
            assert(table.find(props.Tags, "Collectible"), "Expected tag 2")
        end,
        ["getInstanceProperties skips default values"] = function()
            local part = roblox.Instance.new("Part")
            local props = Tree.getInstanceProperties(part)
            assert(props.CastShadow == nil, "Expected CastShadow property to be ignored")
            assert(props.Material ~= nil, "Expected Material property")
        end,
        ["addInstanceProperties applies properties (simple)"] = function()
            local part = roblox.Instance.new("Part")
            Tree.addInstanceProperties(part, {
                Transparency = 0.75,
                Anchored = true,
            })
            assert(part.Transparency == 0.75, "Expected 0.75 Transparency")
            assert(part.Anchored == true, "Expected to be Anchored")
        end,
    }
}
