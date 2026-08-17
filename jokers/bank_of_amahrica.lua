SMODS.Joker:take_ownership('j_credit_card',
    { -- table of properties to change from the existing object
    pos = { x = 1, y = 1 },
    atlas = 'CustomJokers',
    --loc_vars = function(self, info_queue, card)
    --    return {
    --        vars = {
    --            localize('$'),
    --            get_debt_amount(card)
    --        }
    --    }
    --end,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)