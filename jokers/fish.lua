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
        if context.joker_main and hand_is_black(context) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

function hand_is_black(context)
    for _, c in ipairs(context.scoring_hand) do
        if not (c:is_suit("Spades") or c:is_suit("Clubs")) then
            return false
        end
    end
    return true
end