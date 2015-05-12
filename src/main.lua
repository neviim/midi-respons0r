require 'Init/MidiSetup'
require 'Init/MainUI'
require 'Init/AboutUI'

require 'Layer/Util'


-- Reload the script whenever this file is saved.
-- Additionally, execute the attached function.
_AUTO_RELOAD_DEBUG = function()  end

-- Read from the manifest.xml file.
class "RenoiseScriptingTool" (renoise.Document.DocumentNode)
  function RenoiseScriptingTool:__init()    
    renoise.Document.DocumentNode.__init(self) 
    self:add_property("Name",    "Untitled Tool")
    self:add_property("Id",      "Unknown Id")
    self:add_property("Version", "Unknown Version")
  end

local manifest     = RenoiseScriptingTool()
local ok,err       = manifest:load_from("manifest.xml")
local tool_name    = manifest:property("Name").value
local tool_id      = manifest:property("Id").value
local tool_version = manifest:property("Version").value


-- Placeholder for the dialog
local main_dialog = nil
local main_ui = nil

local about_dialog = nil
local about_ui = nil

local midi_setup = nil

local control = nil







--- ======================================================================================================
---
---                                                 [ Main Dialog ]


function create_main_UI()
    main_ui = MainUI()
    main_ui:register_run_callback(function (options)
        midi_setup:connect_control(options)
        midi_setup:activate()
    end)
    main_ui:register_stop_callback(function ()
        midi_setup:deactivate()
    end)
    main_ui:register_device_update_callback(function ()
        local list = {}
        for _,v in pairs(renoise.Midi.available_input_devices()) do
            if string.find(v, "nanoKONTROL2") then
                table.insert(list,v)
            end
        end
        return list
    end)
    main_ui:create_ui()
    main_ui:boot()
end

function update_main_UI_callbacks(main_dialog)
    main_ui:register_quit_callback(function()
        if (main_dialog) then
            main_dialog:close()
        end
    end)
end


local function show_about()
    if not about_ui then
        about_ui = AboutUI()
        about_ui:create_ui()
    end
    renoise.app():show_custom_dialog("About ".. tool_name  .. " " .. tool_version, about_ui.container)
end

local function show_main_dialog()

    -- This block makes sure a non-modal dialog is shown once.
    -- If the dialog is already opened, it will be focused.
    if main_dialog and main_dialog.visible then
        main_dialog:show()
        return
    end

    if not midi_setup then
        midi_setup = MidiSetup()
        midi_setup:wire()
    end

    if not main_ui then
        create_main_UI()
    end

    main_dialog = renoise.app():show_custom_dialog(tool_name .. " " .. tool_version, main_ui.container)
    update_main_UI_callbacks(main_dialog)

end




--- ======================================================================================================
---
---                                                 [ Menu Entry ]


renoise.tool():add_menu_entry {
    name = "Main Menu:Tools:"..tool_name,
    invoke = show_main_dialog
}
renoise.tool():add_menu_entry {
    name = "Main Menu:Help:".. "About "..tool_name,
    invoke = show_about
}
