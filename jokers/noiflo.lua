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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    config = { extra = { max = 500, min = 1 } },

    loc_vars = function(self, info_queue, card)
        local r_chips = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_chips[#r_chips + 1] = tostring(i)
        end

        local loc_chips = ' Chips '

        local main_start = {
            { n = G.UIT.T, config = { text = '+', colour = G.C.CHIPS, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_chips, colours = { G.C.CHIPS }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.CHIPS },
                            loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips,
                            loc_chips, loc_chips, loc_chips, loc_chips },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },

        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            SoundUtility.play_sound_if_exists('mahrlatr_noiflo')
            return {
                chips = pseudorandom('mahrlatr_noiflo', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        local e = G.P_CENTERS["j_mahrlatr_noiflo"].config.extra

        return {
            text = {
                { text = "+", colour = G.C.CHIPS },
                {
                    dynatext = {
                        string = (
                            function()
                                local r_mult = {}

                                for i = e.min, e.max do
                                    r_mult[#r_mult + 1] = tostring(i)
                                end

                                return r_mult
                            end
                        )(),
                        colours = { G.C.CHIPS },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.5,
                        scale = 0.4,
                        min_cycle_time = 0
                    }
                }
            }
        }
    end
}