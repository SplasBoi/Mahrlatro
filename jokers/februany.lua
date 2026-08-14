SMODS.Joker {
    key = "februany",

    pos = {
        x = 2,
        y = 8
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            current_mult = 0,
            scaling = 2,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.current_mult,
                card.ability.extra.scaling,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'current_mult',
                scalar_value = 'scaling',
                message_colour = G.C.ATTENTION
            })
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.current_mult
            }
        end
    end,

    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}