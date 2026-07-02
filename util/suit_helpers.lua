SuitHelpers = {}

function SuitHelpers.has_suit_in_hand(context, suits)
    if context.final_scoring_step then
        for i = 1, #context.scoring_hand do
            for _, suit in ipairs(suits) do
                if context.scoring_hand[i]:is_suit(suit) then
                    return true
                end
            end
        end
    end
    return false
end

function SuitHelpers.is_red_card(card)
    return card:is_suit('Hearts') or card:is_suit('Diamonds')
end

function SuitHelpers.is_black_card(card)
    return card:is_suit('Spades') or card:is_suit('Clubs')
end
