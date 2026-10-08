SMODS.Joker{
    key = "mahrbot",

    pos = {
        x = 3,
        y = 20
    },

    soul_pos = {
        x = 2,
        y = 20
    },

    cost = 12,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            target_seal = "mahrlatr_mahr"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                localize(e.target_seal .. "_seal", "labels")
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.individual and context.cardarea == G.play then
            local scored_card = context.other_card

            if scored_card:get_seal() ~= e.target_seal then
                return {
                    func = function()
                        local immediate = false
                        local silent = false
                        scored_card:set_seal(e.target_seal, immediate, silent)
                    end
                }
            end
        end
    end

}
