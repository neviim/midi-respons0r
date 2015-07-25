--- ======================================================================================================
---
---                                                 [ Main UI ]
---
--- To Create the Dialog, functionallity will be given by wires.


class "MainUI"

function MainUI:__init()
    self.vb = renoise.ViewBuilder()
    self.button_size = 18
    self.text_size   = 70
    self.input_size  = 200
    self.command_button_size = 80
    -- text-area
    self.textarea_height = 100
    self.textarea_width = 70 + 200 + 18 + 4 + 4
    self.is_running = false
    self.default_osc_port = '8000'
    self:unregister_run_callback()
    self:unregister_quit_callback()
    self:unregister_stop_callback()
end

function MainUI:create_ui()
    self:create_logo()
    self:create_textarea()
    self:create_device_row()
    self:create_start_stop_button()
    self:create_quit_button()
    self:create_container()
end

function MainUI:boot()
    self:device_row_update_device_list()
end

function MainUI:create_container()
    self.container = self.vb:column{
        margin = 6,
        spacing = 8,
        self.vb:horizontal_aligner{
            mode = "center",
            self.logo,
        },
        self.vb:column {
            spacing = 4,
            margin = 4,
            self.textarea,
            self.osc_row,
            self.device_row,
            self.rotation_row,
        },
        self.vb:row {
            margin = 4,
            spacing = 4,
            self.start_stop_button,
            self.quit_button,
        }
    }
end

function MainUI:create_logo()
    self.logo = self.vb:bitmap{
        bitmap = "logo.png",
        mode = "transparent",
    }
end

--- ======================================================================================================
---
---                                                 [ Textarea Row ]

function MainUI:create_textarea()
    self.textarea_text = {
        "Configuration",
        "=============",
        "Ch1 ParamX : dsp parameters X of the current DSP",
        "Ch2 Param0 : selected dsp as MIDI value (0-127)",
        "Ch2 Param1-127 : selected dsp as MIDI value 0"
    }
    self.textarea = self.vb:multiline_text{
        paragraphs = self.textarea_text,
        width = self.textarea_width,
        height = self.textarea_height,
    }
end

--- ======================================================================================================
---
---                                                 [ Device Row ]

function MainUI:create_device_row()
    self.device_row_button = self.vb:button{
        visible = true,
        bitmap  = "reload.bmp",
        width   = self.button_size,
        tooltip = "reload device list",
        notifier = function ()
            self:device_row_update_device_list()
        end,
    }
    self.device_row_popup = self.vb:popup {
        width = self.input_size,
        tooltip = "Choose a Device to operate on"
    }
    self.device_row = self.vb:row{
        spacing = 3,
        self.device_row_button,
        self.vb:text{
            text = "Device",
            width = self.text_size,
        },
        self.device_row_popup,
    }
end

function MainUI:disable_device_row()
    self.device_row_button.active = false
    self.device_row_popup.active = false
end

function MainUI:enable_device_row()
    self.device_row_button.active = true
    self.device_row_popup.active = true
    self:device_row_update_device_list()
end


function MainUI:register_device_update_callback(callback)
    self.device_update_callback = callback
end

function MainUI:device_row_update_device_list()
    if (self.device_update_callback) then
        self.device_row_popup.items = self.device_update_callback()
    end
end

function MainUI:selected_device()
    local list_of_lauchpad_devices = self.device_row_popup.items
    return list_of_lauchpad_devices[self.device_row_popup.value]
end



--- ======================================================================================================
---
---                                                 [ Start Stop Buttons ]

function MainUI:create_start_stop_button()
    self.start_stop_button = self.vb:button {
        text = "Start",
        width = self.command_button_size,
        notifier = function ()
            if self.is_running then
                self:stop()
            else
                self:run()
            end
        end
    }
end

function MainUI:create_quit_button()
    self.quit_button = self.vb:button {
        text = "Quit",
        width = self.command_button_size,
        notifier = function ()
            self:quit()
        end,
    }
end

--- returns an object of all configurations
function MainUI:run_properties()
    return {
        midi = {
            name = self:selected_device(),
        }
    }
end

function MainUI:register_run_callback(callback)
    self.run_callback = callback
end

function MainUI:unregister_run_callback()
    self.run_callback = function (_) end
end

function MainUI:run()
    self.is_running = true
    self.start_stop_button.text = "Stop"
    self:disable_device_row()
    self.run_callback(self:run_properties())
end

function MainUI:register_stop_callback(callback)
    self.stop_callback = callback
end

function MainUI:unregister_stop_callback()
    self.stop_callback = function (_) end
end

function MainUI:stop()
    self.is_running = false
    self.start_stop_button.text = "Start"
    self:enable_device_row()
    self.stop_callback()
end

function MainUI:register_quit_callback(callback)
    self.quit_callback = callback
end

function MainUI:unregister_quit_callback()
    self.quit_callback = function (_) end
end

function MainUI:quit()
    self.quit_callback()
    print("quit")
end
