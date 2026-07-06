local get_mult = nil

SMODS.Joker { -- Land der Berge
    key = "land_der_berge",

    pos = {
        x = 4,
        y = 3
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 5,
    rarity = 2,

    config = {
        extra = {
            amount = 1,
            count_above = 52
        }
    },

    loc_vars = function(self, info_queue, card)
        local conf = card.ability.extra

        return {
            vars = {
                colours = { HEX('C8102E') },
                
                conf.amount,
                conf.count_above,
                get_mult(conf.count_above)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = get_mult(card.ability.extra.count_above)
            }
        end
    end
}

get_mult = function(min_cards)
    local deck_size = (G.playing_cards and #G.playing_cards) or 0

    if deck_size >= min_cards then
        return deck_size - min_cards
    else
        return 0
    end
end
