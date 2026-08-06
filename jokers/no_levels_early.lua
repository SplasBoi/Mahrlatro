SMODS.Joker {
    key = "no_levels_early",

    pos = {
        x = 5,
        y = 16
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

    cost = 7,
    rarity = 2,

    config = {
        extra = {
            x_mult = 4
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].level == 1 then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}