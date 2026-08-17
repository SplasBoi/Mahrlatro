SMODS.Joker{
    key = "januel",

    config = {
        extra = {
            hands = 1,
            discards = 0,
            music_pitch = 0.8,
            original_hand_size
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
    
    calculate = function(self, card, context)
        local handsize = #G.playing_cards
        local e = card.ability.extra

        if context.first_hand_drawn  then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.hands).." Hand", colour = G.C.BLUE})
            G.GAME.current_round.hands_left = card.ability.extra.hands

            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.discards).." Discards", colour = G.C.BLUE})
            G.GAME.current_round.discards_left = card.ability.extra.discards

            e.original_hand_size = G.hand.config.card_limit
            G.hand:change_size(#G.playing_cards - e.original_hand_size)
        end

        if (context.end_of_round and not context.game_over) or context.selling_self then
            if e.original_hand_size == nil then return end
            
            G.hand:change_size(-(#G.playing_cards - e.original_hand_size))
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