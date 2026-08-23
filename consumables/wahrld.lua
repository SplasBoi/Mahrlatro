SMODS.Consumable:take_ownership('c_world',
    { -- table of properties to change from the existing object
    pos = { x = 1, y = 2 },
    atlas = 'CustomConsumables'
    },
    true -- silent suppresses mod badge
)