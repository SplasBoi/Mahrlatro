local function joker_slots_left()
    return G.jokers.config.card_limit - #G.jokers.cards
end

local function create_egg_event()
    return Event({
        trigger = 'immediate',
        func = function()
            if joker_slots_left() > 0 then
                SoundUtility.play_sound_if_exists('mahrlatr_ratatouille_honk')
                SMODS.add_card({key = 'j_egg'})
            end
            return true
        end
    })
end

SMODS.Joker {
    key = "evil_chicken",
    
    pos = {
        x = 6,
        y = 3
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 3,
    rarity = 1,

    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(create_egg_event())
        end
    end
}