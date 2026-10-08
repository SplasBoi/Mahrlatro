local function get_random_joel_sound()
    return "mahrlatr_joel_laughing_" .. math.random(1, 4)
end

SMODS.Joker {
    key = "vahrgskelethor_joel",

    pos = {
        x = 0,
        y = 12
    },

    soul_pos = {
        x = 3,
        y = 14
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            mult = 0,
            scaling = 4,
            target_tarot = "wheel_of_fortune"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                colours = {
                    HEX('006AA7'),
                    HEX('FECC02')
                },

                e.mult,
                e.scaling,

                localize({
                    type = "name_text",
                    set = "Tarot",
                    key = "c_" .. e.target_tarot
                })
            }
        }
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.pseudorandom_result then
            if context.identifier == e.target_tarot and not context.result and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    trigger = "immediate",
                    func = function()
                        SMODS.scale_card(card, {
                            ref_table = e,
                            ref_value = 'mult',
                            scalar_value = 'scaling',
                            no_message = true
                        })
                        
                        card:juice_up()
                        
                        local sound = get_random_joel_sound()
                        local pitch = 1.0
                        local volume = 0.5

                        SoundUtility.play_sound_if_exists(sound, pitch, volume)
                        return true
                    end
                }))

                return {
                    message = localize("joel_nope_hahaha"),
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    -- Unlock logic done externally in lovely/wheel_of_fortune.toml

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "mult"
                }
            },

            text_config = { colour = G.C.MULT }
        }
    end
}