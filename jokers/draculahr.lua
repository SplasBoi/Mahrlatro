SMODS.Joker {

    key = "draculahr",
    blueprint_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    rarity = 2,
    cost = 7,
    pos = { x = 4, y = 4 },
    config = { extra = { Xmult_gain = 0.1, Xmult = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local enhanced = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    scored_card.vampired = true
                    scored_card:set_ability('c_base', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
            end

            if #enhanced > 0 then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * #enhanced
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
}