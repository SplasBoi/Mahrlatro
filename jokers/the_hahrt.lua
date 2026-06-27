
SMODS.Joker{ --The Hahrt
    key = "thehahrt",
    config = {
        extra = {
            mult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'The Hahrt',
        ['text'] = {
            [1] = 'Played cards with {C:hearts}Heart{} suit give {C:mult}+3{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                return {
                    mult = 3
                }
            end
        end
    end
}