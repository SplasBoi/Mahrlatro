SMODS.Joker:take_ownership('j_mr_bones',
    { -- table of properties to change from the existing object
    pos = { x = 5, y = 9 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if G.GAME.chips / G.GAME.blind.chips >= 0.25 then -- See note about Talisman compatibility on the wiki
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        SMODS.destroy_cards(card, nil, true)
                        return true
                    end
                }))
                return {
                    message = localize('sahrns_saved'),
                    colour = G.C.RED
                }
            end
        end
    end
    },
    false -- silent suppresses mod badge
)