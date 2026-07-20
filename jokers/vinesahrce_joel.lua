SMODS.Joker {
    key = "vinesahrce_joel",

    -- Fix when we have the art added.
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            mult = 0,
            scaling = 4
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    HEX('006AA7'),
                    HEX('FECC02')
                },

                card.ability.extra.mult,
                card.ability.extra.scaling
            }
        }
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result then
            if context.identifier == "wheel_of_fortune" and not context.result then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.5, func = function()
                
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = 'mult',
                        scalar_value = 'scaling',
                        no_message = true
                    })
                    
                    card:juice_up()
                    local random_sound_index = math.random(1,2)
                    play_sound('mahrlatr_joel_laughing_'..random_sound_index, 1.0, 0.5)

                    return true
                end }))

                return {
                    message = localize("joel_nope_hahaha")
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}