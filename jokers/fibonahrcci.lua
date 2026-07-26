SMODS.Joker {
    key = "fibonahrcci",
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    pos = { x = 4, y = 13 },
    config = { extra = { mult = 8 } },
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },


    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 2 or id == 3 or id == 5 or id == 8 or id == 14 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}