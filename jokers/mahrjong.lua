local function has_three_of_a_kind(cards)
    for i = 1, #cards - 2 do
        if cards[i] == cards[i + 1] and cards[i + 1] == cards[i + 2] then
            return true
        end
    end
    
    return false
end

local function has_sequence(cards)
    local sequence = {}

    for i = 1, #cards - 2 do
        -- 1st element
        table.insert(sequence, cards[i])

        for j = i + 1, #cards do
            -- 2nd element
            if cards[j] ~= nil and cards[i] - cards[j] == 1 then
                table.insert(sequence, cards[j])

                for k = j + 1, #cards do
                    -- 3rd element
                    if cards[k] ~= nil and cards[j] - cards[k] == 1 then
                        table.insert(sequence, cards[k])

                        return true
                    end
                end
            end
        end

        sequence = {}
    end

    return false
end

local function sort_held_hand(cards)
    local held_cards = {}

    for _, playing_card in ipairs(cards) do
        table.insert(held_cards, playing_card:get_id())
    end

    table.sort(held_cards, function(a, b) return a > b end)
    
    return held_cards
end

SMODS.Joker {
    key = "mahrjong",

    discovered = false,
    unlocked = true,
    atlas = 'CustomJokers',

    pos = {
        x = 6,
        y = 9
    },

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
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "x_mult",
                            retrigger_type = "exp"
                        }
                    }
                }
            },
            
            calc_function = function(card)
                local e = card.ability.extra
                local held_hand = {}

                for _, deck_card in ipairs(G.hand.cards) do
                    if not deck_card.highlighted
                    and not SMODS.has_no_rank(deck_card)
                    and not deck_card.debuff
                    and deck_card.facing == "front" then
                        table.insert(held_hand, deck_card)
                    end
                end
                
                local sorted_held_hand = sort_held_hand(held_hand)

                if has_three_of_a_kind(sorted_held_hand) or has_sequence(sorted_held_hand) then
                    card.joker_display_values.x_mult = e.x_mult
                else
                    card.joker_display_values.x_mult = 1
                end
            end
        }
    end
}