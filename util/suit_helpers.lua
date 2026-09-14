SuitHelpers = {}

function SuitHelpers.has_suit_in_hand(scoring_hand, suits)
    for i = 1, #scoring_hand do
        for _, suit in ipairs(suits) do
            if scoring_hand[i]:is_suit(suit) then
                return true
            end
        end
    end
    return false
end

function SuitHelpers.is_red_card(card)
    return card:is_suit('Hearts', true) or card:is_suit('Diamonds', true)
end

function SuitHelpers.is_black_card(card)
    return card:is_suit('Spades', true) or card:is_suit('Clubs', true)
end
