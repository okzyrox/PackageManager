--!nonstrict
--// API
--// Author: okzyrox
--/ Date: 2025/12/18

--// Modules
local net = require("@lune/net")
local fs = require("@lune/fs")
local Util = require("./Util")

--// Types
export type URLMethod = "GET" | "POST" | "PATCH" | "PUT" | "DELETE"

export type URL = {
	url: string,
	method: URLMethod,
}

--// Constants
local PACKAGE_CONTENT_TYPE = "model/x-rbxm"

local URLS: {[string]: URL} = {
	GET_META = {
		url = "https://apis.roblox.com/assets/v1/assets/{ASSET_ID}",
		method = "GET"
	},
	GET_CONTENT = {
		url = "https://apis.roblox.com/asset-delivery-api/v1/assetId/{ASSET_ID}",
		method = "GET"
	},
	GET_CONTENT_BY_VERSION = {
		url = "https://apis.roblox.com/asset-delivery-api/v1/assetId/{ASSET_ID}/version/{VERSION_NUMBER}",
		method = "GET"
	},
	GET_VERSIONS = {
		url = "https://apis.roblox.com/assets/v1/assets/{ASSET_ID}/versions",
		method = "GET"
	},
	UPDATE_CONTENT = {
		url = "https://apis.roblox.com/assets/v1/assets/{ASSET_ID}/content",
		method = "PATCH"
	}
}

--// Vars
local ApiKey: string? = nil

--// Module

local API = {}
API.URLS = URLS

function API.getApiKey(): string
	if ApiKey then
		return ApiKey
	end

	if fs.isFile("secrets/apikey.txt") then
		local fileKey = fs.readFile("secrets/apikey.txt")
		ApiKey = fileKey
		return fileKey
	else
		error("No API key found! Follow instructions in secrets/apikey.txt.template")
	end
end

function API.makeRequest(urlData: URL, replacements: {[string]: string}?, body: string?, extraHeaders: {[string]: string}?): (number, string)
	local url = urlData.url
	if replacements then
		for key, value in replacements do
			url = string.gsub(url, "{" .. key .. "}", value)
		end
	end

	local headers = {
		["x-api-key"] = API.getApiKey(),
	}
	if extraHeaders then
		for key, value in extraHeaders do
			headers[key] = value
		end
	end

	if body then
		headers["Content-Type"] = "application/json"
	end

	Util.dprint("Making request to URL:", url)
	local response = net.request({
		method = urlData.method,
		url = url,
		headers = headers,
		body = body,
	})

	return response.statusCode, response.body
end

return API