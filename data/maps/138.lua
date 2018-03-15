local map = ...
local game = map:get_game()

local init_evil_tiles = sol.main.load_file("maps/evil_tiles")
init_evil_tiles(map)

function map:on_started(destination)

  -- evil tiles
  map:set_entities_enabled("evil_tile_", false)
  map:set_doors_open("evil_tiles_door", true)
end

function evil_tiles_sensor_1:on_activated()

  if evil_tiles_door:is_open()
      and evil_tile_enemy_1 ~= nil then
    map:close_doors("evil_tiles_door")
    sol.timer.start(2000, function()
      map:start_evil_tiles()
    end)
  end
end

evil_tiles_sensor_2.on_activated = evil_tiles_sensor_1.on_activated

function sensor_1:on_activated()

  if sensor_1_off:is_enabled() then
    sol.audio.play_sound("switch")
    map:set_entities_enabled("sensor_1_on", true)
    map:set_entities_enabled("sensor_1_off", false)
  end
end

function sensor_2:on_activated()

  if sensor_2_off:is_enabled() then
    sol.audio.play_sound("switch")
    map:set_entities_enabled("sensor_2_on", true)
    map:set_entities_enabled("sensor_2_off", false)
  end
end

function map:finish_evil_tiles()

  map:open_doors("evil_tiles_door")
end

function door:on_opened()

  sol.audio.play_sound("secret")
end
