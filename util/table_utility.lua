TableUtility = {}

-- Argument 1 is the searched key
-- Argument 2 is a table
function TableUtility.contains_individual(key, table) --> bool
    for _, v in ipairs(table) do
        if v == key then
            return true 
        end
    end

    return false
end

-- Idk if this will end up being used but it's there 
-- Argument 1 is the searched key
-- Argument 2 is a table
function TableUtility.contains_pairs(key, table) --> bool
    for _, v in pairs(table) do
        if v == key then return true end
    end

    return false
end

-- Gets the amount of unique keys in a dictionary
-- Returns -1 if the table is invalid
function TableUtility.dict_size(dict) --> number
    if type(dict) ~= "table" then
        return -1
    end

    local count = 0
    for _ in pairs(dict) do
        count = count + 1
    end

    return count
end