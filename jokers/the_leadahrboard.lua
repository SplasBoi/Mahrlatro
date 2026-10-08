local function get_random_card(card)
    local valid_cards = {}

    if not G.playing_cards then
        return nil
    end

    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end

    return pseudorandom_element(valid_cards, card.config.center_key .. card.unique_val)
end

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
            random_value,
            random_rank
        }
    },
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        local loc_rank

        if e.random_value then
            loc_rank = localize(e.random_value, "ranks")
        else
            loc_rank = localize("Ace", "ranks")
        end

        return {
            vars = {
                e.mult,
                loc_rank
            }
        }
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local e = card.ability.extra

        if initial then
            local selected_card = get_random_card(card)

            if selected_card then
                e.random_value = selected_card.base.value
                e.random_rank = selected_card:get_id()
            end
        end
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == e.random_rank then
                return {
                    mult = e.mult
                }
            end
        end

        if context.end_of_round and context.main_eval then
            local selected_card = get_random_card(card)
            
            if selected_card then
                e.random_value = selected_card.base.value
                e.random_rank = selected_card:get_id()
            end
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

                card.joker_display_values.mult = mult
                card.joker_display_values.rank = localize(e.random_value, 'ranks')

                local in_blind = JokerUtility.is_in_blind()
                local hand = in_blind and G.hand.highlighted or {}
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()

                if text == "Unknown" then return end

                for _, scoring_card in pairs(scoring_hand) do
                    if not scoring_card.debuff and not SMODS.has_no_rank(scoring_card) and scoring_card:get_id() == e.random_rank then
                        mult = mult + e.mult * JokerDisplay.calculate_card_triggers(scoring_card, hand)
                    end
                end

                card.joker_display_values.mult = mult
            end
        }
    end
}