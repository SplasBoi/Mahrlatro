SMODS.Joker {
    key = "nutellas_cahr",

    pos = {
        x = 5,
        y = 4
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
    rarity = 3,

    config = {
        extra = {
            dollars = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            local card = context.scoring_hand[1]

            if SMODS.has_no_rank(card) then return end
            
            return {
                message = "Honk! Honk!",
                colour = G.C.RED,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SoundUtility.play_sound_if_exists("mahrlatr_nutella_cahr_honk", 1.0, 0.5)
                            assert(SMODS.modify_rank(card, 1))
                            return true
                        end
                    }))
                end
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "active_text" },
                { text = ")" },
            },
            calc_function = function(card)
                card.joker_display_values.is_active = G.GAME.current_round.hands_played == 0
                card.joker_display_values.active_text = localize("jdis_" ..
                    (card.joker_display_values.is_active and "active" or "inactive"))
            end,
            style_function = function(card, text, reminder_text, extra)
                if reminder_text and reminder_text.children and reminder_text.children[2] then
                    reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                        G.C.UI.TEXT_INACTIVE
                end
            end
        }
    end
}