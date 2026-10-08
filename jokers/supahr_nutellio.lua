local function get_stahr_count()
    if not G.jokers then
        return 0
    end

    local count = 0
    for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key == 'j_mahrlatr_the_stahr' then
            count = count + 1
        end
    end
    return count
end
        

SMODS.Joker{
    key = "supahr_nutellio",

    config = {
        extra = {
            chips = 67,
            required_jokers_to_merge = {
                "j_mahrlatr_nutella_sweep",
                "j_mahrlatr_nutellas_cahr"
            }
        }
    },
    
    pos = {
        x = 4,
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips + (get_stahr_count() * card.ability.extra.chips)
            }
        }
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.joker_main then
            local stahr_count = get_stahr_count()

            if stahr_count < 1 then
                return {
                    chips = card.ability.extra.chips
                }
            else
                local base_chips = e.chips
                local total_chips = base_chips + (stahr_count * base_chips)
                local blueprint = context.blueprint
                
                return {
                    chips = total_chips,
                    message = localize('supahr_nutellio_easy'),
                    func = function ()
                        if not blueprint then SoundUtility.play_sound_if_exists("mahrlatr_nutella_easy") end
                    end
                }
            end
        end

        if context.ending_shop and JokerUtility.can_merge_jokers(e.required_jokers_to_merge) then
            return {
                func = function ()
                    return JokerUtility.slice_and_merge_jokers(
                        context,
                        card,
                        "j_mahrlatr_romahrnia",
                        HEX('002B7F'),
                        "EZ!",
                        "Bine ai venit în Româhrnia!"
                    )
                end
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips"
                }
            },
            text_config = { colour = G.C.CHIPS },

            calc_function = function(card)
                local e = card.ability.extra

                local stahr_count = get_stahr_count()

                if stahr_count < 1 then
                    card.joker_display_values.chips = e.chips
                else
                    card.joker_display_values.chips = e.chips + (e.chips * stahr_count)
                end
            end
        }
    end
}