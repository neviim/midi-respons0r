

class "TrackDSP" (Module)

function TrackDSP:__init()
    Module:__init(self)
end

function TrackDSP:_activate()
end

function TrackDSP:_deactivate()
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


