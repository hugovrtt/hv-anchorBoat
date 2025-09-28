local function isstring(string)
    return type(string) == "string"
end

local function string_split(text, pattern)
    if not isstring(text) or not isstring(pattern) then return nil end

    local tbl = {}
    for word in string.gmatch(text, "[^%"..pattern.."]+") do
        table.insert(tbl, word)
    end

    return tbl
end

local function parsePath(path)
    if not isstring(path) then return end

    local dir = string_split(path, ".")
    if not dir then return end

    local path = ""
    for i=1, #dir do
        if i == #dir then
            path = path .. dir[i] .. ".lua"
            return path
        end

        path = path .. dir[i] .. "/"
    end
end

local function loadModule(code, path, env)
    if not isstring(code) or not isstring(path) then return end

    local file, err = load(code, path, "t", env or _ENV)

    if file then return file, err end

    return nil, err
end

local request = setmetatable({}, {
    __call = function(self, path)
        local path = parsePath(path)
        local file = LoadResourceFile(GetCurrentResourceName(), path)
        local func, err = loadModule(file, path)

        if func then
            return func()
        end
        error(err)
    end
})

_ENV.request = request