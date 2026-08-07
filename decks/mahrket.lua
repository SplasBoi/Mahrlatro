SMODS.Back {
    key = "mahrket",

    atlas = "CustomBacks",
    pos = {
        x = 1,
        y = 0
    },

    unlocked = true,

    config = {
        extra = {
            vouchers = 2
        }
    },

    apply = function(self, back)
        local conf = self.config

        G.GAME.starting_params.vouchers_in_shop = conf.extra.vouchers
    end
}