SMODS.Joker {
    key = "gusteaus_stahr_bag",
    
    pos = {
        x = 5,
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

    remove_from_deck = function(self, card, from_debuff)
        local free_joker_slots = G.jokers.config.card_limit - #G.jokers.cards
        local stahrs_to_be_created

        if (free_joker_slots >= 3) then
            stahrs_to_be_created = 3
        else 
            stahrs_to_be_created = free_joker_slots
        end

        for i = 1, stahrs_to_be_created do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                for i = 1, 3 do
                    play_sound('mahrlatr_star',1.0,0.5) --calling this at a lower volume
                end
                
                SMODS.add_card({key = 'j_mahrlatr_the_stahr'})
                
                return true
            end }))
        end
    end
}