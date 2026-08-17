SMODS.Joker {
    key = "speedrunnahr",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 5, y = 13 },
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            chips = 0,
            chip_mod = 15,
            required_hand = "Straight"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.chips,
                e.chip_mod
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.before and not context.blueprint and next(context.poker_hands[e.required_hand]) then
            e.chips = e.chips + e.chip_mod

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        
        if context.joker_main then
            return {
                chips = e.chips
            }
        end
    end
}