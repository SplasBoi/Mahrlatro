SMODS.Joker{ --Supahr Nutellio
    key = "supahrnutellio",

    config = {
        extra = {
            chips = 67
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
                math.max(get_stahr_count() * card.ability.extra.chips, card.ability.extra.chips)
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local stahr_count = get_stahr_count()

            if stahr_count > 0 then
                local total_chips = stahr_count * card.ability.extra.chips
                return {
                    chips = total_chips,
                    message = 'EZ!'
                }
            
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

function get_stahr_count()
    local count = 0
    for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key == 'j_mahrlatr_thestahr' then
            count = count + 1
        end
    end
    return count
end
        