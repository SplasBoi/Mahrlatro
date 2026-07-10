SMODS.Joker {
    key = "funny_numbers",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 9 },
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    config = { extra = { repetitions = 1 } },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 6 or id == 7 or id == 8 or id == 9 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}