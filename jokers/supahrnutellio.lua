SMODS.Joker{ --Supahr Nutellio
    key = "supahrnutellio",

    config = {
        extra = {
            chips = 67,
            current_chips = 67
        }
    },
    
    pos = {
        x = 4,
        y = 2
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.current_chips
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.card_added or context.selling_card or context.joker_type_destroyed then
            local stahrs_found = 0

            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.key == 'j_mahrlatr_thestahr' then
                    stahrs_found = stahrs_found + 1
                end
            end

            if context.card_added and context.card.config.center.key == 'j_mahrlatr_thestahr' then
                stahrs_found = stahrs_found + 1
            end
            if (context.selling_card or context.joker_type_destroyed) and context.card.config.center.key == 'j_mahrlatr_thestahr' then
                stahrs_found = stahrs_found - 1
            end

            local total_chips = card.ability.extra.chips + (stahrs_found * card.ability.extra.chips)
            card.ability.extra.current_chips = total_chips
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.current_chips,
                message = 'EZ!'
            }
            
        end
    end
}