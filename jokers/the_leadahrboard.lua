local get_random_card = nil

SMODS.Joker {
    key = 'the_leadahrboard',

    pos = {
        x = 1,
        y = 8
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            mult = 10,
            random_rank = 'Ace'
        }
    },

    -- Gives 10 Mult if card with rank () is scored (idol at home)
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.mult,
                localize(e.random_rank, 'ranks')
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.random_rank = get_random_card()
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.value == card.ability.extra.random_rank then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.random_rank = get_random_card()
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    retrigger_type = "mult"
                },
            },

            text_config = { colour = G.C.MULT },

            reminder_text = {
                { text = "(" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "rank",
                    colour = G.C.ORANGE
                },
                { text = ")" }
            },

            reminder_text_config = { scale = 0.35 },

            calc_function = function(card)
                local e = card.ability.extra
                local mult = 0

                local in_blind = JokerUtility.is_in_blind()
                local hand = in_blind and G.hand.highlighted or {}
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()

                if text == "Unknown" then
                    card.joker_display_values.mult = 0
                    return
                end

                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card.facing and not (scoring_card.facing == 'back') and not scoring_card.debuff and scoring_card:get_id() and scoring_card.base.value == e.random_rank then
                        mult = mult + e.mult * JokerDisplay.calculate_card_triggers(scoring_card, hand)
                    end
                end

                card.joker_display_values.mult = mult
                card.joker_display_values.rank = localize(e.random_rank, 'ranks')
            end
        }
    end
}

get_random_card = function()
    local valid_cards = {}

    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end

    local selected_card = pseudorandom_element(valid_cards, 'j_mahrlatr_the_leadahrboard' .. G.GAME.round_resets.ante)
    if selected_card then
        return selected_card.base.value
    end
end