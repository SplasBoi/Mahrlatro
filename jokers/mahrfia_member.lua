
SMODS.Joker { --Mahrfia Member
    key = "mahrfia_member",

    config = {
        extra = {
            dollars = 5,
            suit = "Hearts"
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
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                localize('$'),
                e.dollars,
                e.suit
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.destroy_card and context.destroy_card.should_destroy then
            return {
                remove = true
            }
        end

        if context.individual and context.cardarea == G.play and context.other_card:is_suit(e.suit) then
            context.other_card.should_destroy = true

            if context.other_card._mahrfia_bought then
                return
            else
                context.other_card._mahrfia_bought = true
            end

            return {
                func = function()
                    local amount = e.dollars
                    ease_dollars(amount)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra',
                        nil,
                        nil,
                        nil,
                        {
                            message = "+"..localize('$').. amount,
                            colour = G.C.MONEY
                        }
                    )
                end,
                extra = {
                    message = localize("mahrfia_member_card_destroyed"),
                    colour = G.C.RED
                }
            }
        end
    end
}