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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    HEX('009440'),
                    HEX('FEDF00'),
                    HEX('302681')
                },

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