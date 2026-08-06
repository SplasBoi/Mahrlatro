SMODS.Consumable {
    key = 'pink_tower',
    set = 'Tarot',
    unlocked = true,
    discovered = true,

    atlas = 'CustomConsumables',

    pos = { x = 2, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'mahrlatr_pink_stone' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}