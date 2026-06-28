SMODS.Joker{ --Supahr Nutellio
    key = "supahrnutellio",

    config = {
        extra = {
            chips = 67
        }
    },
    
    pos = {
        x = 5,
        y = 1
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
                card.ability.extra.chips
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local star_count = 0

            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.key == 'j_mahrlatr_thestahr' then
                    star_count = star_count + 1

                    card_eval_status_text(joker, 'extra', nil, nil, nil, {
                            message = '+'.. star_count,
                            colour = G.C.CHIPS
                    })
                end
            end

            if star_count > 0 then
                local total_chips = star_count * card.ability.extra.chips
                
                return {
                    chips = total_chips,
                    "EZ!"
                }
            end
        end
    end
}