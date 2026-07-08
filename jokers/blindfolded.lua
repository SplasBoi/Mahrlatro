local flip_cards = nil

SMODS.Joker {
    key = 'blindfolded',

    pos = {
        x = 1,
        y = 6
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 6,
    rarity = 2,

    config = {
        extra = {
            x_mult = 4
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        if G.hand.cards then
            flip_cards(G.hand.cards, 'back')
        end
    end,

    calculate = function(self, card, context)
        if context.selling_self then
            if G.hand.cards and G.jokers.cards then

                local self_count = #SMODS.find_card(self.key, true) - 1
                if self_count < 1 then
                    flip_cards(G.hand.cards, 'front')
                end
            end
        end

        if context.stay_flipped and context.to_area == G.hand then
            return {
                stay_flipped = true
            }
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}

flip_cards = function(cards, side)
    for i, card in ipairs(cards) do
        if card.facing ~= side then
            card:flip()
        end
    end
end