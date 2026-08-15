local add_double_tag = nil

SMODS.Joker {
    key = "wayne",

    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    rarity = 3,
    cost = 6,
    pos = { x = 0, y = 7 },

    config = {
        extra = {
            base_numerator = 1,
            base_denominator = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = self.config.extra or card.ability.extra

        local num, denom = SMODS.get_probability_vars(card, e.base_numerator, e.base_denominator)

        return {
            vars = {
                colours = { HEX('000000')},

                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.end_of_round and not context.game_over and context.main_eval then
            local num, denom = SMODS.get_probability_vars(card, e.base_numerator, e.base_denominator)

            add_double_tag()

            if SMODS.pseudorandom_probability(card, card.config.center_key, num, denom) then
                local joker_to_destroy = G.jokers.cards[math.random(#G.jokers.cards)]
                SMODS.destroy_cards(joker_to_destroy)
            end
        end
    end
}

add_double_tag = function()
    G.E_MANAGER:add_event(Event({
        func = function()
            add_tag({ key = 'tag_double' })
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
            return true
        end
    }))
end