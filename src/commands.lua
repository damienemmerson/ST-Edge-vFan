local log = require "log"
local caps = require "st.capabilities"
local config = require "config"
local socket = require "socket"

local commands = {}

function commands.handle_createdevice(driver, device, command)

  local deviceType = command.args.value
  
  device:emit_event(Cap_createdevice.deviceType("Creating device"))
 
  commands.create_child_edge_driver(driver, device, deviceType)
  socket.sleep(2)
  device:emit_event(Cap_createdevice.deviceType("Device created"))
  socket.sleep(2)
  device:emit_event(Cap_createdevice.deviceType("Idle"))

end

function commands.handle_fanSpeed(driver, device, command)

  local speed = command.args.speed

  log.info ('fanSpeed value changed to ', speed)
  device:emit_event(caps.fanSpeed.fanSpeed(speed))
end

-- Creates child devices
function commands.create_child_edge_driver(driver, device, deviceType)
 
  local device_profile

  -- Set device profile for Somfy RTS Blinds
  if deviceType == "fan" then    
    device_profile = 'vFan'
  end

  -- Set child device metadata
  if device_profile then
    local child_device_metadata = {
      type = config.DEVICE_TYPE,
      label = deviceType,
      device_network_id = deviceType..os.time(),
      profile = device_profile,
      manufacturer = config.DEVICE_MANUFACTURER,
      model = config.DEVICE_MODEL,
      vendor_provided_label = device_profile,
      parent_device_id = device.id
    }

    -- Create the child device
    driver:try_create_device(child_device_metadata)
  end
end

return commands