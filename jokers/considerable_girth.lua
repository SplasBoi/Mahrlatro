SMODS.Joker {
    key = "considerable_girth",

    pos = {
        x = 5,
        y = 15
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,
    
    calculate = function(self, card, context)
        if context.pre_joker then
            for _, deck_card in ipairs(G.hand.cards) do
                if not SMODS.has_no_rank(deck_card) and not deck_card.debuff then
                    local rank = deck_card.base.nominal

                    G.E_MANAGER:add_event(Event({
                        trigger = "immediate",
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))

                    SMODS.calculate_effect({
                        chips = rank,
                        message = "+"..rank,
                        colour = G.C.CHIPS
                    }, deck_card)
                end
            end
        end
    end
}