SMODS.Consumable:take_ownership('c_mercury',
    { -- table of properties to change from the existing object
    pos = { x = 0, y = 0 },
    atlas = 'CustomPlanets',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    true -- silent suppresses mod badge
)