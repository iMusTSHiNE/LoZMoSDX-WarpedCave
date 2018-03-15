local map = ...
local game = map:get_game()

local light_manager = require("maps/lib/light_manager")
local nb_torches_lit = 0

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

  light_manager.enable_light_features(map)
  map:set_light(0)
end

-- Torches on this map interact with the map script
-- because we don't want usual behavior from items/lamp.lua:
local function torch_interaction(light)
  game:start_dialog("torch.need_lamp")
end

-- Called when fire touches a torch.
local function torch_collision_fire(light)

  local torch_sprite = light:get_sprite()
  if torch_sprite:get_animation() == "unlit" then
    -- temporarily light the torch up
    torch_sprite:set_animation("lit")
    if nb_torches_lit == 0 then
  map:set_light(1)
    end
    nb_torches_lit = nb_torches_lit + 1
    sol.timer.start(20000, function()
      torch_sprite:set_animation("unlit")
      nb_torches_lit = nb_torches_lit - 1
      if nb_torches_lit == 0 then
  map:set_light(0)
      end
    end)
  end
end

for torch in map:get_entities("light_") do
  torch.on_interaction = torch_interaction
  torch.on_collision_fire = torch_collision_fire
end

  map:set_doors_open("door_a", true)

  if game:get_value("swordcaveb3hard") then
    -- the door after the torches is open
    lock_torches()
  end

function map:on_update()

  if not game:get_value("swordcaveb3hard")
    and are_all_torches_on() then

    lock_torches()
    map:move_camera(800, 88, 250, function()
      sol.audio.play_sound("secret")
      map:open_doors("shortcut")
    end)
  end
end

-- miniboss or boss set
  if room4_enemy ~= nil then
    room4_enemy:set_enabled(false)

end

  if room5_enemy ~= nil then
    room5_enemy:set_enabled(false)

end

-- close/open doors for each room when enemies are defeated..
function close_door_a_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room1_enemy") then
    map:close_doors("door_a")
    map:close_doors("door_b")
  end
end
close_door_a_sensor_2.on_activated = close_door_a_sensor_1.on_activated
close_door_a_sensor_3.on_activated = close_door_a_sensor_1.on_activated
close_door_a_sensor_4.on_activated = close_door_a_sensor_1.on_activated

function close_door_b_sensor_1:on_activated()

  if door_b:is_open()
      and map:has_entities("room2_enemy") then
    map:close_doors("door_b")
  end
end
close_door_b_sensor_2.on_activated = close_door_b_sensor_1.on_activated

function close_door_c_sensor_1:on_activated()

  if door_b:is_open()
      and map:has_entities("room3_enemy") then
    map:close_doors("door_b")
  end
end

-- start boss or miniboss sequence..
function close_door_d_sensor_1:on_activated()

  if door_c:is_open()
      and room4_enemy ~= nil then
    map:close_doors("door_d")
    map:close_doors("door_c")
    sol.audio.play_music("boss")
      room4_enemy:set_enabled(true)
  end
end

function close_door_e_sensor_1:on_activated()

  if door_d:is_open()
      and room5_enemy ~= nil then
    map:close_doors("door_d")
    map:close_doors("door_e")
    sol.audio.play_music("boss")
      room5_enemy:set_enabled(true)
  end
end
close_door_e_sensor_2.on_activated = close_door_e_sensor_1.on_activated

-- boss or miniboss of the floor's doors..
if room4_enemy ~= nil then
  function room4_enemy:on_dead()

    if not door_d:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_d")
      map:open_doors("door_c")
    end
  end
end

if room5_enemy ~= nil then
  function room5_enemy:on_dead()

    if not door_e:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_d")
      map:open_doors("door_e")
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
room1_enemy_19.on_dead = room1_enemy_1.on_dead
room1_enemy_20.on_dead = room1_enemy_1.on_dead
room1_enemy_21.on_dead = room1_enemy_1.on_dead
room1_enemy_18.on_dead = room1_enemy_1.on_dead

function room2_enemy_1:on_dead()

  if not map:has_entities("room2_enemy")
      and not door_c:is_open() then
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
room2_enemy_10.on_dead = room2_enemy_1.on_dead
room2_enemy_11.on_dead = room2_enemy_1.on_dead
room2_enemy_12.on_dead = room2_enemy_1.on_dead
room2_enemy_13.on_dead = room2_enemy_1.on_dead
room2_enemy_14.on_dead = room2_enemy_1.on_dead
room2_enemy_15.on_dead = room2_enemy_1.on_dead
room2_enemy_16.on_dead = room2_enemy_1.on_dead

function room3_enemy_1:on_dead()

  if not map:has_entities("room3_enemy")
      and not door_b:is_open() then
    sol.audio.play_sound("secret")
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