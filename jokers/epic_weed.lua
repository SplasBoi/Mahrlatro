
SMODS.Joker { --Epic Weed
    key = "epic_weed",

    config = {
        extra = {
            mult = 3,
            required_jokers_to_merge = {"j_mahrlatr_vaalserberg", "j_erosion"}
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
    discovered = false,
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
                    func = function ()
                        return JokerUtility.slice_and_merge_jokers(
                            context,
                            card,
                            "j_mahrlatr_dutch_plus_ratio",
                            G.C.DIAMONDS,
                            "Dit is Nederlands!",
                            "Too Dutch for you!!"
                        )
                    end
                }
            end
        end
    end
}