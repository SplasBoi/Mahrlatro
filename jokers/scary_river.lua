local tally_suits = nil
local pick_pseudorandom_suit = nil
local get_buffed_suit = nil

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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 2,

    config = {
        extra = {
            mult = 12,
            suit = 'Spades'
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.mult,
                localize(e.suit, 'suits_plural'),
                
                colours = {
                    G.C.SUITS[e.suit]
                }
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.ending_shop or context.ending_booster or context.change_suit or context.playing_card_added or context.remove_playing_cards then
            local tally = tally_suits(G.playing_cards)

            e.suit = get_buffed_suit(tally)
        end
        
        if context.individual and context.cardarea == G.play then
            if not context.other_card:is_suit(e.suit) then return end

            return {
                mult = e.mult
            }
        end
    end
}

get_buffed_suit = function(tally)
    local min_suits = {}
    local min_nums = math.huge

    for _, v in pairs(tally) do
        if v.count <= min_nums then
            -- Clears table if is suit of less cards on its own
            if (v.count < min_nums) then
                min_suits = {}
            end
            
            -- Adds to table
            table.insert(min_suits, v.name)
            
            min_nums = v.count
        end
    end

    -- If there is more than one suit with less cards, picks a random one.
    return min_suits[math.random(1, #min_suits)]
end

tally_suits = function(cards_in_deck)
    local spades_count = 0
    local clubs_count = 0
    local hearts_count = 0
    local diamonds_count = 0

    for _, v in pairs(G.playing_cards) do
        if not SMODS.has_enhancement(v, 'm_stone') then
            if v:is_suit("Spades", true) then spades_count = spades_count + 1
            elseif v:is_suit("Clubs", true) then clubs_count = clubs_count + 1
            elseif v:is_suit("Hearts", true) then hearts_count = hearts_count + 1
            elseif v:is_suit("Diamonds", true) then diamonds_count = diamonds_count + 1
            end
        end
    end

    local tally_table = {
        spades = {
            name = "Spades",
            count = spades_count
        },
        clubs = {
            name = "Clubs",
            count = clubs_count
        },
        hearts = {
            name = "Hearts",
            count = hearts_count
        },
        diamonds = {
            name = "Diamonds",
            count = diamonds_count
        }
    }

    return tally_table
end