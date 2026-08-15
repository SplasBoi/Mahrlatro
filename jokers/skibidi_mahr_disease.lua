SMODS.Joker {
    key = 'skibidi_mahr_disease',

    pos = {
        x = 2,
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
    rarity = 3,

    config = {
        extra = {
            starting_hands,
            starting_discards,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.starting_hands = G.GAME.round_resets.hands   
            card.ability.extra.starting_discards = G.GAME.current_round.discards_left
        end
        
        if context.selling_self and G.GAME.blind.in_blind then
            local current_hands = G.GAME.current_round.hands_left
            local current_discards = G.GAME.current_round.discards_left

            local hands_used = card.ability.extra.starting_hands - current_hands
            local discards_used = card.ability.extra.starting_discards - current_discards

            if (hands_used > 0) then
                ease_hands_played(hands_used)
            end

            if (discards_used > 0) then
                ease_discard(discards_used)
            end
        end
    end
}