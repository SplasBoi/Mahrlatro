SMODS.Joker {
    key = "salad_rng",

    discovered = false,
    unlocked = true,
    atlas = 'CustomJokers',

    pos = {
        x = 3,
        y = 12
    },

    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 0,
    rarity = 1,

    config = {
        extra = {
            denominator_increase = 4
        }
    },

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.mod_probability then
            if context.trigger_obj == card then
                return
            end

            return {
                denominator = context.denominator + e.denominator_increase
            }
        end
    end
}