SMODS.Joker { --Meat
    key = "meat",
    
    pos = {
        x = 1,
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            mult = 7
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    
    calculate = function(self, card, context)
        local has_red_suit = false

        if context.final_scoring_step then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Hearts') or context.scoring_hand[i]:is_suit('Diamonds') then
                    has_red_suit = true
                    break
                end
            end
        end

        if has_red_suit then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}