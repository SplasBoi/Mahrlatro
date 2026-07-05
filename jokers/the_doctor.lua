local register_money_spent = nil
local rounded_decimals = 1

SMODS.Joker { --The Doctor
    key = "the_doctor",

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
    rarity = 3,

    config = {
        extra = {
            x_mult_gained = 0.1,
            current_x_mult = 1.0,
            upgrade_threshold = 1,
            money_spent = 0
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult_gained,
                localize('$'),
                card.ability.extra.upgrade_threshold,
                card.ability.extra.current_x_mult
            }
        }
    end,
    
    calculate = function(self, card, context)
        -- If joker/booster pack is bought.
        if context.buying_card or context.open_booster then
            -- Ignore money spent on itself.
            if context.card and context.card ~= card then
                register_money_spent(card, context.card.cost)
            end
        end

        -- If shop is rerolled, add cost to the count.
        if context.reroll_shop then
            register_money_spent(card, G.GAME.current_round.reroll_cost - 1)
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            local prev_mult = card.ability.extra.current_x_mult
            local new_mult = math.max( 1, MahrMath.round(prev_mult / 2, rounded_decimals) )

            if prev_mult > new_mult then
                card.ability.extra.current_x_mult = new_mult
                
                return {
                    message = (new_mult == 1) and localize('the_doctor_back_to_1x') or localize('the_doctor_halved')
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

register_money_spent = function(card, amount)
    local e = card.ability.extra

    e.money_spent = e.money_spent + amount
    e.current_x_mult = MahrMath.round(e.current_x_mult + (amount * e.x_mult_gained), rounded_decimals)

    card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = localize('k_upgrade_ex'),
        colour = G.C.ATTENTION
    })
end