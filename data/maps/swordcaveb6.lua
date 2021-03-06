local map = ...
local game = map:get_game()

-- Returns whether all torches are on
local function are_all_torches_on()

  return torch_1 ~= nil
      and torch_1:get_sprite():get_animation() == "lit"
      and torch_2:get_sprite():get_animation() == "lit"
      and torch_3:get_sprite():get_animation() == "lit"
      and torch_4:get_sprite():get_animation() == "lit"
      and torch_5:get_sprite():get_animation() == "lit"
      and torch_6:get_sprite():get_animation() == "lit"
      and torch_7:get_sprite():get_animation() == "lit"
      and torch_8:get_sprite():get_animation() == "lit"
      and torch_9:get_sprite():get_animation() == "lit"
end

-- Makes all torches stay on forever
local function lock_torches()
  -- the trick: just remove the interactive torches because there are static ones below
  torch_1:remove()
  torch_2:remove()
  torch_3:remove()
  torch_4:remove()
  torch_5:remove()
  torch_6:remove()
  torch_7:remove()
  torch_8:remove()
  torch_9:remove()
end

function map:on_started(destination)

  map:set_doors_open("door_a", true)

  if game:get_value("swordcaveb6") then
    -- the door after the torches is open
    lock_torches()
  end

function map:on_update()

  if not game:get_value("swordcaveb6")
    and are_all_torches_on() then

    lock_torches()
    map:move_camera(560, 56, 250, function()
      sol.audio.play_sound("secret")
      map:open_doors("shortcut")
    end)
  end
end

-- miniboss or boss set
  if room5_enemy ~= nil then
    room5_enemy:set_enabled(false)

  end
end

  if room6_enemy ~= nil then
    room6_enemy:set_enabled(false)

end

-- close/open doors for each room when enemies are defeated..
function close_door_a_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room1_enemy") then
    map:close_doors("door_a")
  end
end
close_door_a_sensor_2.on_activated = close_door_a_sensor_1.on_activated

function close_door_b_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room2_enemy") then
    map:close_doors("door_b")
    map:close_doors("door_a")
  end
end

function close_door_c_sensor_1:on_activated()

  if door_b:is_open()
      and map:has_entities("room3_enemy") then
    map:close_doors("door_b")
    map:close_doors("door_c")
  end
end
close_door_c_sensor_2.on_activated = close_door_c_sensor_1.on_activated

function close_door_d_sensor_1:on_activated()

  if door_c:is_open()
      and map:has_entities("room4_enemy") then
    map:close_doors("door_c")
  end
end

-- start boss or miniboss sequence..
function close_door_e_sensor_1:on_activated()

  if door_d:is_open()
      and room5_enemy ~= nil then
    map:close_doors("door_d")
    map:close_doors("door_e")
    sol.audio.play_music("boss")
      room5_enemy:set_enabled(true)
  end
end

function close_door_f_sensor_1:on_activated()

  if door_e:is_open()
      and room6_enemy ~= nil then
    map:close_doors("door_f")
    map:close_doors("door_e")
    sol.audio.play_music("boss")
      room6_enemy:set_enabled(true)
  end
end

-- boss or miniboss of the floor's doors..
if room5_enemy ~= nil then
  function room5_enemy:on_dead()

    if not door_e:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_e")
      map:open_doors("door_d")
    end
  end
end

if room6_enemy ~= nil then
  function room6_enemy:on_dead()

    if not door_f:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_e")
      map:open_doors("door_f")
    end
  end
end

-- enemies of each room on death opening doors..
function room1_enemy_1:on_dead()

  if not map:has_entities("room1_enemy")
      and not door_a:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_a")
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
room1_enemy_18.on_dead = room1_enemy_1.on_dead
room1_enemy_19.on_dead = room1_enemy_1.on_dead
room1_enemy_20.on_dead = room1_enemy_1.on_dead
room1_enemy_21.on_dead = room1_enemy_1.on_dead
room1_enemy_22.on_dead = room1_enemy_1.on_dead
room1_enemy_23.on_dead = room1_enemy_1.on_dead
room1_enemy_24.on_dead = room1_enemy_1.on_dead
room1_enemy_25.on_dead = room1_enemy_1.on_dead
room1_enemy_26.on_dead = room1_enemy_1.on_dead
room1_enemy_27.on_dead = room1_enemy_1.on_dead
room1_enemy_28.on_dead = room1_enemy_1.on_dead
room1_enemy_29.on_dead = room1_enemy_1.on_dead
room1_enemy_30.on_dead = room1_enemy_1.on_dead
room1_enemy_31.on_dead = room1_enemy_1.on_dead
room1_enemy_32.on_dead = room1_enemy_1.on_dead
room1_enemy_33.on_dead = room1_enemy_1.on_dead

function room2_enemy_1:on_dead()

  if not map:has_entities("room2_enemy")
      and not door_b:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_b")
    map:open_doors("door_a")
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
room2_enemy_10.on_dead = room2_enemy_1.on_dead
room2_enemy_11.on_dead = room2_enemy_1.on_dead
room2_enemy_12.on_dead = room2_enemy_1.on_dead
room2_enemy_13.on_dead = room2_enemy_1.on_dead
room2_enemy_14.on_dead = room2_enemy_1.on_dead
room2_enemy_15.on_dead = room2_enemy_1.on_dead

function room3_enemy_1:on_dead()

  if not map:has_entities("room3_enemy")
      and not door_c:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_c")
    map:open_doors("door_b")
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
room3_enemy_10.on_dead = room3_enemy_1.on_dead
room3_enemy_11.on_dead = room3_enemy_1.on_dead
room3_enemy_12.on_dead = room3_enemy_1.on_dead
room3_enemy_13.on_dead = room3_enemy_1.on_dead
room3_enemy_14.on_dead = room3_enemy_1.on_dead
room3_enemy_15.on_dead = room3_enemy_1.on_dead
room3_enemy_16.on_dead = room3_enemy_1.on_dead
room3_enemy_17.on_dead = room3_enemy_1.on_dead
room3_enemy_18.on_dead = room3_enemy_1.on_dead
room3_enemy_19.on_dead = room3_enemy_1.on_dead
room3_enemy_20.on_dead = room3_enemy_1.on_dead
room3_enemy_21.on_dead = room3_enemy_1.on_dead
room3_enemy_22.on_dead = room3_enemy_1.on_dead
room3_enemy_23.on_dead = room3_enemy_1.on_dead
room3_enemy_24.on_dead = room3_enemy_1.on_dead
room3_enemy_25.on_dead = room3_enemy_1.on_dead
room3_enemy_26.on_dead = room3_enemy_1.on_dead
room3_enemy_27.on_dead = room3_enemy_1.on_dead
room3_enemy_28.on_dead = room3_enemy_1.on_dead
room3_enemy_29.on_dead = room3_enemy_1.on_dead
room3_enemy_30.on_dead = room3_enemy_1.on_dead
room3_enemy_31.on_dead = room3_enemy_1.on_dead
room3_enemy_32.on_dead = room3_enemy_1.on_dead
room3_enemy_33.on_dead = room3_enemy_1.on_dead
room3_enemy_34.on_dead = room3_enemy_1.on_dead
room3_enemy_35.on_dead = room3_enemy_1.on_dead
room3_enemy_36.on_dead = room3_enemy_1.on_dead
room3_enemy_37.on_dead = room3_enemy_1.on_dead
room3_enemy_38.on_dead = room3_enemy_1.on_dead
room3_enemy_39.on_dead = room3_enemy_1.on_dead
room3_enemy_40.on_dead = room3_enemy_1.on_dead
room3_enemy_41.on_dead = room3_enemy_1.on_dead
room3_enemy_42.on_dead = room3_enemy_1.on_dead
room3_enemy_43.on_dead = room3_enemy_1.on_dead
room3_enemy_44.on_dead = room3_enemy_1.on_dead

function room4_enemy_1:on_dead()

  if not map:has_entities("room4_enemy")
      and not door_d:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_c")
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
room4_enemy_10.on_dead = room4_enemy_1.on_dead
room4_enemy_11.on_dead = room4_enemy_1.on_dead
room4_enemy_12.on_dead = room4_enemy_1.on_dead
room4_enemy_13.on_dead = room4_enemy_1.on_dead
room4_enemy_14.on_dead = room4_enemy_1.on_dead
room4_enemy_15.on_dead = room4_enemy_1.on_dead
room4_enemy_16.on_dead = room4_enemy_1.on_dead
room4_enemy_17.on_dead = room4_enemy_1.on_dead
room4_enemy_18.on_dead = room4_enemy_1.on_dead
room4_enemy_19.on_dead = room4_enemy_1.on_dead
room4_enemy_20.on_dead = room4_enemy_1.on_dead
room4_enemy_21.on_dead = room4_enemy_1.on_dead
room4_enemy_22.on_dead = room4_enemy_1.on_dead
room4_enemy_23.on_dead = room4_enemy_1.on_dead