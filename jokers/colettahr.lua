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
            poker_hand = ""
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, "poker_hands")
            }
        }
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local e = card.ability.extra

        if initial then
            e.poker_hand = JokerUtility.get_random_poker_hand(card)
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        SoundUtility.play_sound_if_exists("mahrlatr_mahr_no_no_dont")
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.before and context.scoring_name == e.poker_hand then
            return {
                func = function()
                    level_up_hand(card, e.poker_hand)
                end
            }
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            e.poker_hand = JokerUtility.get_random_poker_hand(card)

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