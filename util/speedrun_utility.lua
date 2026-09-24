SpeedrunUtil = {}

SpeedrunUtil.Games = {
    Ratatouille_Asobo = {
        game_id = "9dokee1p",
        categories = {
            any_percent = "wdm8x3e2"
        }
    }
}

local https = require "SMODS.https"
local initialized = false
local record_times = {}
local fetching = {}
local fetch_cooldown = {}
local COOLDOWN_TIME = 60

local function json_get_nested(tbl, ...)
    for _, key in ipairs({...}) do
        if type(tbl) ~= "table" then
            return nil
        end
        
        tbl = tbl[key]
    end
    
    return tbl
end

local function fetch_src_records(category_id)
    local now = os.time()

    if fetch_cooldown[category_id] and now < fetch_cooldown[category_id] then
        return nil
    end

    if fetching[category_id] then
        return nil
    end

    fetching[category_id] = true

    local url = "https://www.speedrun.com/api/v1/categories/" .. category_id .. "/records"

    local code, body, headers = https.request(url, {
        method = "GET",
        headers = {
            ["User-Agent"] = "Mahrlatro"
        }
    })

    fetching[category_id] = nil
    fetch_cooldown[category_id] = now + COOLDOWN_TIME
    
    if code == 200 and body then
        return JSON.decode(body)
    else
        print("HTTP request failed:", code, body)
        return nil
    end
end

local function get_records(category_id)
    if record_times[category_id] then
        return record_times[category_id]
    end

    local body = fetch_src_records(category_id)

    if body and body.data then
        record_times[category_id] = {}

        for _, record in ipairs(body.data) do
            for _, run_entry in ipairs(record.runs) do
                local time = json_get_nested(
                    run_entry,
                    "run",
                    "times",
                    "primary"
                )

                if time then
                    table.insert(record_times[category_id], time)
                end
            end
        end
    end

    return record_times[category_id]
end

function SpeedrunUtil.get_best_times(category)
    return get_records(category)
end

function SpeedrunUtil.get_wr_time(category)
    local times = get_records(category)

    if not times or not times[1] then
        return nil
    end

    return times[1]
end

function SpeedrunUtil.init()
    if initialized then
        return
    end

    for _, game in pairs(SpeedrunUtil.Games) do
        for _, category in pairs(game.categories) do
            get_records(category)
        end
    end
end

function SpeedrunUtil.time_to_decimal(duration)
    local minutes = tonumber(duration:match("(%d+)M")) or 0
    local seconds = tonumber(duration:match("(%d+)S")) or 0

    return minutes + (seconds / 10)
end