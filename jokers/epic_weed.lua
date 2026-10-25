SMODS.Joker:take_ownership("j_gluttenous_joker",
    { -- table of properties to change from the existing object
        pos = {
            x = 4,
            y = 1
        },

        atlas = 'CustomJokers',
        pools = { ["mahrlatr_mahrlatr_jokers"] = true },
        unlocked = true,
        
        calculate = function(self, card, context)
            local e = card.ability.extra or self.config.extra

            if context.individual and context.cardarea == G.play  then
                if context.other_card:is_suit(e.suit) then
                    return {
                        mult = e.s_mult
                    }
                end
            end
        end,

        update = function(self, card, dt)
            local required_jokers_to_merge = { "j_stuntman", "j_erosion", "j_gluttenous_joker" }

            if JokerUtility.can_merge_jokers(required_jokers_to_merge) then
                JokerUtility.slice_and_merge_jokers(
                    card,
                    "j_mahrlatr_dutch_plus_ratio",
                    required_jokers_to_merge,
                    G.C.DIAMONDS,
                    "Dit is Nederlands!",
                    "Too Dutch for you!!"
                )
            end
        end
    },

    false -- silent suppresses mod badge
)