SMODS.Joker:take_ownership('j_stuntman',
    { -- table of properties to change from the existing object
    pos = { x = 4, y = 6 },
    atlas = 'CustomJokers',
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = 322
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(2)
    end,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)