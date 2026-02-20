local TreeDataTypes = require("../../../src/TreeDataTypes")
local roblox = require("@lune/roblox")

return {
    Tests = {
        ["Color3 Ser and Des"] = function()
            local color = roblox.Color3.new(1, 0.5, 0.25)
            local serialised = TreeDataTypes["Color3"].Ser(color)
            assert(serialised.Color3 ~= nil, "Expected Color3 key")
            assert(#serialised.Color3 == 3, "Expected 3 color components")
            local deserialised = TreeDataTypes["Color3"].Des(serialised)
            assert(deserialised.R == color.R, "R component mismatch")
            assert(deserialised.G == color.G, "G component mismatch")
            assert(deserialised.B == color.B, "B component mismatch")
        end,
        ["Vector2 Ser and Des"] = function()
            local vector = roblox.Vector2.new(10, 20)
            local serialised = TreeDataTypes["Vector2"].Ser(vector)
            assert(serialised.Vector2 ~= nil, "Expected Vector2 key")
            assert(#serialised.Vector2 == 2, "Expected 2 components")
            local deserialised = TreeDataTypes["Vector2"].Des(serialised)
            assert(deserialised.X == vector.X, "X component mismatch")
            assert(deserialised.Y == vector.Y, "Y component mismatch")
        end,
        ["Vector3 Ser and Des"] = function()
            local vector = roblox.Vector3.new(1, 2, 3)
            local serialised = TreeDataTypes["Vector3"].Ser(vector)
            assert(serialised.Vector3 ~= nil, "Expected Vector3 key")
            assert(#serialised.Vector3 == 3, "Expected 3 components")
            local deserialised = TreeDataTypes["Vector3"].Des(serialised)
            assert(deserialised.X == vector.X, "X component mismatch")
            assert(deserialised.Y == vector.Y, "Y component mismatch")
            assert(deserialised.Z == vector.Z, "Z component mismatch")
        end,
        ["Vector2int16 Ser and Des"] = function()
            local vector = roblox.Vector2int16.new(100, 200)
            local serialised = TreeDataTypes["Vector2int16"].Ser(vector)
            assert(serialised.Vector2int16 ~= nil, "Expected Vector2int16 key")
            local deserialised = TreeDataTypes["Vector2int16"].Des(serialised)
            assert(deserialised.X == vector.X, "X component mismatch")
            assert(deserialised.Y == vector.Y, "Y component mismatch")
        end,
        ["Vector3int16 Ser and Des"] = function()
            local vector = roblox.Vector3int16.new(10, 20, 30)
            local serialised = TreeDataTypes["Vector3int16"].Ser(vector)
            assert(serialised.Vector3int16 ~= nil, "Expected Vector3int16 key")
            local deserialised = TreeDataTypes["Vector3int16"].Des(serialised)
            assert(deserialised.X == vector.X, "X component mismatch")
            assert(deserialised.Y == vector.Y, "Y component mismatch")
            assert(deserialised.Z == vector.Z, "Z component mismatch")
        end,
        ["UDim Ser and Des"] = function()
            local udim = roblox.UDim.new(0.5, 100)
            local serialised = TreeDataTypes["UDim"].Ser(udim)
            assert(serialised.UDim ~= nil, "Expected UDim key")
            assert(#serialised.UDim == 2, "Expected 2 components")
            local deserialised = TreeDataTypes["UDim"].Des(serialised)
            assert(deserialised.Scale == udim.Scale, "Scale mismatch")
            assert(deserialised.Offset == udim.Offset, "Offset mismatch")
        end,
        ["UDim2 Ser and Des"] = function()
            local udim2 = roblox.UDim2.new(roblox.UDim.new(0.5, 100), roblox.UDim.new(0.75, 50))
            local serialised = TreeDataTypes["UDim2"].Ser(udim2)
            assert(serialised.UDim2 ~= nil, "Expected UDim2 key")
            assert(#serialised.UDim2 == 2, "Expected 2 UDim components")
            local deserialised = TreeDataTypes["UDim2"].Des(serialised)
            assert(deserialised.X.Scale == udim2.X.Scale, "X Scale mismatch")
            assert(deserialised.X.Offset == udim2.X.Offset, "X Offset mismatch")
            assert(deserialised.Y.Scale == udim2.Y.Scale, "Y Scale mismatch")
            assert(deserialised.Y.Offset == udim2.Y.Offset, "Y Offset mismatch")
        end,
        ["NumberRange Ser and Des"] = function()
            local range = roblox.NumberRange.new(10, 100)
            local serialised = TreeDataTypes["NumberRange"].Ser(range)
            assert(serialised.NumberRange ~= nil, "Expected NumberRange key")
            assert(#serialised.NumberRange == 2, "Expected 2 components")
            local deserialised = TreeDataTypes["NumberRange"].Des(serialised)
            assert(deserialised.Min == range.Min, "Min mismatch")
            assert(deserialised.Max == range.Max, "Max mismatch")
        end,
        ["CFrame Ser and Des"] = function()
            local cframe = roblox.CFrame.new(5, 10, 15)
            local serialised = TreeDataTypes["CFrame"].Ser(cframe)
            assert(serialised.CFrame ~= nil, "Expected CFrame key")
            assert(serialised.CFrame.position ~= nil, "Expected position")
            assert(serialised.CFrame.orientation ~= nil, "Expected orientation")
            local deserialised = TreeDataTypes["CFrame"].Des(serialised)
            assert(deserialised.Position.X == cframe.Position.X, "Position X mismatch")
            assert(deserialised.Position.Y == cframe.Position.Y, "Position Y mismatch")
            assert(deserialised.Position.Z == cframe.Position.Z, "Position Z mismatch")
        end,
        ["Axes serialise"] = function()
            local axes = roblox.Axes.new(roblox.Enum.Axis.X, roblox.Enum.Axis.Z)
            local serialised = TreeDataTypes["Axes"].Ser(axes)
            assert(serialised.Axes ~= nil, "Expected Axes key")
            assert(type(serialised.Axes) == "table", "Expected Axes to be a table")
            assert(table.find(serialised.Axes, "X"), "Expected X in serialised axes")
            assert(table.find(serialised.Axes, "Z"), "Expected Z in serialised axes")
            assert(not table.find(serialised.Axes, "Y"), "Expected Y not in serialised axes")
        end,
        -- Disabled: roblox implementation causes errors when nil is provided
        -- so safely deserialising is difficult
        -- ["Axes deserialise"] = function()
        --     local axesData = { "X", "Y" }
        --     local deserialised = TreeDataTypes["Axes"].Des({ Axes = axesData })
        --     assert(deserialised.X == true, "Expected X to be true")
        --     assert(deserialised.Y == true, "Expected Y to be true")
        --     assert(deserialised.Z == false, "Expected Z to be false")
        -- end,
        ["Content Ser and Des"] = function()
            local content = roblox.Content.fromUri("rbxasset://example.png")
            local serialised = TreeDataTypes["Content"].Ser(content)
            assert(serialised.Content ~= nil, "Expected Content key")
            assert(type(serialised.Content) == "string", "Expected Content to be a string")
            local deserialised = TreeDataTypes["Content"].Des(serialised)
            assert(deserialised.Uri == content.Uri, "Uri mismatch")
        end,
        ["NumberSequence Ser and Des"] = function()
            local keypoints = {
                roblox.NumberSequenceKeypoint.new(0, 0),
                roblox.NumberSequenceKeypoint.new(0.5, 1),
                roblox.NumberSequenceKeypoint.new(1, 0),
            }
            local sequence = roblox.NumberSequence.new(keypoints)
            local serialised = TreeDataTypes["NumberSequence"].Ser(sequence)
            assert(serialised.NumberSequence ~= nil, "Expected NumberSequence key")
            assert(serialised.NumberSequence.keypoints ~= nil, "Expected keypoints")
            local deserialised = TreeDataTypes["NumberSequence"].Des(serialised)
            assert(#deserialised.Keypoints == #sequence.Keypoints, "Keypoint count mismatch")
        end,
        ["ColorSequence Ser and Des"] = function()
            local keypoints = {
                roblox.ColorSequenceKeypoint.new(0, roblox.Color3.new(1, 0, 0)),
                roblox.ColorSequenceKeypoint.new(1, roblox.Color3.new(0, 0, 1)),
            }
            local sequence = roblox.ColorSequence.new(keypoints)
            local serialised = TreeDataTypes["ColorSequence"].Ser(sequence)
            assert(serialised.ColorSequence ~= nil, "Expected ColorSequence key")
            assert(serialised.ColorSequence.keypoints ~= nil, "Expected keypoints")
            local deserialised = TreeDataTypes["ColorSequence"].Des(serialised)
            assert(#deserialised.Keypoints == #sequence.Keypoints, "Keypoint count mismatch")
        end,
        
        ["validateAttributeName accepts valid names"] = function()
            local valid = TreeDataTypes.validateAttributeName("ValidName123")
            assert(valid == true, "Expected true for valid name")
        end,
        ["validateAttributeName accepts names with allowed chars"] = function()
            local valid = TreeDataTypes.validateAttributeName("Valid_Name.123-test/path")
            assert(valid == true, "Expected true for name with allowed chars")
        end,
        ["validateAttributeName rejects invalid chars"] = function()
            local valid = TreeDataTypes.validateAttributeName("Invalid@Name")
            assert(valid == false, "Expected false for invalid char @")
        end,
    }
}
