
SMODS.Joker { --Epic Weed
    key = "epic_weed",

    config = {
        extra = {
            mult = 3,
            required_jokers_to_merge = {"j_mahrlatr_vaalserberg", "j_mahrlatr_sea_level"}
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = {
                    G.C.SUITS["Clubs"]
                }
            }
        }
    end,

    pos = {
        x = 4,
        y = 1
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.ending_shop then
            local e = card.ability.extra

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
                                message = "Dit is Nederlands!!",
                                colour = G.C.DIAMONDS
                            })
                        end
                        
                        -- Ends it there if sliced_joker is nil, which means it is already being sliced, so  shouldn't be again.
                        if sliced_joker == nil then return end

                        JokerUtility.slice_joker(card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "Dit is Nederlands!",
                            colour = G.C.DIAMONDS
                        })
                        
                        -- Dutch Plus Ratio Instantiation
                        JokerUtility.instantiate_joker("j_mahrlatr_dutch_plus_ratio")

                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "Too Dutch for you.",
                            colour = G.C.DIAMONDS
                        })
                            
                        return true
                    end
                }
            end
        end
    end
}