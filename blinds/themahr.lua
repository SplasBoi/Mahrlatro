SMODS.Blind {
    key = "themahr",
    
    dollars = 5,
    mult = 1,

    boss = {
        min = 1,
        max = 10,
        showdown = true
    },

    atlas = 'CustomBlinds',

    pos = {
        x = 0,
        y = 0
    },

    boss_colour = HEX("F5CC27"),

    recalc_debuff = function(self, card, from_blind)
        if card.area == G.jokers then
            if card.config.center.rarity == 1 then
                return true
            end
        end

        return false
    end
}