SMODS.Joker:take_ownership('j_cavendish',
    { -- table of properties to change from the existing object
    pos = { x = 0, y = 0 },
    atlas = 'Benjamin',
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'cavendish', 1, 1000) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.joker_main then
            return {
                play_sound('mahrlatr_uh_guys'),
                xmult = 3
            }
        end
    end,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)