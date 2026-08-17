SMODS.Joker{
    key = "januel",

    config = {
        extra = {
            hands = 1,
            discards = 0,
            music_pitch = 0.8,
            added_hand_size
        }
    },

    pos = {
        x = 6,
        y = 13
    },

    soul_pos = {
        x = 0,
        y = 14
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 7,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

        loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands,
                card.ability.extra.discards
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        local e = card.ability.extra
        e.original_hand_size = G.hand.config.card_limit
    end,

    calculate = function(self, card, context)
        local handsize = #G.playing_cards
        local e = card.ability.extra

        if context.first_hand_drawn then
            e.added_hand_size = draw_entire_deck(G.hand.config.card_limit, card, context)
        end

        if (context.end_of_round and context.main_eval and not context.game_over) or (context.selling_self and G.GAME.blind.boss) then
            if e.added_hand_size == nil then return end
    
            G.hand:change_size(-e.added_hand_size)
        end
    end,

    update = function(self, card, dt)
        if not G or not G.PITCH_MOD then return end
        
        local e = card.ability.extra

        if card.area == G.jokers and not card.removed then
            G.PITCH_MOD = e.music_pitch
        else
            G.PITCH_MOD = 1.0
        end
    end
}

draw_entire_deck = function(original_hand_size, card, context)
    local e = card.ability.extra

    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(e.hands).." Hand", colour = G.C.BLUE})
    G.GAME.current_round.hands_left = e.hands

    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(e.discards).." Discards", colour = G.C.BLUE})
    G.GAME.current_round.discards_left = e.discards

    local amount = #G.playing_cards - original_hand_size
    G.hand:change_size(amount)

    return amount
end