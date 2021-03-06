local map = ...
local game = map:get_game()

function map:on_started(destination)

  map:set_doors_open("door_a", true)

function door_to_b6_switch:on_activated()
    sol.audio.play_sound("secret")
    game:set_value("doortob6switch", true)
end

-- miniboss or boss set
  if room5_enemy ~= nil then
    room5_enemy:set_enabled(false)

  end
end

  if room10_enemy ~= nil then
    room10_enemy:set_enabled(false)

end

-- close/open doors for each room when enemies are defeated..
function close_door_a_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room1_enemy") then
    map:close_doors("door_a")
  end
end

function close_door_b_sensor_1:on_activated()

  if door_b:is_open()
      and map:has_entities("room2_enemy") then
    map:close_doors("door_b")
    map:close_doors("door_a")
  end
end
close_door_b_sensor_2.on_activated = close_door_b_sensor_1.on_activated

function close_door_c_sensor_1:on_activated()

  if door_c:is_open()
      and map:has_entities("room3_enemy") then
    map:close_doors("door_c")
    map:close_doors("door_d")
  end
end
close_door_c_sensor_2.on_activated = close_door_c_sensor_1.on_activated

function close_door_d_sensor_1:on_activated()

  if door_d:is_open()
      and map:has_entities("room4_enemy") then
    map:close_doors("door_e")
    map:close_doors("door_d")
  end
end
close_door_d_sensor_2.on_activated = close_door_d_sensor_1.on_activated

function close_door_f_sensor_1:on_activated()

  if door_f:is_open()
      and map:has_entities("room6_enemy") then
    map:close_doors("door_g")
    map:close_doors("door_f")
  end
end
close_door_f_sensor_2.on_activated = close_door_f_sensor_1.on_activated

function close_door_g_sensor_1:on_activated()

  if door_f:is_open()
      and map:has_entities("room7_enemy") then
    map:close_doors("door_g")
    map:close_doors("door_f")
  end
end
close_door_g_sensor_2.on_activated = close_door_g_sensor_1.on_activated

function close_door_h_sensor_1:on_activated()

  if door_h:is_open()
      and map:has_entities("room8_enemy") then
    map:close_doors("door_h")
    map:close_doors("door_i")
  end
end
close_door_h_sensor_2.on_activated = close_door_h_sensor_1.on_activated

function close_door_i_sensor_1:on_activated()

  if door_i:is_open()
      and map:has_entities("room9_enemy") then
    map:close_doors("door_i")
    map:close_doors("door_j")
  end
end
close_door_i_sensor_2.on_activated = close_door_i_sensor_1.on_activated

-- start boss or miniboss sequence..
function close_door_e_sensor_1:on_activated()

  if door_e:is_open()
      and room5_enemy ~= nil then
    map:close_doors("door_e")
    map:close_doors("door_f")
    sol.audio.play_music("boss")
      room5_enemy:set_enabled(true)
  end
end
close_door_e_sensor_2.on_activated = close_door_e_sensor_1.on_activated

function close_door_j_sensor_1:on_activated()

  if door_j:is_open()
      and room10_enemy ~= nil then
    map:close_doors("door_j")
    map:close_doors("door_k")
    sol.audio.play_music("boss")
      room10_enemy:set_enabled(true)
  end
end
close_door_j_sensor_2.on_activated = close_door_j_sensor_1.on_activated

-- boss or miniboss of the floor's doors..
if room5_enemy ~= nil then
  function room5_enemy:on_dead()

    if not door_f:is_open() then
      sol.audio.play_music("tloz_dungeon")
      sol.audio.play_sound("secret")
      map:open_doors("door_e")
      map:open_doors("door_f")
    end
  end
end

if room10_enemy ~= nil then
  function room10_enemy:on_dead()

    if not door_k:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_j")
      map:open_doors("door_k")
    end
  end
end

-- enemies of each room on death opening doors..
function room1_enemy_1:on_dead()

  if not map:has_entities("room1_enemy")
      and not door_a:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_a")
    map:open_doors("door_b")
  end
end
room1_enemy_2.on_dead = room1_enemy_1.on_dead
room1_enemy_3.on_dead = room1_enemy_1.on_dead
room1_enemy_4.on_dead = room1_enemy_1.on_dead
room1_enemy_5.on_dead = room1_enemy_1.on_dead
room1_enemy_6.on_dead = room1_enemy_1.on_dead
room1_enemy_7.on_dead = room1_enemy_1.on_dead
room1_enemy_8.on_dead = room1_enemy_1.on_dead
room1_enemy_9.on_dead = room1_enemy_1.on_dead
room1_enemy_10.on_dead = room1_enemy_1.on_dead
room1_enemy_11.on_dead = room1_enemy_1.on_dead
room1_enemy_12.on_dead = room1_enemy_1.on_dead
room1_enemy_13.on_dead = room1_enemy_1.on_dead
room1_enemy_14.on_dead = room1_enemy_1.on_dead
room1_enemy_15.on_dead = room1_enemy_1.on_dead
room1_enemy_16.on_dead = room1_enemy_1.on_dead
room1_enemy_17.on_dead = room1_enemy_1.on_dead

function room2_enemy_1:on_dead()

  if not map:has_entities("room2_enemy")
      and not door_b:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_b")
    map:open_doors("door_c")
  end
end
room2_enemy_2.on_dead = room2_enemy_1.on_dead
room2_enemy_3.on_dead = room2_enemy_1.on_dead
room2_enemy_4.on_dead = room2_enemy_1.on_dead
room2_enemy_5.on_dead = room2_enemy_1.on_dead
room2_enemy_6.on_dead = room2_enemy_1.on_dead
room2_enemy_7.on_dead = room2_enemy_1.on_dead
room2_enemy_8.on_dead = room2_enemy_1.on_dead
room2_enemy_9.on_dead = room2_enemy_1.on_dead

function room3_enemy_1:on_dead()

  if not map:has_entities("room3_enemy")
      and not door_c:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_c")
    map:open_doors("door_d")
  end
end
room3_enemy_2.on_dead = room3_enemy_1.on_dead
room3_enemy_3.on_dead = room3_enemy_1.on_dead
room3_enemy_4.on_dead = room3_enemy_1.on_dead
room3_enemy_5.on_dead = room3_enemy_1.on_dead
room3_enemy_6.on_dead = room3_enemy_1.on_dead
room3_enemy_7.on_dead = room3_enemy_1.on_dead
room3_enemy_8.on_dead = room3_enemy_1.on_dead
room3_enemy_9.on_dead = room3_enemy_1.on_dead

function room4_enemy_1:on_dead()

  if not map:has_entities("room4_enemy")
      and not door_e:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_e")
    map:open_doors("door_d")
  end
end
room4_enemy_2.on_dead = room4_enemy_1.on_dead
room4_enemy_3.on_dead = room4_enemy_1.on_dead
room4_enemy_4.on_dead = room4_enemy_1.on_dead
room4_enemy_5.on_dead = room4_enemy_1.on_dead
room4_enemy_6.on_dead = room4_enemy_1.on_dead
room4_enemy_7.on_dead = room4_enemy_1.on_dead
room4_enemy_8.on_dead = room4_enemy_1.on_dead
room4_enemy_9.on_dead = room4_enemy_1.on_dead

function room6_enemy_1:on_dead()

  if not map:has_entities("room6_enemy")
      and not door_g:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_g")
    map:open_doors("door_f")
  end
end
room6_enemy_2.on_dead = room6_enemy_1.on_dead
room6_enemy_3.on_dead = room6_enemy_1.on_dead
room6_enemy_4.on_dead = room6_enemy_1.on_dead
room6_enemy_5.on_dead = room6_enemy_1.on_dead
room6_enemy_6.on_dead = room6_enemy_1.on_dead
room6_enemy_7.on_dead = room6_enemy_1.on_dead
room6_enemy_8.on_dead = room6_enemy_1.on_dead
room6_enemy_9.on_dead = room6_enemy_1.on_dead
room6_enemy_10.on_dead = room6_enemy_1.on_dead
room6_enemy_11.on_dead = room6_enemy_1.on_dead
room6_enemy_12.on_dead = room6_enemy_1.on_dead
room6_enemy_13.on_dead = room6_enemy_1.on_dead
room6_enemy_14.on_dead = room6_enemy_1.on_dead

function room7_enemy_1:on_dead()

  if not map:has_entities("room7_enemy")
      and not door_h:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_g")
    map:open_doors("door_h")
  end
end
room7_enemy_2.on_dead = room7_enemy_1.on_dead
room7_enemy_3.on_dead = room7_enemy_1.on_dead
room7_enemy_4.on_dead = room7_enemy_1.on_dead
room7_enemy_5.on_dead = room7_enemy_1.on_dead
room7_enemy_6.on_dead = room7_enemy_1.on_dead
room7_enemy_7.on_dead = room7_enemy_1.on_dead
room7_enemy_8.on_dead = room7_enemy_1.on_dead
room7_enemy_9.on_dead = room7_enemy_1.on_dead
room7_enemy_10.on_dead = room7_enemy_1.on_dead
room7_enemy_11.on_dead = room7_enemy_1.on_dead
room7_enemy_12.on_dead = room7_enemy_1.on_dead
room7_enemy_13.on_dead = room7_enemy_1.on_dead
room7_enemy_14.on_dead = room7_enemy_1.on_dead
room7_enemy_15.on_dead = room7_enemy_1.on_dead
room7_enemy_16.on_dead = room7_enemy_1.on_dead
room7_enemy_17.on_dead = room7_enemy_1.on_dead
room7_enemy_18.on_dead = room7_enemy_1.on_dead
room7_enemy_19.on_dead = room7_enemy_1.on_dead
room7_enemy_20.on_dead = room7_enemy_1.on_dead
room7_enemy_21.on_dead = room7_enemy_1.on_dead
room7_enemy_22.on_dead = room7_enemy_1.on_dead

function room8_enemy_1:on_dead()

  if not map:has_entities("room8_enemy")
      and not door_i:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_h")
    map:open_doors("door_i")
  end
end
room8_enemy_2.on_dead = room8_enemy_1.on_dead
room8_enemy_3.on_dead = room8_enemy_1.on_dead
room8_enemy_4.on_dead = room8_enemy_1.on_dead
room8_enemy_5.on_dead = room8_enemy_1.on_dead
room8_enemy_6.on_dead = room8_enemy_1.on_dead
room8_enemy_7.on_dead = room8_enemy_1.on_dead
room8_enemy_8.on_dead = room8_enemy_1.on_dead
room8_enemy_9.on_dead = room8_enemy_1.on_dead
room8_enemy_10.on_dead = room8_enemy_1.on_dead
room8_enemy_11.on_dead = room8_enemy_1.on_dead
room8_enemy_12.on_dead = room8_enemy_1.on_dead
room8_enemy_13.on_dead = room8_enemy_1.on_dead
room8_enemy_14.on_dead = room8_enemy_1.on_dead
room8_enemy_15.on_dead = room8_enemy_1.on_dead
room8_enemy_16.on_dead = room8_enemy_1.on_dead
room8_enemy_17.on_dead = room8_enemy_1.on_dead
room8_enemy_18.on_dead = room8_enemy_1.on_dead
room8_enemy_19.on_dead = room8_enemy_1.on_dead

function room9_enemy_1:on_dead()

  if not map:has_entities("room9_enemy")
      and not door_j:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_j")
    map:open_doors("door_i")
  end
end
room9_enemy_2.on_dead = room9_enemy_1.on_dead
room9_enemy_3.on_dead = room9_enemy_1.on_dead
room9_enemy_4.on_dead = room9_enemy_1.on_dead
room9_enemy_5.on_dead = room9_enemy_1.on_dead
room9_enemy_6.on_dead = room9_enemy_1.on_dead
room9_enemy_7.on_dead = room9_enemy_1.on_dead
room9_enemy_8.on_dead = room9_enemy_1.on_dead
room9_enemy_9.on_dead = room9_enemy_1.on_dead
room9_enemy_10.on_dead = room9_enemy_1.on_dead
room9_enemy_11.on_dead = room9_enemy_1.on_dead