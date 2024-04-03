-- Required ST provided libraries
local log = require('log')
local caps = require('st.capabilities')



-----------------------------------------------------------------
-- Lifecycle functions
-----------------------------------------------------------------

local lifecycles = {}

-- This function is called once a device is added by the cloud and synchronized down to the hub
function lifecycles.init(driver, device)
  log.info("[" .. device.id .. "] Initializing device")

  if device.vendor_provided_label == 'vDeviceCreator' then
    device:emit_event(Cap_createdevice.deviceType("Idle"))
  elseif device.vendor_provided_label == 'vFan' then
    device:emit_event(caps.fanSpeed.fanSpeed(0))
  end
end


-- This function is called both when a device is added (but after `added`) and after a hub reboots
function lifecycles.added(driver, device)
  log.info("[" .. device.id .. "] Adding new device")
end


-- This function is called when a device is removed by the cloud and synchronized down to the hub
function lifecycles.removed(_, device)
  log.info("[" .. device.id .. "] Removing device")
end


-- This function is called when the preferences of the device have changed
function lifecycles.infoChanged(driver, device, event, args)
  log.info("[" .. device.id .. "] Info changed")
end


-- This function is called when the platform believes the device needs to go through provisioning for it to work as expected
function lifecycles.doConfigure(driver, device)
  log.info("[" .. device.id .. "] Do configure")
end

return lifecycles