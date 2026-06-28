
SMODS.Seal {
    key = 'mahrseal',

    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            mult = 10
        }
    },

    loc_txt = {
        name = 'Mahr Seal',
        label = 'Mahr Seal',
        text = {
            [1] = 'Gives {C:red}#1# mult{} for every Mahr Jokahr'
        }
    },

    badge_colour = HEX('000000'),

    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                card.ability.extra.mult
            }
        end
    end
}