
SMODS.Joker{ --Bank Of Amahrica
    key = "bankofamahrica",
    config = {
        extra = {
            debt_amount = '20'
        }
    },
    loc_txt = {
        ['name'] = 'Bank Of Amahrica',
        ['text'] = {
            [1] = 'Go up to {C:red}-$20{} in debt'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - 20
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + 20
    end
}