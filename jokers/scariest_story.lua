
SMODS.Joker{ --New Joker
    key = "scariest_story",
    config = {
        extra = {
            discard_size = 5,
            hands = 1
        }
    },

    pos = {
        x = 4,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discard_size, card.ability.extra.hands } }
    end,

    calculate = function(self, card, context)
        if context.first_hand_drawn  then
            return {
                
                func = function()
                    G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discard_size
                    return true
                end,
                extra = {
                    
                    func = function()
                        play_sound('mahrlatr_try_not_to_get_scared')
                        G.GAME.current_round.hands_left = card.ability.extra.hands
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
    end
}