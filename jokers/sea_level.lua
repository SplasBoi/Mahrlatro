SMODS.Joker { -- Below Sea Level
    key = "sea_level",

    pos = {
        x = 2,
        y = 4
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
       local cards_under_starting_size = -#G.playing_cards + G.GAME.starting_deck_size --this calc is so bad, the head is not mathing today sorry LMAO

        if cards_under_starting_size > 0 then
            card.ability.extra.mult = cards_under_starting_size
        else
            card.ability.extra.mult = 0
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult * 4
            }
        end
    end
}