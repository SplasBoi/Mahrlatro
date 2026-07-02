SMODS.Joker {
    key = "black_metahrl",

    pos = {
        x = 1,
        y = 4
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 5,
    rarity = 2,

    config = {
        extra = {
            chance = 8
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX('000000') },

                card.ability.extra.chance
            }
        }
    end,

    calculate = function(self, card, context)
        if #G.consumeables.cards >= G.consumeables.config.card_limit then
            return
        end

        if context.individual and context.cardarea == G.play and SuitHelpers.is_black_card(context.other_card) then
            if RNG.roll_chance(card.ability.extra.chance) then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card { set = 'Tarot' }

                        return true
                    end)
                }))

                return {
                    message = localize('k_plus_tarot'),
                }
            end
        end
    end
}