SMODS.Joker {
    key = "takanaka",

    config = {
        extra = {
            chips = 75
        }
    },

    pos = {
        x = 2,
        y = 11
    },

    display_size = {
        w = 71,
        h = 95
    },

    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if G.SETTINGS.language == 'pt_BR' and context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}