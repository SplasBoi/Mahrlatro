SMODS.Joker { --The Doctor
    key = "thedoctor",

    pos = {
        x = 5,
        y = 0
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

    cost = 6,
    rarity = 2,

    config = {
        extra = {
            x_mult_gained = 1.0,
            upgrade_threshold = 20,
            current_x_mult = 1.0,
            to_next = 0
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult_gained,
                card.ability.extra.upgrade_threshold,
                card.ability.extra.current_x_mult,
                card.ability.extra.to_next,
            }
        }
    end,
    
    calculate = function(self, card, context)
        -- If joker/booster pack is bought, adds its cost to the count.
        if context.buying_card or context.open_booster then
            card.ability.extra.to_next = card.ability.extra.to_next + context.card.cost
        end

        -- If shop is rerolled, adds cost to the count.
        if context.reroll_shop then
           card.ability.extra.to_next = card.ability.extra.to_next + G.GAME.current_round.reroll_cost - 1
        end

        -- If spent count exceeds 20, adds to the XMult and then resets the count.
        if (card.ability.extra.to_next >= card.ability.extra.upgrade_threshold) then
            local times_over = math.floor(card.ability.extra.to_next / card.ability.extra.upgrade_threshold)
            
            card.ability.extra.to_next = card.ability.extra.to_next - (card.ability.extra.upgrade_threshold * times_over)
            
            if (times_over > 0) then
                for i = 1, times_over do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = 'current_x_mult',
                        scalar_value = 'x_mult_gained',
                        message_colour = G.C.ATTENTION
                    })
                end
            end
        end

        if context.end_of_round and not context.repetition and not context.individual then
            local current = card.ability.extra.current_x_mult
            
            if (current / 2 < 1) then
                card.ability.extra.current_x_mult = 1

                return {
                    message = 'Back where it began!'
                }
            
            else
                card.ability.extra.current_x_mult = current / 2

                return {
                    message = 'Halved!'
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.current_x_mult,
            }
        end
    end
}