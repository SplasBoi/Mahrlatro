local has_three_of_a_kind = nil
local has_sequence = nil
local sort_held_hand = nil

SMODS.Joker {
    key = "mahrjong",

    discovered = true,
    unlocked = true,
    --atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 2,
    cost = 5,

    config = {
        extra = {
            x_mult = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.x_mult
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.joker_main then
            local sorted_held_hand = sort_held_hand(G.hand.cards)

            if has_three_of_a_kind(sorted_held_hand) or has_sequence(sorted_held_hand) then
                return {
                    x_mult = e.x_mult
                }
            end
        end
    end
}

has_three_of_a_kind = function(cards)
    for i = 1, #cards - 1 do
        if (cards[i] == cards[i + 1]) and (cards[i + 1] == cards[i + 2]) then return true end
    end

    return false
end

has_sequence = function(cards)
    for i = 1, #cards - 1 do
        if (cards[i] == (cards[i + 1] + 1)) and (cards[i + 1] == (cards[i + 2] + 1)) then return true end
    end

    return false
end

sort_held_hand = function(cards)
    local held_cards = {}

    for _, playing_card in ipairs(cards) do
        table.insert(held_cards, playing_card:get_id())
    end

    table.sort(held_cards, function(a, b) return a > b end)
    
    return held_cards
end