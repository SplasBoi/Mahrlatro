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
            dollars = 0,
            played_poker_hands = {}
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                e.scaling,
                e.dollars,
                localize('$')
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.before and not TableUtility.contains_individual(context.scoring_name, e.played_poker_hands) then
            table.insert(e.played_poker_hands, context.scoring_name)

            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "scaling"
            })
        end
    end,

    calc_dollar_bonus = function(self, card)
        local dollars = card.ability.extra.dollars

        if dollars > 0 then
            return dollars
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = localize("$") },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "dollars",
                }
            },
            text_config = { colour = G.C.GOLD },

            reminder_text = {
                {
                    text = "(Every Round)",
                    colour = G.C.ORANGE
                },
            },

            calc_function = function(card)
                local e = card.ability.extra
                card.joker_display_values.dollars = e.dollars
            end
        }
    end
}