

class "TrackDSP" (Module)

function TrackDSP:__init()
    Module:__init(self)
    self:__create_dsp_parameter_dump()
    self:__create_dsp_index_dump()
end

function TrackDSP:wire_midi(midi)
    self.midi = midi
end

function TrackDSP:_activate()
    add_notifier(renoise.song().selected_track_device_observable, self.__dsp_parameter_dump)
    add_notifier(renoise.song().selected_track_device_observable, self.__dsp_index_dump)
end

function TrackDSP:_deactivate()
    remove_notifier(renoise.song().selected_track_device_observable, self.__dsp_parameter_dump)
    remove_notifier(renoise.song().selected_track_device_observable, self.__dsp_index_dump)
end

function TrackDSP:__create_dsp_index_dump()
    self.__dsp_index_dump = function ()
        --- send dsp index
        local index = renoise.song().selected_track_device_index
        if (index > 126 or index == nil) then index = 127  end
        -- on parameter 0 via velocity
        self.midi:send(0xb1, 0, index)
--        print("index dump (0)" .. 0 .. " -> " .. index)
        -- via paramter (using binary velocity)
        for parameter = 1, 127 do
            local value = 0
            if parameter == index then
                value = 127
            end
            self.midi:send(0xb1, parameter, value)
--            print("index dump " .. parameter .. " -> " .. value)
        end
    end
end

function TrackDSP:__create_dsp_parameter_dump()
    self.__dsp_parameter_dump = function ()
        --- send dsp parameters
        local selected_dsp = renoise.song().selected_track_device
        if (selected_dsp) then
            for i, parameter in ipairs(selected_dsp.parameters) do
                -- parameter.name
                -- parameter.value_min
                -- parameter.value_max
                -- parameter.value
                -- fixme negative midi_values are possible, the function should not return negative values
                local midi_value = value_to_midi(parameter.value_min, parameter.value_max, parameter.value)
--                print("paramter dump " .. i .. " -> " .. midi_value .. " [" ..parameter.value_min .. "," .. parameter.value .. "," .. parameter.value_max .. "]")
                self.midi:send(0xb0 , i - 1 , midi_value)
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


