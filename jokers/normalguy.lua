SMODS.Joker{
    key = "normalguy",
    loc_txt = {
        ['name'] = 'Normal Guy',
        ['text'] = {
            [1] = {
                'Sets:',
                '{C:blue}Hands{} to {C:blue}#1#{}',
                '{C:red}Discards{} to {C:red}#2#{}',
                '{V:1}Joker Slots{} to {V:1}#3#{}',
                '{C:purple}Consumable Slots{} to {C:purple}#4#{}'
            },
            [2] = {
                'Destroys overflowing',
                'jokers/consumables',
                'from right to left',
                "(excluding Normal Guy)."
            }
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },

    pos = {
        x = 5,
        y = 1
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 8,
    rarity = 3,

    config = {
        extra = {
            hands = 4,
            discards = 3,
            joker_slots = 5,
            consumable_slots = 2,
            added_hands,
            added_discards,
            added_joker_slots,
            added_consumable_slots
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX('FF00FF') },

                card.ability.extra.hands,
                card.ability.extra.discards,
                card.ability.extra.joker_slots,
                card.ability.extra.consumable_slots
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        --if (not self:is_solo(G.jokers.cards)) then return end

        card.ability.extra.added_hands = card.ability.extra.hands - G.GAME.round_resets.hands
        card.ability.extra.added_discards = card.ability.extra.discards - G.GAME.current_round.discards_left
        card.ability.extra.added_joker_slots = card.ability.extra.joker_slots - G.jokers.config.card_limit
        card.ability.extra.added_consumable_slots = card.ability.extra.consumable_slots - G.consumeables.config.card_limit

        ease_hands_played(card.ability.extra.added_hands)
        ease_discard(card.ability.extra.added_discards)

        G.jokers.config.card_limit = card.ability.extra.joker_slots

        if (#G.jokers.cards > card.ability.extra.joker_slots) then
            local overflowing_jokers = #G.jokers.cards - card.ability.extra.joker_slots + 1

            for i = #G.jokers.cards, 1, -1 do
                if overflowing_jokers <= 0 then
                    break
                end

                if G.jokers.cards[i] ~= self then
                    overflowing_jokers = overflowing_jokers - 1
                    
                    G.jokers.cards[i].getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1

                    G.E_MANAGER:add_event(Event({ func = function()
                        G.GAME.joker_buffer = 0

                        G.jokers.cards[i]:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)

                        return true
                    end }))
                end
            end
        end

        G.consumeables.config.card_limit = card.ability.extra.consumable_slots

        if (#G.consumeables.cards > card.ability.extra.consumable_slots) then
            for i = 3, #G.consumeables.cards do
                G.consumeables.cards[i].getting_sliced = true
                
                G.E_MANAGER:add_event(Event({func = function()
                    G.consumeables.cards[i]:start_dissolve({HEX("57ecab")}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                    
                    return true
                    end
                }))
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        --if (not self:is_solo(self, G.jokers.cards)) then return end
        
        ease_hands_played(-card.ability.extra.added_hands)
        ease_discard(-card.ability.extra.added_discards)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.added_joker_slots
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.added_consumable_slots
    end
}