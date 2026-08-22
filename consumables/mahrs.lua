SMODS.Consumable:take_ownership('c_mars',
    { -- table of properties to change from the existing object
    pos = { x = 1, y = 0 },
    atlas = 'CustomPlanets',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    true -- silent suppresses mod badge
)