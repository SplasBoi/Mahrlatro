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
            scaling = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX('C8102E') },
                
                card.ability.extra.scaling,
                G.GAME.starting_deck_size,
                get_mult(G.GAME.starting_deck_size),
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = get_mult(G.GAME.starting_deck_size)
            }
        end
    end
}

get_mult = function(starting_number)
    if (not G.playing_cards) then return 0 end

    local deck_size = #G.playing_cards

    if deck_size >= starting_number then
        return deck_size - starting_number
    else
        return 0
    end
end