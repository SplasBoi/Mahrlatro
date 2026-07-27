SMODS.Joker { --Mahrffin
    key = "mahrffin",

    config = {
        extra = {
            dollars = 1,
            required_jokers_to_merge = {"j_mahrlatr_fish", "j_mahrlatr_meat"}
        }
    },
    
    pos = {
        x = 0,
        y = 2
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.before then
            return {
                func = function()
                    ease_dollars(card.ability.extra.dollars)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra', nil, nil, nil, {
                            message = "+".. localize('$').. card.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end
            }
        end

        if context.ending_shop then
            if JokerUtility.can_merge_jokers(e.required_jokers_to_merge) then
                return {
                    -- Merged Jokers' Deletion
                    func = function()
                        local sliced_joker

                        for _, v in ipairs(e.required_jokers_to_merge) do
                            for _, joker in ipairs(G.jokers.cards) do
                                -- If it detects a joker already being sliced. Doesn't mark it to be sliced again (nil).
                                if joker.config.center.key == v and not joker.getting_sliced then
                                    sliced_joker = joker
                                    break
                                end
                            end

                            if sliced_joker == nil then return end

                            sliced_joker.getting_sliced = true
                            JokerUtility.slice_joker(sliced_joker)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                                message = "Collected!",
                                colour = G.C.RED
                            })
                        end
                        
                        -- Ends it there if sliced_joker is nil, which means it is already being sliced, so  shouldn't be again.
                        if sliced_joker == nil then return end

                        JokerUtility.slice_joker(card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "Collected!",
                            colour = G.C.RED
                        })
                        
                        -- Mahrble's Trolley Instantiation
                        JokerUtility.instantiate_joker("j_mahrlatr_mahrbles_trolley")

                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = localize('k_plus_joker'),
                            colour = G.C.BLUE
                        })
                            
                        return true
                    end
                }
            end
        end
    end
}