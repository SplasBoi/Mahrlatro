SMODS.Joker {
    key = "gusteaucombo",

    config = {
        extra = {
            blind_adjustment_percentage = 25,
            blind_score,
            blind_reward,
            blind
        }
    },

    -- Fix when we have the art.
    pos = {
        x = 2,
        y = 10
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.blind_adjustment_percentage
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.blind = G.GAME.blind
            card.ability.extra.blind_score = G.GAME.blind.chips
            card.ability.extra.blind_reward = G.GAME.blind.dollars

            G.GAME.blind.dollars = 0
            G.GAME.current_round.dollars_to_be_earned = string.rep(localize('$'), 0)

            return {
                 xblindsize = 1 - card.ability.extra.blind_adjustment_percentage / 100
            }
        end

        if context.selling_self and G.GAME.blind.in_blind then
            card.ability.extra.blind.chips = card.ability.extra.blind_score
            card.ability.extra.blind.dollars = card.ability.extra.blind_reward
            G.GAME.current_round.dollars_to_be_earned = string.rep(localize('$'), card.ability.extra.blind_reward)
        end
    end
}