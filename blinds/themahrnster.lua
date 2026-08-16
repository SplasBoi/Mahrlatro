local undebuff_playing_cards = nil

SMODS.Blind {
    key = "themahrnster",
    
    dollars = 5,
    mult = 2,

    atlas = 'CustomBlinds',

    pos = {
        x = 0,
        y = 2
    },


    boss = {
        min = 4,
        max = 27,
    },

    boss_colour = HEX("F5CC27"),

    loc_vars = function(self)
        return {
            vars = {
                localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')
            }
        }
    end,
    
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,

    disable = function(self, silent)
        undebuff_playing_cards()
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.before then
            if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                for _, v in ipairs(context.scoring_hand) do
                    SMODS.debuff_card(v, true, "themahrnster")
                end

                return {
                    func = function()
                        blind:wiggle()
                    end
                }
            end
        end

        if context.blind_defeated then
            undebuff_playing_cards()
        end
    end
}

undebuff_playing_cards = function()
    for _, v in pairs(G.playing_cards) do
        SMODS.debuff_card(v, false, "themahrnster")
    end
end