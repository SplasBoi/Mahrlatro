SMODS.Joker {
    key = "mahrio",
    
    pos = {
        x = 6,
        y = 4
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 3,
    rarity = 1,

    config = {
        extra = {
            --numerator = 1,
            --denominator = 3
            dollars = 2,
            scaling = 2,
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        --local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)

        return {
            vars = {
                --colours = { HEX('000000') },

                --num,
                --denom

                e.dollars,
                e.scaling,
                localize('$')
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            local stahr_count = JokerUtility.jokers_owned("j_mahrlatr_the_stahr")
            
            if stahr_count > 0 then
                SoundUtility.play_sound_if_exists("mahrlatr_mahrio_haha")
                
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config.center.key == "j_mahrlatr_the_stahr" then
                        JokerUtility.slice_joker(joker)

                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = 'dollars',
                            scalar_value = 'scaling',
                            no_message = true
                        })
                    end
                end
            end

            return {
                message = localize("mahrio_collected"),
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        local dollars = card.ability.extra.dollars

        if dollars > 0 then
            return dollars
        end
    end,
}