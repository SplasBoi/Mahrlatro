SMODS.Joker {
    key = "cheese",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 6, y = 5 },

    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            chips = 5,
            chip_mod = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.joker_main then
            return {
                chips = e.chips
            }
        end

        if context.after and not context.blueprint then
            e.chips = e.chips + e.chip_mod
            if e.chips >= 100 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('gone_bad'),
                    colour = G.C.CHIPS
                }
            else
                return {
                    message = '+5 chips',
                    colour = G.C.CHIPS
                }
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips"
                }
            },
            text_config = { colour = G.C.CHIPS },
            calc_function = function(card)
                local e = card.ability.extra

                -- e.chips increases before hand finishes playing, so this is the best solution i can come up to
                local chips = (G.STATE == G.STATES.HAND_PLAYED and e.chips - e.chip_mod) or e.chips or 0
                card.joker_display_values.chips = chips
            end
        }
    end
}