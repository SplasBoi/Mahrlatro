local set_random_poker_hand = nil

SMODS.Joker {
    key = "colettahr",

    discovered = true,
    unlocked = true,
    atlas = 'CustomJokers',

    pos = {
        x = 3,
        y = 11
    },
    
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 1,
    cost = 4,

    config = {
        extra = {
            poker_hand = 'High Card'
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, 'poker_hands')
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.poker_hand = get_random_poker_hand(card)
        play_sound("mahrlatr_mahr_no_no_dont")
    end,
    
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            return {
                func = function()
                    level_up_hand(card, card.ability.extra.poker_hand)
                end
            }
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            card.ability.extra.poker_hand = get_random_poker_hand(card)

            return {
                message = localize('colettahr_do_as_i_say'),
                sound = "mahrlatr_mahr_no_no_dont"
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