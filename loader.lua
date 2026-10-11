-- Auto-generated loader for: CometZ
-- Fetches and runs the installer from https://raw.githubusercontent.com/Schlouie/my-gui/main/CometZ.lua

local URL = "https://raw.githubusercontent.com/Schlouie/my-gui/main/CometZ.lua"

local function fetch(url)
    -- 1. syn.request (Synapse, Script-Ware, most modern execs)
    if typeof(syn) == "table" and syn.request then
        local ok, res = pcall(syn.request, {Url = url, Method = "GET"})
        if ok and res and res.Body and #res.Body > 0 then return res.Body end
    end
    -- 2. http.request (Krnl and others)
    if typeof(http) == "table" and http.request then
        local ok, res = pcall(http.request, {Url = url, Method = "GET"})
        if ok and res and res.Body and #res.Body > 0 then return res.Body end
    end
    -- 3. request (generic fallback)
    if typeof(request) == "function" then
        local ok, res = pcall(request, {Url = url, Method = "GET"})
        if ok and res and res.Body and #res.Body > 0 then return res.Body end
    end
    -- 4. game:HttpGet — usually works, but "nocache" arg is not universal
    if typeof(game.HttpGet) == "function" then
        local ok, res = pcall(function() return game:HttpGet(url, true) end)
        if ok and type(res) == "string" and #res > 0 then return res end
        ok, res = pcall(function() return game:HttpGet(url) end)
        if ok and type(res) == "string" and #res > 0 then return res end
    end
    -- 5. HttpService:GetAsync — only if the game has HTTP requests enabled
    local ok, res = pcall(function()
        return game:GetService("HttpService"):GetAsync(url, true)
    end)
    if ok and type(res) == "string" and #res > 0 then return res end
    error("[loader] no working HTTP method available for " .. url)
end

local src = fetch(URL)
if type(src) ~= "string" or #src == 0 then
    error("[loader] empty response from " .. URL)
end
-- Reject HTML error pages (raw.githubusercontent.com serves 404 as HTML)
if src:sub(1, 1) == "<" then
    error("[loader] server returned HTML — URL is likely wrong or repo is private: " .. URL)
end

local chunk, err = (loadstring or load)(src, "@" .. URL)
if not chunk then
    error("[loader] compile error in installer: " .. tostring(err))
end

return chunk()