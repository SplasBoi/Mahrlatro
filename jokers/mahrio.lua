SMODS.Joker {
    key = "mahrio",
    
    pos = {
        x = 6,
        y = 4
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 3,
    rarity = 1,

    config = {
        extra = {
            chance = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            card.ability.extra.chance
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval  then
            local free_joker_slots = G.jokers.config.card_limit - #G.jokers.cards

            if (free_joker_slots < 1) then return end

            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_mahrio', 1, card.ability.extra.chance) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.01, func = function()
                    play_sound('mahrlatr_mahrio_win',1.0,0.6)
                    SMODS.add_card({key = 'j_mahrlatr_the_stahr'})
                
                    return true
                end }))
            end
        end
    end
}