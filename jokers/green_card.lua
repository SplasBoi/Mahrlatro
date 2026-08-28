SMODS.Joker {
    key = "green_card",

    pos = {
        x = 2,
        y = 19
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 'mahrlatr_krejsi_rarity',

    config = {
        extra = {
            scaling = 3,
            mult = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        
        return {
            vars = {
                colours = {
                    HEX('00FF00')
                },

                e.scaling,
                e.mult
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.open_booster then
             G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.5, func = function()
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'mult',
                    scalar_value = 'scaling',
                    no_message = true
                })
                
                card:juice_up()

                return true
            end }))
        end

        if context.joker_main then
            return {
                mult = e.mult
            }
        end
    end
}