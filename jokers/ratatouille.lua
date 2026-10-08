SMODS.Joker:take_ownership("j_jolly",
    { -- table of properties to change from the existing object
    pos = { x = 3, y = 13 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    add_to_deck = function(self, card, from_debuff)
        SoundUtility.play_sound_if_exists("mahrlatr_ratatouille")
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Pair"]) then
            local fallback_mult = 8

            return {
                mult = self.config.t_mult or fallback_mult
            }
        end
    end
    },
    false -- silent suppresses mod badge
)