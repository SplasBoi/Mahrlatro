SMODS.Joker {
    key = "bobby_garlic",

    discovered = true,
    unlocked = true,
    atlas = 'CustomJokers',

    pos = {
        x = 1,
        y = 5
    },
    
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 1,
    cost = 4,

    config = {
        extra = {
            x_mult = 2,
            poker_hand = 'High Card'
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                localize(card.ability.extra.poker_hand, 'poker_hands')
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        local _poker_hands = {}

        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
                play_sound('mahrlatr_bobby_try_this_hand')
            end
        end

        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'j_mahrlatr_bobby_garlic')
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == card.ability.extra.poker_hand then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize('bobby_good_job'),
                    play_sound('mahrlatr_bobby_good_job')
                }
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}

            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end

            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'j_mahrlatr_bobby_garlic')

            return {
                play_sound('mahrlatr_bobby_try_this_hand'),
                message = localize('bobby_try_this_hand')
            }
        end
    end
}