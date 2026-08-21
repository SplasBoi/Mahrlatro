SMODS.Joker:take_ownership('j_flower_pot',
    { -- table of properties to change from the existing object
    pos = { x = 6, y = 12 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                        suits["Spades"] = 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = 1
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                        suits["Hearts"] = 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                        suits["Spades"] = 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                        suits["Clubs"] = 1
                    end
                end
            end
            if suits["Hearts"] + suits["Diamonds"] + suits["Spades"] + suits["Clubs"] > 2 then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    end,
    },
    false -- silent suppresses mod badge
)