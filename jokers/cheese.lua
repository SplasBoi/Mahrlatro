SMODS.Joker {
    key = "cheese",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 6, y = 5 },

    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = { extra = { chips = 5, chip_mod = 5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.chips + card.ability.extra.chip_mod >= 100 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('gone_bad'),
                    colour = G.C.CHIPS
                }
            else
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return {
                    message = '+5 chips',
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}