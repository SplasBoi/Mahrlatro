SMODS.Joker {
    key = "any_percent",

    pos = {
        x = 3,
        y = 16
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    config = {
        extra = {
            mult_scaling = 3,
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                e.mult_scaling
            }
        }
    end,
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.joker_main then
            return {
                mult = G.GAME.hands[context.scoring_name].level * e.mult_scaling
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult"
                }
            },
            text_config = { colour = G.C.MULT },
            
            calc_function = function(card)
                local e = card.ability.extra
                local hand_name = JokerDisplay.current_hand_info.text

                if G.GAME.hands[hand_name] then
                    local hand_level = G.GAME.hands[hand_name].level
                    local scaling = e.mult_scaling
                    local mult = hand_level * scaling

                    card.joker_display_values.mult = mult
                else
                    card.joker_display_values.mult = 0
                end
            end
        }
    end
}