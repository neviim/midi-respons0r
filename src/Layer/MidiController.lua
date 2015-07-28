
--- ======================================================================================================
---
---                                                 [ Midi Controller ]


class "MidiController"


function MidiController:__init()
end

function MidiController:connect(midi_device_name)
    self.midi_out    = renoise.Midi.create_output_device(midi_device_name)
end

function MidiController:send(channel, parameter, value)
    self.midi_out:send({channel, parameter, value})
end

