local function get_buffed_suit(tally_table)
    if type(tally_table) ~= "table" or #tally_table > 1 then
        return "Multiple"
    end

    local min_suits = {}
    local min_nums = math.huge

    for suit, count in pairs(tally_table) do
        if count <= min_nums then
            -- Clears table if is suit of less cards on its own
            if (count < min_nums) then
                min_suits = {}
            end
            
            -- Adds to table
            table.insert(min_suits, suit)
            
            min_nums = count
        end
    end

    if #min_suits > 1 then
        return "Multiple"
    end

    return min_suits[1]
end

local function tally_suits(deck)
    local tally_table = {}

    for _, playing_card in ipairs(deck) do
        if not JokerUtility.is_stone_card(playing_card) then
            local suit = playing_card.base.suit
            tally_table[suit] = (tally_table[suit] or 0) + 1
        end
    end

    return tally_table
end

SMODS.Joker {
    key = "scary_river",

    pos = {
        x = 3,
        y = 9
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
    atlas = "CustomJokers",
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 2,

    config = {
        extra = {
            mult = 12,
            suit = "Multiple"
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.mult,
                e.suit,
                
                colours = {
                    G.C.SUITS[e.suit] or HEX("AAAAAA")
                }
            }
        }
    end,

    update = function(self, card, front)
        if not G.playing_cards then
            return
        end

        local e = card.ability.extra
        local tally = tally_suits(G.playing_cards)

        e.suit = get_buffed_suit(tally)
        if (e.suit and e.suit ~= "Multiple") then
            localize(e.suit, "suits_plural")
        end
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.individual and context.cardarea == G.play then
            if e.suit == "Multiple" or not context.other_card:is_suit(e.suit) then
                return 
            end

            return {
                mult = e.mult
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    retrigger_type = "mult"
                },
            },

            text_config = { colour = G.C.MULT },
            
            reminder_text = {
                { text = "(" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "buffed_suit"
                },
                { text = ")" },
            },

            calc_function = function(card)
                local e = card.ability.extra
                local mult = 0
                
                if e.suit == "Multiple" then
                    card.joker_display_values.buffed_suit = "Multiple"
                    card.joker_display_values.mult = mult
                    return
                else
                    card.joker_display_values.buffed_suit = localize(e.suit, "suits_plural")
                end

                local text, _, scoring_hand = JokerDisplay.evaluate_hand()

                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit(e.suit) and not scoring_card.debuff and not JokerUtility.is_stone_card(scoring_card) then
                            mult = mult + e.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end

                card.joker_display_values.mult = mult
            end,

            style_function = function(card, text, reminder_text, extra)
                local e = card.ability.extra

                if reminder_text and reminder_text.children[2] then
                    reminder_text.children[2].config.colour = G.C.GREY

                    if e.suit ~= "Multiple" then
                        reminder_text.children[2].config.colour = lighten(G.C.SUITS[e.suit], 0.35)
                    end
                end
            end
        }
    end
}