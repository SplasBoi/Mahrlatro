SMODS.Joker { --Mahrfia Member
    key = "door_mahrfia",

    config = {
        extra = {
            dollars = 1
        }
    },

    -- Fix when we have the art.
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
        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if next(context.poker_hands['Pair']) then
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
    end
}