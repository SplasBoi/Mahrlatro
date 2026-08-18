SMODS.Joker:take_ownership('j_jolly',
    { -- table of properties to change from the existing object
    pos = { x = 3, y = 13 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Pair']) then
            play_sound('mahrlatr_ratatouille')
            return {
                mult = 8
            }
        end
    end
    },
    false -- silent suppresses mod badge
)