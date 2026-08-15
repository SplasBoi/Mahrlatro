SMODS.Joker{
    key = "januel",

    config = {
        extra = {
            hands = 1,
            discards = 0,
            music_pitch = 0.8
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
                card.ability.extra.hands,
                card.ability.extra.discards
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.first_hand_drawn  then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.hands).." Hand", colour = G.C.BLUE})
            G.GAME.current_round.hands_left = card.ability.extra.hands

            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.discards).." Discards", colour = G.C.BLUE})
            G.GAME.current_round.discards_left = card.ability.extra.discards

            local handsize = #G.playing_cards

            G.hand:change_size(handsize)

        end
    end,

    update = function(self, card, dt)
        if not G or not G.PITCH_MOD then return end
        
        local e = self.config.extra or card.ability.extra

        if card.area == G.jokers and not card.removed then
            G.PITCH_MOD = e.music_pitch
        else
            G.PITCH_MOD = 1.0
        end
    end
}