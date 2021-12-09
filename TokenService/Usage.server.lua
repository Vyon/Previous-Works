local repl = game:GetService('ReplicatedStorage')
local players = game:GetService('Players')
local FetchToken = repl.FetchToken
local CheckClient = repl.CheckClient

local TokenService = require(script.Parent.Modules.TokenService)

local TOKEN_SETTINGS = {
	FETCH = FetchToken,
	CHECK = CheckClient
}

local ANTI_SETTINGS = {
	WalkSpeed = 16,
	JumpPower = 50
}

TokenService:Init(TOKEN_SETTINGS, ANTI_SETTINGS)