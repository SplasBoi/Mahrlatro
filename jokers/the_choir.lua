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
            x_mult = 2.5,
            base_type = 'Flush'
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.base_type
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local contains_flush = next(context.poker_hands[card.ability.extra.base_type])

            -- Very cheap solution, but works.
            -- Almost all hands in the game contain a Pair.
            -- Tried for over an hour to use the context.poker_hands table somehow but to no avail.
            -- I welcome any of you to find a better solution.
            local contains_pair = next(context.poker_hands['Pair']) 
            local contains_straight = next(context.poker_hands['Straight'])

            local contains_other_hand = contains_pair or contains_straight
            
            if contains_flush and contains_other_hand then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end 
        end
    end,

    check_for_unlock = function(self, args)
        return args.type == "hand" and (args.handname == "Flush House" or args.handname == "Flush Five")
    end,
}