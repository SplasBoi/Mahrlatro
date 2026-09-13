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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

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
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "X" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "x_mult"
                }
            },
            text_config = { colour = G.C.RED },
            calc_function = function(card)
                local hand_name = JokerDisplay.current_hand_info.text

                if hand_name ~= "NULL" and G.GAME.hands[hand_name] then
                    local played = G.GAME.hands[hand_name].played_this_round or 0

                    -- This is a fix for play count incrementing when scoring starts
                    if (G.STATE == G.STATES.HAND_PLAYED and played == 1) or played < 1 then
                        card.joker_display_values.x_mult = card.ability.extra.x_mult
                    else
                        card.joker_display_values.x_mult = 1
                    end
                else
                    card.joker_display_values.x_mult = 1
                end
            end
        }
    end
}