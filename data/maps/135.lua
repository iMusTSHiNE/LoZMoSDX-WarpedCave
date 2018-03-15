local map = ...
-- Hidden palace D7

-- entering a pipe
function pipe_in_sensor_1:on_activated()
  hero:set_visible(true)
end
pipe_in_sensor_2.on_activated = pipe_in_sensor_1.on_activated

function pipe_in_sensor_3:on_activated()
  hero:set_visible(true)
end
pipe_in_sensor_4.on_activated = pipe_in_sensor_3.on_activated

-- hide the hero
function hide_hero_sensor_1:on_activated()
  hero:set_visible(false)
end
hide_hero_sensor_2.on_activated = hide_hero_sensor_1.on_activated

function hide_hero_sensor_3:on_activated()
  hero:set_visible(false)
end
hide_hero_sensor_4.on_activated = hide_hero_sensor_3.on_activated

-- unhide the hero
function unhide_hero_sensor_1:on_activated()
  hero:set_visible(true)
end
unhide_hero_sensor_2.on_activated = unhide_hero_sensor_1.on_activated

function unhide_hero_sensor_3:on_activated()
  hero:set_visible(true)
end
unhide_hero_sensor_4.on_activated = unhide_hero_sensor_3.on_activated

-- enable border A
function pipe_border_a_sensor_1:on_activated()
  map:set_entities_enabled("pipe_border_a_wall", true)
  map:set_entities_enabled("pipe_border_b_wall", false)
end
pipe_border_a_sensor_2.on_activated = pipe_border_a_sensor_1.on_activated

-- enable border B
function pipe_border_b_sensor_1:on_activated()
  map:set_entities_enabled("pipe_border_b_wall", true)
  map:set_entities_enabled("pipe_border_a_wall", false)
end
pipe_border_b_sensor_2.on_activated = pipe_border_b_sensor_1.on_activated

-- enable border C
function pipe_border_c_sensor_1:on_activated()
  map:set_entities_enabled("pipe_border_c_wall", false)
  map:set_entities_enabled("pipe_border_d_wall", true)
end
pipe_border_c_sensor_2.on_activated = pipe_border_c_sensor_1.on_activated

-- enable border D
function pipe_border_d_sensor_1:on_activated()
  map:set_entities_enabled("pipe_border_d_wall", false)
  map:set_entities_enabled("pipe_border_c_wall", true)
end
pipe_border_d_sensor_2.on_activated = pipe_border_d_sensor_1.on_activated