
SMODS.Joker { --Bank Of Amahrica
    key = "bank_of_amahrica",
    config = {
        extra = {
            debt_amount = 20
        }
    },

    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                get_debt_amount(card)
            }
        }
    end,
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - get_debt_amount(card)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + get_debt_amount(card)
    end
}

function get_debt_amount(card)
    return math.abs(card.ability.extra.debt_amount)
end