
SMODS.Joker{ 
    key = "skibidi_gimler",
    config = {
        extra = {
            gained_x_chips = 1,
            scaling = 0.5
        }
    },

    pos = {
        x = 1,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.gained_x_chips,
                card.ability.extra.scaling
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return {
                remove = true
            }
        end

        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                context.other_card.should_destroy = true

                --print("scale")
                
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'gained_x_chips',
                    scalar_value = 'scaling'
                })
            end
        end

        if context.joker_main then
            return {
                x_chips = card.ability.extra.gained_x_chips
            }
        end
    end
}