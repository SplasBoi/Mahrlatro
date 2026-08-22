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
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            local card = context.scoring_hand[1]

            if SMODS.has_no_rank(card) then return end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    assert(SMODS.modify_rank(card, 1))
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))
        end
    end
}