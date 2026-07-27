SMODS.Joker {
    key = "noiflo",

    pos = {
        x = 2,
        y = 14
    },

    display_size = {
        w = 71,
        h = 95
    },

    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    config = { extra = { max = 500, min = 1 } },

    loc_vars = function(self, info_queue, card)
        local r_chips = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_chips[#r_chips + 1] = tostring(i)
        end

        local main_start = {
            { n = G.UIT.T, config = { text = '+', colour = G.C.CHIPS, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_chips, colours = { G.C.CHIPS }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            { n = G.UIT.T, config = { text = ' chips', colour = G.C.CHIPS, scale = 0.32 } },

        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            play_sound('mahrlatr_noiflo')
            return {
                chips = pseudorandom('mahrlatr_noiflo', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end
}