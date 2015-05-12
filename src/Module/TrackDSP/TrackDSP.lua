

class "TrackDSP" (Module)

function TrackDSP:__init()
    Module:__init(self)
    self:__create_parameter_dump()
end

function TrackDSP:_activate()
    add_notifier(renoise.song().selected_track_device_observable, self.__parameter_dump)
end

function TrackDSP:_deactivate()
    remove_notifier(renoise.song().selected_track_device_observable, self.__parameter_dump)
end

function TrackDSP:__create_parameter_dump()
    self.__parameter_dump = function ()
        print_current_dsp()
        local selected_dsp = renoise.song().selected_track_device
        if (selected_dsp) then
            for i, parameter in ipairs(selected_dsp.parameters) do
                -- parameter.name
                -- parameter.value_min
                -- parameter.value_max
                -- parameter.value
                local midi_value = value_to_midi(parameter.value_min, parameter.value_max, parameter.value)
                print( "chX arg" .. i .. " -> " .. midi_value)
            end
        end
    end
end

function print_current_dsp()
    local selected_dsp = renoise.song().selected_track_device
    if (selected_dsp) then
        print(selected_dsp.name)
        print(selected_dsp.display_name)
        for i, parameter in ipairs(selected_dsp.parameters) do
            print(i .. ")" .. parameter.name .. " : " .. parameter.value_min .. " - " .. parameter.value_max .. " = " .. parameter.value)
        end
    end
end


