SMODS.Joker:take_ownership('j_ticket',
    { -- table of properties to change from the existing object
    pos = { x = 3, y = 5 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_gold') then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 4
            return {
                dollars = 4,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            play_sound('mahrlatr_gold')
                            return true
                        end
                    }))
                end
            }
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_gold'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end
    },
    false -- silent suppresses mod badge
)