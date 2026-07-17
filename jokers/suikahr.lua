local create_destroy_cards_event = nil
local create_upgraded_card_event = nil

SMODS.Joker {
    key = "suikahr",

    discovered = true,
    unlocked = true,

    -- TODO: adjust cost and rarity
    cost = 1,
    rarity = 1,

    config = {
        extra = {
            wanted_hand = "Pair"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = self.config.extra or card.ability.extra

        return {
            vars = {
                e.wanted_hand
            }
        }
    end,

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.joker_main and context.scoring_name == e.wanted_hand then
            local selected_card = context.full_hand[math.random(#context.full_hand)]

            local suit = selected_card.base.suit
            local rank = selected_card.base.value

            G.E_MANAGER:add_event(create_destroy_cards_event(context.full_hand))
            G.E_MANAGER:add_event(create_upgraded_card_event(rank, suit))

            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_upgrade_ex'),
                colour = G.C.ATTENTION
            })
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

create_upgraded_card_event = function(rank, suit)
    if rank == "Ace" then
        return Event({
            func = function()
                SMODS.add_card({
                    set = "Enhanced",
                    area = G.hand,
                    rank = rank,
                    suit = suit
                })

                return true
            end
        })
    else
        return Event({
            func = function()
                local card = SMODS.add_card({
                    set = "Base",
                    area = G.hand,
                    rank = rank,
                    suit = suit
                })

                SMODS.modify_rank(card, 1)

                return true
            end
        })
    end
end