
SMODS.Joker { --Mahrfia Member
    key = "mahrfia_member",

    config = {
        extra = {
            dollars = 5
        }
    },

    pos = {
        x = 1,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if context.other_card:is_suit("Hearts") then
                context.other_card.should_destroy = true
                return {
                    func = function()
                        local amount = card.ability.extra.dollars
                        ease_dollars(amount)
                        card_eval_status_text(
                            context.blueprint_card or card,
                            'extra',
                            nil,
                            nil,
                            nil,
                            {
                                message = "+"..localize('$')..amount,
                                colour = G.C.MONEY
                            }
                        )
                    end,
                    extra = {
                        message = localize('mahrfia_member_card_destroyed'),
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}