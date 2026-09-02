local obtained_sound_pool = {
    "mahrlatr_benjamin_place_01",
    "mahrlatr_benjamin_place_02",
    "mahrlatr_benjamin_theres_me_smart"
}

local destroyed_sound_pool = {
    "mahrlatr_benjamin_game_over"
}

local boss_blind_sound_pool = {
    "mahrlatr_benjamin_might_wanna_take_a_look",
    "mahrlatr_benjamin_uh_guys_01",
    "mahrlatr_benjamin_uh_guys_02"
}

local blind_defeated_sound_pool = {
    "mahrlatr_benjamin_nice",
    "mahrlatr_benjamin_oh_yeah",
    "mahrlatr_benjamin_awesome",
    "mahrlatr_benjamin_dude",
    "mahrlatr_benjamin_yes",
    "mahrlatr_benjamin_haha",
    "mahrlatr_benjamin_hah",
    "mahrlatr_benjamin_level_up",
    "mahrlatr_benjamin_sliced_and_diced"
}

local get_sound_from_pool = function(pool)
    if not pool or type(pool) ~= "table" then
        return ""
    end

    local pool_size = #pool

    if pool_size < 1 then
        return ""
    end

    return pool[math.random(1, pool_size)]
end

SMODS.Joker:take_ownership('j_cavendish',
    { -- table of properties to change from the existing object
    pos = { x = 0, y = 0 },
    atlas = 'Benjamin',

    add_to_deck = function(self, card, from_debuff)
        play_sound(get_sound_from_pool(obtained_sound_pool))
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra or {}

        if not e.odds then
            e.odds = 1000
        end
        
        if not e.Xmult then
            e.Xmult = 3
        end

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'cavendish', 1, e.odds) then
                return {
                    message = localize('k_extinct_ex'),
                    play_sound(get_sound_from_pool(destroyed_sound_pool)),
                    func = function()
                        SMODS.destroy_cards(card, nil, nil, true)
                    end
                }
            else
                return {
                    message = localize('k_safe_ex'),
                    play_sound(get_sound_from_pool(blind_defeated_sound_pool))
                }
            end
        end

        if context.setting_blind and context.blind.boss then
            return {
                play_sound(get_sound_from_pool(boss_blind_sound_pool))
            }
        end
        
        if context.joker_main then
            return {
                xmult = e.Xmult
            }
        end
    end,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true }
    },
    false -- silent suppresses mod badge
)