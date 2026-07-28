SMODS.Joker {
    key = "hundo",

    -- Fix when we have the art.
    pos = {
        x = -1,
        y = -1
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 7,
    rarity = 2,

    config = {
        extra = {
            scaling = 1,
            current_dollars_received = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.scaling,
                card.ability.extra.current_dollars_received,
                localize('$')
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round == 1 then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'current_dollars_received',
                scalar_value = 'scaling'
            })
        end
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.current_dollars_received
    end,
}