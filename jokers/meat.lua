SMODS.Joker { --Meat
    key = "meat",

    config = {
        extra = {
            mult = 7
        }
    },
    
    pos = {
        x = 1,
        y = 2
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if SuitHelpers.has_suit_in_hand(context, {'Hearts', 'Diamonds'}) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}