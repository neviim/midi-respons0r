
--- ======================================================================================================
---
---                                                 [ Midi Setup ]
--- To Setup for the main

require "Module/Module"
require "Module/TrackDSP/TrackDSP"

class "MidiSetup"


MidiSetupData = {
}



function MidiSetup:__init()
    self.track_dsp = TrackDSP()
--    self.track_dsp:wire_control(self.midi)
end

function MidiSetup:activate()
    self.track_dsp:activate()
end

function MidiSetup:connect_control(options)
--    self.control:connect(options['midi']['name'])
end

function MidiSetup:deactivate()
    self.track_dsp:deactivate()
--    self.control:disconnect()
end

function MidiSetup:wire()
end

