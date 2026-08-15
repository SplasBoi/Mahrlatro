SMODS.Joker {
    key = "four_fingahrs",
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    pos = { x = 1, y = 14 },
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },


}

local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type, ...)
    if next(SMODS.find_card('j_mahrlatr_four_fingahrs')) then
        return 4
    end
    return smods_four_fingers_ref(hand_type, ...)
end