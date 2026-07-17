local create_destroy_cards_event = nil
local create_upgraded_card_event = nil

SMODS.Joker {
    key = "suikahr",

    discovered = true,
    unlocked = true,

    cost = 1,
    unlocked = 1,

    config = {
        extra = {
            wanted_hand = "Pair"
        }
    },

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.joker_main and context.scoring_name == e.wanted_hand then
            local selected_card = context.full_hand[math.random(#context.full_hand)]

            local suit = selected_card.base.suit
            local rank = selected_card.base.value

            G.E_MANAGER:add_event(create_destroy_cards_event(context.full_hand))
            G.E_MANAGER:add_event(create_upgraded_card_event(rank, suit))
        end
    end
}

create_destroy_cards_event = function(cards)
    local event = Event({
        func = function()
            for _, card in ipairs(cards) do
                card:start_dissolve({G.C.RED}, nil, 1.6)
            end

            return true
        end
    })
    
    return event
end

create_upgraded_card_event = function(value, suit)
    local event = Event({
        func = function()
            local card = SMODS.add_card({
                set = "Base",
                area = G.hand,
                rank = value,
                suit = suit
            })

            SMODS.modify_rank(card, 1)

            return true
        end
    })

    return event
end