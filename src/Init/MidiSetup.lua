
--- ======================================================================================================
---
---                                                 [ Midi Setup ]
--- To Setup for the main

require "Module/Module"
require "Module/TrackDSP/TrackDSP"
require "Layer/MidiController"

class "MidiSetup"


MidiSetupData = {
}



function MidiSetup:__init()
    self.midi = MidiController()
    self.track_dsp = TrackDSP()
    self.track_dsp:wire_midi(self.midi)
end

function MidiSetup:activate()
    self.track_dsp:activate()
end

function MidiSetup:connect_midi(options)
--    print(options['midi']['name'])
    self.midi:connect(options['midi']['name'])
end

function MidiSetup:deactivate()
    self.track_dsp:deactivate()
    self.midi:disconnect()
end

function MidiSetup:wire()
end

