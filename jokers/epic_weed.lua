
SMODS.Joker{ --Epic Weed
    key = "epic_weed",
    config = {
        extra = {
            mult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Epic Weed',
        ['text'] = {
            [1] = 'Played cards with {C:uncommon}Club{} suit give {C:mult}+3{} Mult when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
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
            if context.other_card:is_suit("Clubs") then
                return {
                    mult = 3
                }
            end
        end
    end
}