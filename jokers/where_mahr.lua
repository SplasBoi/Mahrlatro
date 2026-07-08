local get_xmult = nil

SMODS.Joker {
    key = "where_mahr",
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    pos = {
        x = 4,
        y = 7
    },

    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                get_xmult()
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = get_xmult()
            }
        end
    end
}

get_xmult = function()
    if G.jokers then
        return math.max(1, (G.jokers.config.card_limit - #G.jokers.cards) + 1)
    else
        return 1
    end
end