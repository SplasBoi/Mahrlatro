SMODS.Joker:take_ownership("j_gluttenous_joker",
    { -- table of properties to change from the existing object
        pos = {
            x = 4,
            y = 1
        },

        atlas = 'CustomJokers',
        pools = { ["mahrlatr_mahrlatr_jokers"] = true },
        unlocked = true,

        add_to_deck = function(self, card, from_debuff)
            card.ability.extra.required_jokers_to_merge = {
                "j_stuntman",
                "j_erosion"
            }
        end,
        
        calculate = function(self, card, context)
            local e = card.ability.extra or self.config.extra

            if context.individual and context.cardarea == G.play  then
                if context.other_card:is_suit(e.suit) then
                    return {
                        mult = e.s_mult
                    }
                end
            end

            if context.ending_shop then
                if JokerUtility.can_merge_jokers(e.required_jokers_to_merge) then
                    return {
                        func = function()
                            return JokerUtility.slice_and_merge_jokers(
                                context,
                                card,
                                "j_mahrlatr_dutch_plus_ratio",
                                G.C.DIAMONDS,
                                "Dit is Nederlands!",
                                "Too Dutch for you!!"
                            )
                        end
                    }
                end
            end
        end
    },

    false -- silent suppresses mod badge
)