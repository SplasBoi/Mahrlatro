
SMODS.Joker{ --Påhrsk Ägg
    key = "agg",
    config = {
        extra = {
            value_increase = 3
        }
    },

    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.value_increase
            }
        }
    end,


    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.value_increase
                    card:set_cost()
                    return true
                end,
                message = localize('phrskgg_value_increased')
            }
        end
    end
}