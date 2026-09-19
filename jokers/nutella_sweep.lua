
local get_mult
local get_consumables_used

SMODS.Joker{ --Nutella Sweep
    key = "nutella_sweep",

    config = {
        extra = {
            mult_bonus = 0.25
        }
    },

    pos = {
        x = 2,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                get_mult(card)
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = get_mult(card)
            }
        end
    end,
    
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "x_mult",
                            retrigger_type = "exp"
                        }
                    }
                }
            },
            text_config = { colour = G.C.WHITE },

            calc_function = function(card)
                local consumables_used = get_consumables_used()
                card.joker_display_values.x_mult = 1
                
                if consumables_used > 0 then
                    card.joker_display_values.x_mult = 1 + get_consumables_used() * card.ability.extra.mult_bonus
                end
            end
        }
    end
}

get_mult = function(card)
    local consumable_count = get_consumables_used()

    if consumable_count == 0 then
        return 1
    end

    return 1 + (consumable_count * card.ability.extra.mult_bonus)
end

get_consumables_used = function()
    local count = 0
    local consumables = G.GAME.consumeable_usage or {}

    for k, v in pairs(consumables) do
        if v.set == 'Planet' then
            count = count + 1
        end
    end
    return count
end