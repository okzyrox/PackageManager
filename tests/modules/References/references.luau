local roblox = require("@lune/roblox")
local Util = require("../../../src/Util")
local Tree = require("../../../src/Tree")

return {
    Tests = {
        ["getInstancePath single instance path"] = function()
            local folder = roblox.Instance.new("Folder")
            folder.Name = "TestFolder"
            local path = Util.getInstancePath(folder)
            assert(path == "TestFolder", "Expected 'TestFolder', got " .. path)
        end,
        ["getInstancePath nested path"] = function()
            local parent = roblox.Instance.new("Folder")
            parent.Name = "Parent"
            local child = roblox.Instance.new("Folder")
            child.Name = "Child"
            child.Parent = parent
            local path = Util.getInstancePath(child)
            assert(path == "Parent/Child", "Expected 'Parent/Child', got " .. path)
        end,
        ["getInstanceFromPath find correct instance w/ path"] = function()
            local root = roblox.Instance.new("Folder")
            root.Name = "Root"
            local child1 = roblox.Instance.new("Folder")
            child1.Name = "Child1"
            child1.Parent = root
            local child2 = roblox.Instance.new("Folder")
            child2.Name = "Child2"
            child2.Parent = child1
            local found = Util.getInstanceFromPath(root, "Root/Child1/Child2")
            assert(found ~= nil, "Expected to find instance")
            assert(found == child2, "Expected to find Child2")
        end,
        ["getInstanceFromPath invalid path"] = function()
            local root = roblox.Instance.new("Folder")
            root.Name = "Root"
            local found = Util.getInstanceFromPath(root, "Root/NonExistent")
            assert(found == nil, "Expected nil for invalid path")
        end,
        ["getRefPathAttrName attribute name for reference property"] = function()
            local attrName = Tree.getRefPathAttrName("ObjectValue")
            assert(attrName == "Repackage_ObjectValue_RefPath", "Expected 'Repackage_ObjectValue_RefPath', got " .. attrName)
        end,
        ["addInstanceProperties: attributes"] = function()
            local part = roblox.Instance.new("Part")
            Tree.addInstanceProperties(part, {
                Attributes = {
                    Name = { String = "test_value" },
                    Num = { Float64 = 1234 },
                }
            })
            assert(part:GetAttribute("Name") == "test_value", "Expected 'test_value'")
            assert(part:GetAttribute("Num") == 1234, "Expected 1234")
        end,
        ["addInstanceProperties: tags"] = function()
            local part = roblox.Instance.new("Part")
            Tree.addInstanceProperties(part, {
                Tags = { "Tag1", "Tag2", "Tag3" }
            })
            local tags = part:GetTags()
            assert(#tags == 3, "Expected 3 tags, got " .. #tags)
            assert(table.find(tags, "Tag1"), "Expected Tag1")
            assert(table.find(tags, "Tag2"), "Expected Tag2")
            assert(table.find(tags, "Tag3"), "Expected Tag3")
        end,
        ["resolvePropertyRefs resolves reference"] = function()
            local root = roblox.Instance.new("Folder")
            root.Name = "Root"
            local target = roblox.Instance.new("Part")
            target.Name = "Target"
            target.Parent = root
            local objectValue = roblox.Instance.new("ObjectValue")
            objectValue.Name = "ObjectValue"
            objectValue.Parent = root
            objectValue:SetAttribute("Repackage_Value_RefPath", "Root/Target")
            local hasUnresolved = Tree.resolvePropertyRefs(objectValue, root, false)
            assert(hasUnresolved == false, "Expected no unresolved refs")
            assert(objectValue.Value == target, "Expected Value to reference Target")
        end,
        ["resolvePropertyRefs invalid reference"] = function()
            local root = roblox.Instance.new("Folder")
            root.Name = "Root"
            local objectValue = roblox.Instance.new("ObjectValue")
            objectValue.Name = "ObjectValue"
            objectValue.Parent = root
            objectValue:SetAttribute("Repackage_Value_RefPath", "Root/SomeUnknownReference")
            local hasUnresolved = Tree.resolvePropertyRefs(objectValue, root, false)
            assert(hasUnresolved == true, "Expected unresolved refs")
        end,
    }
}
