local Config = require("../../../src/Config")

return {
    Tests = {
        ["get returns value for valid key"] = function()
            Config.setUserConfig({
                outputDirectory = "test/",
                publishAwaitOperation = true,
                serialiseNonScripts = false,
                secrets = {
                    secretsDirectory = "secrets/",
                    secretsFile = "api_key.txt",
                    secretsEnvKey = "ROBLOX_API_KEY",
                },
                debugLogs = true,
                debugUnresolvedRefs = false,
            })
            local value = Config.get("debugLogs")
            assert(value == true, "Expected true")
        end,
        ["get returns nil for invalid key"] = function()
            Config.setUserConfig({
                outputDirectory = "test/",
                publishAwaitOperation = true,
                serialiseNonScripts = false,
                secrets = {
                    secretsDirectory = "secrets/",
                    secretsFile = "api_key.txt",
                    secretsEnvKey = "ROBLOX_API_KEY",
                },
                debugLogs = false,
                debugUnresolvedRefs = false,
            })
            local value = Config.get("invalidConfigKey")
            assert(value == nil, "Expected nil")
        end,
        ["getOrDefault returns default for nil"] = function()
            Config.setUserConfig({
                -- outputDirectory = "test/",
                publishAwaitOperation = true,
                serialiseNonScripts = false,
                secrets = {
                    secretsDirectory = "secrets/",
                    secretsFile = "api_key.txt",
                    secretsEnvKey = "ROBLOX_API_KEY",
                },
                debugLogs = false,
                debugUnresolvedRefs = false,
            })
            local value = Config.getOrDefault("outputDirectory")
            assert(value ~= nil, "Expected value")
            assert(value == "output/", "Expected default 'output/'")
        end
    }
}
