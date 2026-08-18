SMODS.Joker:take_ownership('j_wee',
    { -- table of properties to change from the existing object
    pos = { x = 6, y = 0 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    display_size = {
        w = 71 * 0.7, 
        h = 95 * 0.7},
    },
    false -- silent suppresses mod badge
)