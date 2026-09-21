SMODS.Joker {
    key = "the_choir",

    pos = {
        x = 5,
        y = 7
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 8,
    rarity = 3,

    config = {
        extra = {
            x_mult = 4.5,
            hand1 = 'Flush',
            hand2 = 'Three of a Kind'
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                localize(card.ability.extra.hand1, 'poker_hands'),
                localize(card.ability.extra.hand2, 'poker_hands')
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local contains_flush = next(context.poker_hands[card.ability.extra.hand1])
            local contains_3oak = next(context.poker_hands[card.ability.extra.hand2])
            
            if contains_flush and contains_3oak then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end 
        end
    end,

    check_for_unlock = function(self, args)
        return args.type == "hand" and (args.handname == "Flush House" or args.handname == "Flush Five")
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                    }
                }
            },

            text_config = { colour = G.C.WHITE },

            calc_function = function(card)
                local e = card.ability.extra
                local _, poker_hands, _ = JokerDisplay.evaluate_hand()

                local contains_flush = poker_hands[e.hand1] and next(poker_hands[e.hand1])
                local contains_3oak = poker_hands[e.hand2] and next(poker_hands[e.hand2])
                
                card.joker_display_values.x_mult = 1
                
                if contains_flush and contains_3oak then
                    card.joker_display_values.x_mult = e.x_mult
                end 
            end
        }
    end
}