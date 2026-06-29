SMODS.Joker {
    key = "fish",

    config = {
        extra = {
            chips = 75
        }
    },

    pos = {
        x = 2,
        y = 2
    },

    display_size = {
        w = 71,
        h = 95
    },

    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        local has_black_suit = false

        if context.final_scoring_step then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Spades') or context.scoring_hand[i]:is_suit('Clubs') then
                    has_black_suit = true
                    break
                end
            end
        end

        if has_black_suit then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}