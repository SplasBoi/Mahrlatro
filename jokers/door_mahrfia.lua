SMODS.Joker {
    key = "door_mahrfia",

    config = {
        extra = {
            dollars = 1,
            poker_hand = 'Pair'
        }
    },

    pos = {
        x = 1,
        y = 10
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars,
                localize(e.poker_hand, "poker_hands")
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if next(context.poker_hands[e.poker_hand]) then
                for _, v in ipairs(context.scoring_hand) do
                    context.other_card.should_destroy = true
                end
                
                return {
                    func = function()
                        local amount = card.ability.extra.dollars
                        ease_dollars(amount)
                        card_eval_status_text(
                            context.blueprint_card or card,
                            'extra',
                            nil,
                            nil,
                            nil,
                            {
                                message = "+"..localize('$')..amount,
                                colour = G.C.MONEY
                            }
                        )
                    end
                }
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        
        return {
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" }
            },

            text_config = {
                colour = G.C.GOLD
            },
            
            calc_function = function(card)
                local e = card.ability.extra

                card.joker_display_values.dollars = 0

                local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()

                if poker_hands[e.poker_hand] and next(poker_hands[e.poker_hand]) then
                    local count = 0

                    if text ~= 'Unknown' then
                        for k, v in pairs(scoring_hand) do
                            count = count + 1
                        end
                        
                        card.joker_display_values.dollars = count * card.ability.extra.dollars
                    end
                end
            end
        }
    end
}