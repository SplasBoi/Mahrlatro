SMODS.Joker {
    key = "takanaka",

    config = {
        extra = {
            chips = 75,
            required_jokers_to_merge = { "j_mahrlatr_feijoada", "j_mahrlatr_bossa_nova" },
            required_language = "pt_BR"
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
        local e = card.ability.extra or self.config.extra
        
        if context.joker_main and G.SETTINGS.language == e.required_language then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.ending_shop then
            if JokerUtility.can_merge_jokers(e.required_jokers_to_merge) then
                return {
                    func = function ()
                        return JokerUtility.slice_and_merge_jokers(
                            context,
                            card,
                            "j_mahrlatr_brasil_mentioned",
                            HEX('009440'),
                            "O Brasil não é para amadores",
                            "HOLY SHIT!! Is that a motherfucking Brasil reference????"
                        )
                    end
                }
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips"
                }
            },
            text_config = { colour = G.C.CHIPS },
            calc_function = function(card)
                local e = card.ability.extra
                
                local chips = (G.SETTINGS.language == e.required_language and e.chips) or 0
                card.joker_display_values.chips = chips
            end
        }
    end
}