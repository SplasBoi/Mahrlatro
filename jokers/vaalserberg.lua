SMODS.Joker {
    key = "vaalserberg",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    pos = { x = 4, y = 6 },
    config = { extra = { h_size = 2, chip_mod = 322 } },
    atlas = 'CustomJokers',


    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_mod, card.ability.extra.h_size } }
    end,


    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chip_mod
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end
}