local API = require("../../../src/API")
local Config = require("../../../src/Config")

local process = require("@lune/process")

--/ test: Check fetching API Key from either file or Env

local Conf = {
	outputDirectory = "output/outputDirectory/",
	publishAwaitOperation = true,
	serialiseNonScripts = false,

	secrets = {
		secretsDirectory = "output/secrets/",
		secretsFile = "key.txt",
		secretsEnvKey = "TEST_API_KEY",
	},

	debugLogs = false,
	debugUnresolvedRefs = false,
}

return {
    Tests = {
        ["API Env Key"] = function()
            Conf.secrets.secretsDirectory = nil
            Conf.secrets.secretsFile = nil
            Config.setUserConfig(Conf)
            process.env["TEST_API_KEY"] = "test_env_key"

            local EnvKey = API.getApiKey()
            assert(EnvKey == "test_env_key", "Expected key to be 'test_env_key', got " .. EnvKey)

            -- cleanup
            API.clearApiKey()
        end,
        ["API File Key"] = function()
            Conf.secrets.secretsDirectory = "output/secrets/"
            Conf.secrets.secretsFile = "key.txt"
            Conf.secrets.secretsEnvKey = nil
            Config.setUserConfig(Conf)

            local FileKey = API.getApiKey()
            assert(FileKey == "test_file_key", "Expected key to be 'test_file_key', got " .. FileKey)
        end,
    }
}