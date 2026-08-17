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
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

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
        local e = card.ability.extra

        return {
            vars = {
                localize('$'),
                e.current_debt,
                e.loan,
                e.installment_value,
                e.interest_value
            }
        }
    end,

    check_for_unlock = function(self, args)
        return G.GAME.dollars < 0
    end,

    can_sell = function(self, card, context)
        return false
    end,

    add_to_deck = function(self, card, from_debuff)
        local e = card.ability.extra

        ease_dollars(e.loan)
        e.current_debt = e.loan
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.end_of_round and context.main_eval then
            local interest = math.abs(e.installment_value + e.interest_value)
            
            ease_dollars(-interest)

            card_eval_status_text(
                card, 'extra', nil, nil, nil, {
                    message = localize('$').. -interest,
                    colour = G.C.RED
                }
            )

            e.current_debt = e.current_debt - e.installment_value

            if e.current_debt <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
            end
        end
    end
}

local loan_shark_key = "j_mahrlatr_loan_shark"

local og_set_sell_value = Card.set_sell_value
Card.set_sell_value = function(self)
    if self.config.center.key == loan_shark_key then
        return 0
    end

    og_set_sell_value(self)
end