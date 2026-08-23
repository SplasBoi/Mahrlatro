SMODS.Consumable {
    key = "pink_tower",
    set = "Tarot",
    unlocked = true,
    discovered = true,

    atlas = "CustomConsumables",

    pos = { x = 4, y = 2 },

    config = {
        max_highlighted = 1,
        mod_conv = 'm_mahrlatr_pink_stone'
    },

    can_use = function(self, card)
        local conf = self.config or card.ability

        local selected_cards = #G.hand.highlighted
        return selected_cards > 0 and selected_cards <= conf.max_highlighted
    end
}