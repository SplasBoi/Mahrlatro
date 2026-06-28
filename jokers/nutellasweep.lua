
SMODS.Joker{ --Nutella Sweep
    key = "nutellasweep",

    config = {
        extra = {
            mult_bonus = 0.25
        }
    },

    pos = {
        x = 2,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                get_mult(card)
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = get_mult(card)
            }
        end
    end
}

function get_mult(card)
    local consumable_count = get_consumables_used()

    if consumable_count == 0 then
        return 1
    end

    return 1 + (consumable_count * card.ability.extra.mult_bonus)
end

function get_consumables_used()
    local count = 0
    local consumables = G.GAME.consumeable_usage or {}

    for k, v in pairs(consumables) do
        if v.set == 'Planet' then
            count = count + 1
        end
    end
    return count
end