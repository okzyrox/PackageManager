local Util = require("../../../src/Util")

return {
    Tests = {
        ["safeDirName replaces invalid characters"] = function()
            local safe = Util.safeDirName("test<>file")
            assert(safe == "test__file", "Expected 'test__file', got " .. safe)
        end,
        ["stringStartsWith hello"] = function()
            local result = Util.stringStartsWith("hello world", "hello")
            assert(result == true, "Expected true")
        end,
        ["stringEndsWith .luau"] = function()
            local result = Util.stringEndsWith("hello.luau", ".luau")
            assert(result == true, "Expected true")
        end,
        ["joinPathParts single path"] = function()
            local path = Util.joinPathParts("src", "modules")
            assert(path == "src/modules", "Expected 'src/modules', got " .. path)
        end,
        ["joinPathParts multiple paths"] = function()
            local path = Util.joinPathParts("src", "modules", "test.luau")
            assert(path == "src/modules/test.luau", "Expected 'src/modules/test.luau', got " .. path)
        end,
        ["joinPathParts trailing slashes"] = function()
            local path = Util.joinPathParts("src/", "/modules/", "test.luau")
            assert(path == "src/modules/test.luau", "Expected 'src/modules/test.luau', got " .. path)
        end,
        ["stringIsAlphanumeric returns true"] = function()
            local result = Util.stringIsAlphanumeric("test123")
            assert(result == true, "Expected true")
        end,
        ["stringIsAlphanumeric returns false"] = function()
            local result = Util.stringIsAlphanumeric("test-123")
            assert(result == false, "Expected false")
        end,
        ["stringChars string"] = function()
            local chars = Util.stringChars("abc")
            assert(#chars == 3, "Expected 3 chars")
            assert(chars[1] == "a", "Expected 'a'")
            assert(chars[2] == "b", "Expected 'b'")
            assert(chars[3] == "c", "Expected 'c'")
        end,
        ["stringCombine joins default sep"] = function()
            local result = Util.stringCombine({"hello", "world"}, " ")
            assert(result == "hello world", "Expected 'hello world', got " .. result)
        end,
        ["getScriptTypeFromName client script"] = function()
            local scriptType = Util.getScriptTypeFromName("script.client.luau")
            assert(scriptType == "LocalScript", "Expected 'LocalScript', got " .. tostring(scriptType))
        end,
        ["getScriptTypeFromName server script"] = function()
            local scriptType = Util.getScriptTypeFromName("script.server.luau")
            assert(scriptType == "Script", "Expected 'Script', got " .. tostring(scriptType))
        end,
        ["getScriptTypeFromName module script"] = function()
            local scriptType = Util.getScriptTypeFromName("module.luau")
            assert(scriptType == "ModuleScript", "Expected 'ModuleScript', got " .. tostring(scriptType))
        end,
        ["getScriptTypeFromName non-script"] = function()
            local scriptType = Util.getScriptTypeFromName("file.txt")
            assert(scriptType == nil, "Expected nil")
        end,
        ["randomInt within range"] = function()
            local random = Util.randomInt(10, 20)
            assert(random >= 10 and random <= 20, "Expected number between 10 and 20, got " .. random)
        end,
        ["randomIntOfLength correct length"] = function()
            local random = Util.randomIntOfLength(3)
            assert(random >= 100 and random <= 999, "Expected 3 digit number, got " .. random)
        end,
        ["matchesFilter all matching"] = function()
            local strings = {"abc", "def", "ghi"}
            local result = Util.matchesFilter(strings, function(str)
                return #str == 3
            end)
            assert(result == true, "Expected true")
        end,
        ["matchesFilter unmatching"] = function()
            local strings = {"abc", "defg", "hi"}
            local result = Util.matchesFilter(strings, function(str)
                return #str == 3
            end)
            assert(result == false, "Expected false")
        end,
    }
}
