-- Required ST provided libraries
local driver = require('st.driver')
local caps = require('st.capabilities')

-- Local imports
local commands = require('commands')
local discovery = require('discovery')
local lifecycles = require('lifecycles')

-- Custom capabilities
Cap_createdevice = caps["smoothoption15782.createDevice"]


-- Create the driver object
local driver =
  driver(
    'ST-Edge-vDeviceCreator',
    {
      discovery = discovery.start,
      lifecycle_handlers = lifecycles,
      capability_handlers = {
        [Cap_createdevice.ID] = {
          [Cap_createdevice.commands.setDeviceType.NAME] = commands.handle_createdevice,
        },
        [caps.fanSpeed.ID] = {
          [caps.fanSpeed.commands.setFanSpeed.NAME] = commands.handle_fanSpeed,
        },
      }
    }
  )

-- Run the driver
driver:run()
