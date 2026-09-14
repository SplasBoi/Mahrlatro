local function is_between(value, min, max)
    if min > max then
        return false
    end

    return value >= min and value <= max
end

local function get_valid_numbers_loc_string(min, max)
    local parts = {}

    for i = min, max do
        parts[#parts + 1] = "{C:attention}" .. i .. "{}"
    end

    if #parts == 1 then
        return parts[1]
    
    elseif #parts == 2 then
        return parts[1] .. " or " .. parts[2]
    
    else
        return table.concat(parts, ", ", 1, #parts - 1) .. ", or " .. parts[#parts]

    end
end

SMODS.Joker {
    key = "funny_numbers",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,

    pos = {
        x = 1,
        y = 9 
    },

    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            repetitions = 1,
            min_id = 6,
            max_id = 9
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                get_valid_numbers_loc_string(e.min_id, e.max_id)
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.repetition and context.cardarea == G.play then
            local card_id = context.other_card:get_id()
            if is_between(card_id, e.min_id, e.max_id) then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}