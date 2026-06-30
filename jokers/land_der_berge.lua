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
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX('C8102E') },

                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
       local cards_over_starting_size = #G.playing_cards - G.GAME.starting_deck_size

        if cards_over_starting_size > 0 then
            card.ability.extra.mult = cards_over_starting_size
        else
            card.ability.extra.mult = 0
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}