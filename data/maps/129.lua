local map = ...

-- Hidden palace D6.

function doorswitch_switch:on_activated()
  map:open_doors("doorswitch")
end

function to_layer_1_sensor:on_activated()

  local x, y = hero:get_position()
  hero:set_position(x, y, 1)
end

