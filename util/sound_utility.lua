SoundUtility = {}

function SoundUtility.sound_exists(key)
    if type(key) == "string" then
        return SMODS.Sounds[key]
    end
    return false
end

function SoundUtility.play_sound_if_exists(key, pitch, volume)
    if type(pitch) ~= "number" then
        pitch = 1.0
    end

    if type(volume) ~= "number" then
        volume = 1.0
    end

    if SoundUtility.sound_exists(key) then
        play_sound(key, pitch, volume)
    end
end