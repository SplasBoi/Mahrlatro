
SMODS.Joker { --Wild Cat
    key = "wild_cat",

    config = {
        extra = {
            mult_bonus = 0.2
        }
    },

    pos = {
        x = 3,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                get_wildcard_bonus(card)
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = get_wildcard_bonus(card)
            }
        end
    end
}

function get_wildcard_bonus(card)
        local count = 1
        local cards = G.hand and G.hand.cards or {}

        for _, c in ipairs(cards) do
            if SMODS.has_enhancement(c, 'm_wild') then
                count = count + card.ability.extra.mult_bonus
            end
        end
        return count
    end