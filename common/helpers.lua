HELPERS = HELPERS or {}

function HELPERS.has_suit_in_hand(context, suits)
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