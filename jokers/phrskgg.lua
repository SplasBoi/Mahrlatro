SMODS.Joker:take_ownership('j_egg',
    { -- table of properties to change from the existing object
    pos = { x = 3, y = 4 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra_value = card.ability.extra_value + 3
                    card:set_cost()
                    return true
                end,
                message = localize('phrskgg_value_increased')
            }
        end
    end
    },
    false -- silent suppresses mod badge
)