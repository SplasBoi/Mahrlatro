SMODS.Joker {
    key = "mabels_house",

    pos = {
        x = 2,
        y = 9
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 8,

    config = {
        extra = {
            required_hand = "Full House",
            numerator = 1,
            denominator = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.required_hand,
                e.numerator,
                e.denominator
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.before and context.scoring_name == e.required_hand then
            if math.random(1, e.denominator) < (e.numerator + 1) then
                return {
                    func = function()
                        level_up_hand(card, e.required_hand)
                    end
                }
            end
        end
    end
}