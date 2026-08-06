SMODS.Joker {
    key = "considerable_girth",

    pos = {
        x = 5,
        y = 15
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.pre_joker then
            for i = 1, #G.hand.cards do
                if not SMODS.has_no_rank(G.hand.cards[i]) then
                    local rank = G.hand.cards[i].base.nominal

                    SMODS.calculate_effect({
                        chips = rank,
                        message = "+"..rank,
                        colour = G.C.CHIPS
                    }, G.hand.cards[i])
                end
            end
        end
        
        if context.joker_main and not context.end_of_round then
            -- retorna a soma
            
        end
    end
}