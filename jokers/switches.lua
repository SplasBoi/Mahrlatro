SMODS.Joker {
    key = "switches",

    pos = {
        x = -1,
        y = -1
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
            current_x_chips = 1,
            scaling = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.current_x_chips,
                e.scaling
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.change_suit then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'current_x_chips',
                scalar_value = 'scaling'
            })
        end

        if context.joker_main then
            return {
                x_chips = card.ability.extra.current_x_chips
            }
        end
    end
}