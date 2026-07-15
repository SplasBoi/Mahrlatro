local set_random_poker_hand = nil

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
        card.ability.extra.poker_hand = get_random_poker_hand(card)
        play_sound("mahrlatr_bobby_try_this_hand")
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.poker_hand then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize('bobby_good_job'),
                sound = "mahrlatr_bobby_good_job"
            }
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            card.ability.extra.poker_hand = get_random_poker_hand(card)

            return {
                message = localize('bobby_try_this_hand'),
                sound = "mahrlatr_bobby_try_this_hand"
            }
        end
    end
}

get_random_poker_hand = function(card)
    local current_hand = card.ability.extra.poker_hand or ""
    local poker_hands = {}

    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and handname ~= current_hand then
            table.insert(poker_hands, handname)
        end
    end

    return pseudorandom_element(poker_hands, card.config.center_key)
end