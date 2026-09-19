
SMODS.Consumable {
    key = 'mahr_mentioned',
    set = 'Tarot',

    pos = {
        x = 2,
        y = 2
    },

    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',

    config = {
        extra = {
            target_seal = "mahrlatr_mahr",
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                localize(e.target_seal .. "_seal", "labels")
            }
        }
    end,

    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end,
    
    use = function(self, card, area, copier)
        local e = card.ability.extra or self.config.extra

        local used_card = copier or card

        local targets = {}
        for i = 1, #G.hand.highlighted do
            targets[i] = G.hand.highlighted[i]
        end

        if #targets == 1 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            for i, c in ipairs(targets) do
                local percent = 1.15

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        if c and c.flip then
                            c:flip()
                            play_sound("card1", percent)
                            c:juice_up(0.3, 0.3)
                        end
                        return true
                    end
                }))
            end

            delay(0.2)

            for _, c in ipairs(targets) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        if c then
                            c:set_seal(e.target_seal, nil, true)
                        end
                        return true
                    end
                }))
            end

            for _, c in ipairs(targets) do
                local percent = 1.0

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        if c and c.flip then
                            c:flip()
                            play_sound("tarot2", percent, 0.6)
                            c:juice_up(0.3, 0.3)
                        end
                        return true
                    end
                }))
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))

            delay(0.5)

            return {
                message = "The Mahr!?"
            }
        end
    end
}