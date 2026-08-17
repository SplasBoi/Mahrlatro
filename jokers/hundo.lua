SMODS.Joker {
    key = "hundo",

    pos = {
        x = 4,
        y = 16
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 7,
    rarity = 2,

    config = {
        extra = {
            scaling = 1,
            current_dollars_received = 0,
            played_poker_hands = {}
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
        local e = card.ability.extra
        if context.before then
            if TableUtility.contains_individual(context.scoring_name, e.played_poker_hands) then return end

            table.insert(e.played_poker_hands, context.scoring_name)

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