SMODS.Joker {
    key = "all_main_categories",

    pos = {
        x = 5,
        y = 6
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 6,
    rarity = 2,

    config = {
        extra = {
           x_mult = 2
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
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round == 1 then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
}