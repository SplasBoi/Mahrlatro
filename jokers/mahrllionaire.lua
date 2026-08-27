SMODS.Joker:take_ownership('j_bootstraps',
    { -- table of properties to change from the existing object
    pos = { x = 5, y = 10 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)