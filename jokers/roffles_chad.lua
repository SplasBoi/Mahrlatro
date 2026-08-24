SMODS.Joker:take_ownership('j_hanging_chad',
    { -- table of properties to change from the existing object
    pos = { x = 5, y = 17 },
    atlas = 'CustomJokers',
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return {
                repetitions = 2,
                play_sound('mahrlatr_roffle')
            }
        end
    end,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)