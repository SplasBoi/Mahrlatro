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

    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if SuitHelpers.has_suit_in_hand(context, {'Spades', 'Clubs'}) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}