SMODS.Joker {
    key = "evil_chicken",
    
    pos = {
        x = 6,
        y = 3
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 3,
    rarity = 1,

    config = {
        extra = {

        }
    },

    loc_vars = function(self, info_queue, card)
        return {

        }
    end,

    --scary wanye code
    calculate = function(self, card, context)

        local free_joker_slots = G.jokers.config.card_limit - #G.jokers.cards

        if (free_joker_slots >= 1) and context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.01, func = function()
                play_sound('mahrlatr_ratatouille_honk')
                
                SMODS.add_card({key = 'j_mahrlatr_agg'})
                
                return true
            end }))

        end
    end
}