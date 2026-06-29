SMODS.Seal {
    key = 'mahr',

    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            mult = 10
        }
    },

    badge_colour = HEX('8B27F5'),

    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.seal.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.seal.extra.mult
            }
        end
    end
}