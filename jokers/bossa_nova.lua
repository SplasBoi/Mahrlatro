SMODS.Joker {
    key = "bossa_nova",
    
    pos = {
        x = 5,
        y = 2
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 3,

    config = {
        extra = {

        }
    },

    loc_vars = function(self, info_queue, card)
        return {

        }
    end,


    calculate = function(self, card, context)
        if context.selling_self  then
            G.GAME.round_resets.blind_choices.Boss = get_new_boss()
        end
    end
}