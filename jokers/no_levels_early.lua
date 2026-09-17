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
    discovered = false,
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
    end,
    
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "x_mult",
                            retrigger_type = "exp"
                        }
                    }
                }
            },

            text_config = { colour = G.C.WHITE },

            calc_function = function(card)
                local e = card.ability.extra

                local text, _, _ = JokerDisplay.evaluate_hand()

                card.joker_display_values.x_mult = 1
                
                if text ~= "Unknown" and G.GAME.hands[text] and G.GAME.hands[text].level == 1 then
                    card.joker_display_values.x_mult = e.x_mult
                end
            end
        }
    end
}