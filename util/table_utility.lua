TableUtility = {}

-- Argument 1 is the searched key
-- Argument 2 is a table
function TableUtility.contains_individual(key, table) --> bool
    for _, v in ipairs(table) do
        if v == key then return true end
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