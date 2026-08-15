SMODS.Joker {
    key = "the_nyahr",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    pos = { x = 0, y = 11 },
    config = { extra = { Xmult_gain = 0.25, Xmult = 1 } },

    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,


    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.lucky_trigger and not context.blueprint then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_lucky'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_lucky') then
                return true
            end
        end
        return false
    end
}