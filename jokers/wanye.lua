SMODS.Joker {
    key = "wanye",
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    rarity = 2,
    cost = 6,
    pos = { x = 6, y = 6 },

    config = {
        extra = {
            numerator = 1,
            denominator = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)

        return {
            vars = {
                colours = { HEX('000000') },

                num,
                denom
            }
        }
    end,


    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and SMODS.pseudorandom_probability(card, 'j_mahrlatr_wanye', card.ability.extra.numerator, card.ability.extra.denominator) then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_double' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true
        end
    end

    -- i cannot figure out how to make this guy destroy a joker 😭
}