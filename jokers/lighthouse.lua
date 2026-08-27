SMODS.Joker:take_ownership('j_hologram',
    { -- table of properties to change from the existing object
    pos = { x = 3, y = 17 },
     soul_pos = {
        x = -1, y = -1,
        draw = function(card, scale_mod, rotate_mod)
            return
        end
    },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)