--// TestRunner
--/ Enumerates and runs tests

local fs = require("@lune/fs")

local Util = require("../src/Util")
local Fmt = require("../src/Lib/formatted")

local LoadedTests: {[string]: {[string]: () -> ()}} = {}
local PassedTests: {string} = {}
local FailedTests: {string} = {}

local TEST_DIR = "./modules/"

local function loadTests()
    local testFiles = fs.readDir(TEST_DIR)
    for _, module: string in testFiles do
        local modulePath = Util.joinPathParts(TEST_DIR, module)
        if fs.isDir(modulePath) then
            local moduleFiles = fs.readDir(modulePath)
            -- LoadedTests[module] = {}
            if #moduleFiles > 0 then
                LoadedTests[module] = {}
            end
            for _, file: string in moduleFiles do
                local isTestFile = Util.stringEndsWith(file, ".luau")
                if isTestFile then
                    -- we cant do .luau for some reason when doing requires...
                    -- hell if i know
                    local fileRaw = file:sub(1, #file - 5)
                    local testModulePath = Util.joinPathParts(modulePath, fileRaw)
                    local testModule = require(testModulePath)
                    for testName: string, testFunc: () -> () in testModule.Tests do
                        LoadedTests[module][`{testName}`] = testFunc
                    end
                end
            end
        end
    end
end

function testRunner()
    loadTests()
    for module, moduleTests in LoadedTests do
        print("Testing module: " .. Fmt(module, "yellow", nil, {"italic"}))
        for testName, testFunc in moduleTests do
            local success, err = pcall(testFunc)
            if success then
                table.insert(PassedTests, `{module} - {testName}`)
                print(Fmt("Passed: ", "green") .. `{testName}`)
            else
                table.insert(FailedTests, `{module} - {testName} - Error: {err}`)
                print(Fmt("Failed: ", "red") .. `{testName} - Error: {err}`)
            end
        end
    end

    if #FailedTests > 0 then
        print(Fmt("\nFailed Tests:", "red"))
        for _, fail in FailedTests do
            print(Fmt(`- {fail}`, "red"))
        end
        error("Some tests failed!")
    else
        print(Fmt("\nAll tests passed!", "green"))
    end
end

testRunner()
