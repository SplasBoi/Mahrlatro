SMODS.Joker{
    key = "mahrbot",

    pos = {
        x = 3,
        y = 20
    },

    soul_pos = {
        x = 2,
        y = 20
    },

    cost = 12,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    
                    scored_card:set_seal("mahrlatr_mahr", true)
                    return true
                end
            }))
        end
    end

}
