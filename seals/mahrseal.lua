
SMODS.Seal {
    key = 'mahrseal',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            mult0 = 10,
            mult = 10
        }
    },
    badge_colour = HEX('000000'),
    loc_txt = {
        name = 'Mahr Seal',
        label = 'Mahr Seal',
        text = {
            [1] = 'Gives {C:red}10 mult{} for every Mahr Jokahr'
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = 10
            }
        end
    end
}