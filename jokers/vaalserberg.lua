SMODS.Joker:take_ownership("j_stuntman", {
        pos = {
            x = 4,
            y = 6
        },

        atlas = 'CustomJokers',
        pools = { ["mahrlatr_mahrlatr_jokers"] = true },

        config = {
            extra = {
                chip_mod = 322,
                h_size = 2
            }
        },

        loc_vars = function(self, info_queue, card)
            local e = card.ability.extra or self.config.extra
            
            return {
                vars = {
                    e.chip_mod,
                    e.h_size
                }
            }
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chip_mod
                }
            end
        end,
    },
    false -- silent suppresses mod badge
)