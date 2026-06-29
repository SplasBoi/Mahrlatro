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
            total_spent = 0,
            upgrades_applied = 0
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult_gained,
                card.ability.extra.upgrade_threshold,
                card.ability.extra.current_x_mult,
                card.ability.extra.total_spent % card.ability.extra.upgrade_threshold,
            }
        }
    end,
    
    calculate = function(self, card, context)
        -- If joker/booster pack is bought.
        if context.buying_card or context.open_booster then
            -- Ignore money spent on itself.
            if context.card and context.card ~= card then
                card.ability.extra.total_spent = card.ability.extra.total_spent + context.card.cost
            end
        end

        -- If shop is rerolled, add cost to the count.
        if context.reroll_shop then
           card.ability.extra.total_spent = card.ability.extra.total_spent + (G.GAME.current_round.reroll_cost - 1)
        end

        -- Get target upgrade level
        local upgrades = math.floor(card.ability.extra.total_spent / card.ability.extra.upgrade_threshold)

        -- Upgrade the card to the target upgrade level
        while card.ability.extra.upgrades_applied < upgrades do
            card.ability.extra.upgrades_applied = card.ability.extra.upgrades_applied + 1

            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'current_x_mult',
                scalar_value = 'x_mult_gained',
                message_colour = G.C.ATTENTION
            })
        end

        if context.end_of_round and not context.repetition and not context.individual and card.ability.extra.upgrades_applied > 0 then
            local current = card.ability.extra.current_x_mult
            local new = math.max(1, current / 2)

            card.ability.extra.current_x_mult = new
            
            return {
                -- This should use localized text but i cannot figure out how the localize function gets the value
                message = (new == 1) and "Back where it began!" or "Halved!"
            }
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.current_x_mult,
            }
        end
    end
}