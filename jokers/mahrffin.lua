SMODS.Joker { --Mahrffin
    key = "mahrffin",

    config = {
        extra = {
            dollars = 1,
            required_jokers_to_merge = {"j_mahrlatr_fish", "j_mahrlatr_meat"}
        }
    },
    
    pos = {
        x = 0,
        y = 2
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
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.before then
            return {
                func = function()
                    ease_dollars(card.ability.extra.dollars)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra', nil, nil, nil, {
                            message = "+".. localize('$').. card.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end
            }
        end

        if context.ending_shop then
            if JokerUtility.can_merge_jokers(e.required_jokers_to_merge) then
                return {
                    func = function ()
                        return JokerUtility.slice_and_merge_jokers(
                            context,
                            card,
                            "j_mahrlatr_mahrbles_trolley",
                            G.C.RED,
                            "Collected!",
                            "Mahrble has awake!"
                        )
                    end
                }
            end
        end
    end
}