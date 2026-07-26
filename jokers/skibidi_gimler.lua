
SMODS.Joker{ 
    key = "skibidi_gimler",
    config = {
        extra = {
            gained_x_mult = 1,
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.gained_x_mult,
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
                
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'gained_x_mult',
                    scalar_value = 'scaling'
                })

                return {
                    Xmult = card.ability.extra.gained_x_mult
                }
            end
        end
    end
}