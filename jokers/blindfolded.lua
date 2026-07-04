SMODS.Joker {
    key = 'blindfolded',

    pos = {
        x = 1,
        y = 6
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

    cost = 6,
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
        if context.selling_self then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].facing == 'back' then
                    G.hand.cards[i]:flip()
                end
            end
        end

        if context.stay_flipped and context.to_area == G.hand then
            return {
                stay_flipped = true
            }
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}