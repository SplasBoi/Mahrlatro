SMODS.Joker {
    key = "luahr",

    pos = {
        x = 2,
        y = 15
    },

    soul_pos = {
        x = 3,
        y = 15
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

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            chips = 0,
            scaling = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.scaling,

                colours = {
                    HEX('CECE00'), -- 1 card_is_modified
                    HEX('38BDF8'), -- 2 ()
                    HEX('38BDF8'), -- 3 ability
                    HEX('FF0080'), -- 4 keywords
                    HEX('9447E2'), -- 5 +=
                    HEX('FF870B'), -- 6 numbers
                    HEX('00FFFF'), -- 7 functions
                    HEX('0D1117')  -- 8 bg
                }
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.change_suit or context.change_rank or (context.setting_ability and not context.unchanged and G.P_CENTERS[context.new].set == 'Enhanced') then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'chips',
                scalar_value = 'scaling'
            })
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}