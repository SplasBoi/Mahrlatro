SMODS.Joker {
    key = "drivahrs_license",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    config = { extra = { xmult = 3, driver_amount = 16 } },
    pos = { x = 6, y = 8 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local driver_tally = 0
        for _, playing_card in pairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.driver_amount, driver_tally } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local driver_tally = 0
            for _, playing_card in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
            end
            if driver_tally >= card.ability.extra.driver_amount then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,

    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 16 } }
    end
}