SMODS.Joker {
    key = "pirate",
    unlocked = false,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 4, y = 10 },
    config = { extra = { mult = 1 } },
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },


    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card then
                sell_cost = sell_cost + joker.sell_cost
            end
        end
        return { vars = { card.ability.extra.mult * sell_cost } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    sell_cost = sell_cost + joker.sell_cost
                end
            end
            return {
                mult = card.ability.extra.mult * sell_cost
            }
        end
    end
}