local function is_unique(joker_key, already_owned)
    return not TableUtility.contains_individual(joker_key, already_owned)
end

SMODS.Joker {
    key = "le_festin",

    pos = {
        x = 4,
        y = 12
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            mult = 0,
            scaling = 4,
            already_owned = {}
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.mult,
                e.scaling
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.joker_main then
            return {
                mult = e.mult
            }
        end

        if context.buying_card then
            local card_key = context.card.config.center.key
            if (context.card.config.center.pools or {}).mahrlatr_food_jokahr then
                if not is_unique(card_key, e.already_owned) then
                    return
                end

                SMODS.scale_card(card, {
                    ref_table = e,
                    ref_value = "mult",
                    scalar_value = "scaling"
                })
                
                table.insert(e.already_owned, card_key)
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "mult",
                }
            },
            text_config = { colour = G.C.MULT }
        }
    end
}