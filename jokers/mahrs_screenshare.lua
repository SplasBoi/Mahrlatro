SMODS.Joker {
    key = "mahrs_screenshare",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    pos = { x = 5, y = 14 },

    eternal_compat = true,
    perishable_compat = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 3, localize { type = 'name_text', key = 'm_wild', set = 'Enhanced' } } }
    end,

    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then count = count + 1 end
                if count >= 3 then
                    return true
                end
            end
        end
        return false
    end
}