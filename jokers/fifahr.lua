SMODS.Joker {
    key = "fifahr",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 4, y = 8 },
    atlas = 'CustomJokers',
    pools = { ["modprefix_mahrlatr_jokers"] = true },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        assert(SMODS.change_base(scored_card, "Clubs", nil))
                        message = "Card Reverted!"
                        return true
                    end
                }))
            return {
                message = localize('fifahr_suit_change')
            }
            end
        end
    end
}