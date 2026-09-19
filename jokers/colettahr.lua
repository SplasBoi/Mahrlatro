local function get_random_poker_hand(card)
    local current_hand = card.ability.extra.poker_hand or ""
    local poker_hands = {}

    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and handname ~= current_hand then
            table.insert(poker_hands, handname)
        end
    end

    return pseudorandom_element(poker_hands, card.config.center_key)
end

SMODS.Joker {
    key = "colettahr",

    discovered = false,
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
            poker_hand = "High Card"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, "poker_hands")
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.poker_hand = get_random_poker_hand(card)
        SoundUtility.play_sound_if_exists("mahrlatr_mahr_no_no_dont")
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.before and context.scoring_name == e.poker_hand then
            return {
                func = function()
                    level_up_hand(card, e.poker_hand)
                end
            }
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            e.poker_hand = get_random_poker_hand(card)

            return {
                message = localize('colettahr_do_as_i_say'),
                SoundUtility.play_sound_if_exists("mahrlatr_mahr_no_no_dont")
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "poker_hand_loc",
                    colour = G.C.ORANGE
                },
                { text = ")" }
            },

            calc_function = function(card)
                local e = card.ability.extra

                card.joker_display_values.poker_hand_loc = localize(e.poker_hand, "poker_hands")
            end
        }
    end
}