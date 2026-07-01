SMODS.Rarity {
    key = "krejsi_rarity",
    default_weight = 0.0,

    loc_txt = {
        name = "Krejsi"
    },

    pools = {
        ["Joker"] = true
    },

    get_weight = function(self, weight, object_type)
        return weight
    end,

    badge_colour = HEX('9900FF'),
    text_colour = G.C.WHITE
}