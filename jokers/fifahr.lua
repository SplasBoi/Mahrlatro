local instantiate_green_card = nil

SMODS.Joker {
    key = "fifahr",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 4, y = 8 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    calculate = function(self, card, context)
        if context.ending_shop and JokerUtility.player_has_joker(G.jokers.cards, "j_red_card") then
            G.E_MANAGER:add_event(Event({
                func = instantiate_green_card(card, context)
            }))
        end

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

instantiate_green_card = function(card, context)
    for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key == "j_red_card" then
            SMODS.destroy_cards(joker, nil, nil, false)

            card:juice_up(0.5, 0.5)

            SMODS.calculate_effect({
                message = "Reverted!", --Add funny message here
                colour = G.C.GREEN },
                context.blueprint_card or card
            )

            local green_card = JokerUtility.instantiate_joker("j_mahrlatr_green_card")
            green_card.ability.extra.mult = joker.ability.mult
        end
    end
end