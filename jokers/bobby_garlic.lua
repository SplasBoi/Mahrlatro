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

local function play_sound_from_event(sound_id)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            play_sound(sound_id)
            return true
        end
    }))
end

SMODS.Joker {
    key = "bobby_garlic",

    discovered = false,
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
            poker_hand = "High Card"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra
        return {
            vars = {
                e.x_mult,
                localize(e.poker_hand, "poker_hands")
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.poker_hand = get_random_poker_hand(card)
        play_sound("mahrlatr_bobby_try_this_hand")
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.joker_main and context.scoring_name == e.poker_hand then

            return {
                x_mult = e.x_mult,
                message = localize("bobby_good_job"),
                play_sound_from_event("mahrlatr_bobby_good_job")
            }
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            e.poker_hand = get_random_poker_hand(card)

            return {
                message = localize("bobby_try_this_hand"),
                play_sound_from_event("mahrlatr_bobby_try_this_hand")
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "X" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "x_mult"
                }
            },
            text_config = { colour = G.C.RED },
            calc_function = function(card)
                local e = card.ability.extra
                local hand_name = JokerDisplay.current_hand_info.text
                
                if hand_name ~= "NULL" and hand_name == e.poker_hand then
                    card.joker_display_values.x_mult = e.x_mult
                else
                    card.joker_display_values.x_mult = 1
                end
            end
        }
    end
}
