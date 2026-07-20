SMODS.Joker {
    key = "loan_shark",

    pos = {
        x = 6,
        y = 11
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true, -- I was thinking about having an unlock condition for this one: being negative in money at any póint. I will not add it yet because I don't know how to do it. I'll probably look into that after we are done with the jokahrs I guess.
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 0,
    rarity = 3,

    config = {
        extra = {
            current_debt = 0,
            loan = 50,
            installment_value = 5,
            interest_value = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.current_debt,
                card.ability.extra.loan,
                card.ability.extra.installment_value,
                card.ability.extra.interest_value
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        ease_dollars(card.ability.extra.loan)

        card.ability.extra.current_debt = card.ability.extra.loan
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.end_of_round and context.main_eval then
            ease_dollars(-(e.installment_value + e.interest_value))
            e.current_debt = e.current_debt - e.installment_value

            card_eval_status_text(
                card,
                'extra',
                nil,
                nil,
                nil,
                {
                    message = localize('$')..-(e.installment_value + e.interest_value),
                    colour = G.C.RED
                }
            )

            if card.ability.extra.current_debt == 0 then
                SMODS.destroy_cards(card, nil, nil, true)
            end
        end
    end
}

local og_can_sell = Card.can_sell_card
Card.can_sell_card = function(self, context, ...)
    if self.config.center.key == 'j_mahrlatr_loan_shark' then
        return false
    end

    return og_can_sell(self, context)
end

local og_set_sell_value = Card.set_sell_value
Card.set_sell_value = function(self)
    if self.config.center.key == 'j_mahrlatr_loan_shark' then
        return 0
    end

    og_set_sell_value(self)
end