--- ======================================================================================================
---
---                                                 [ Logging Layer ]

function log(key, value)
    if value then
    else
    end
end

function add_notifier(observable, handler)
    if observable:has_notifier(handler) then
        return
    end
    observable:add_notifier(handler)
end

function remove_notifier(observable, handler)
    if observable:has_notifier(handler) then
        --print(handler)
        observable:remove_notifier(handler)
    -- else
       --print("no notifier found")
       --print(handler)
    end
end

function create_bank()
    return {
        bank = {},
        min  = 1,
        max  = 1,
        mode = BankData.mode.copy
    }
end

function midi_to_value(midi_value, current_value, min_value, max_value )
    print("default")
    local a = (max_value - min_value)
--    print("a : " .. a)
    local c = a * midi_value / 127
--    print("c : " .. c)
    local d = c + min_value
--    print("d : " .. d)
    return d
end

function midi_to_value_log(midi_value, current_value, min_value, max_value )
    print("exp")
    local a = (max_value - min_value)
    local c = a * ( 1 - math.log(128 - midi_value)/math.log(128))
    local d = c + min_value
    print("d : " .. d)
    return d
end

function value_to_midi(min_value, max_value, current_value)
    local a = current_value - min_value
    local b = max_value - min_value
    local result = math.floor((a / b) * 127)
    if result > -1 then
        return result
    else
        return 0
    end
end
