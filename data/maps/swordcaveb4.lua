local map = ...
local game = map:get_game()
local nb_spawners_created = 0

-- possible positions of Drakomos lava spawners
local spawner_xy = {
  { x = 200, y = 504},
  { x = 224, y = 504},
  { x = 392, y = 504},
  { x = 440, y = 504},
  { x = 200, y = 560},
  { x = 224, y = 560},
  { x = 280, y = 560},
  { x = 336, y = 560},
  { x = 392, y = 560},
  { x = 440, y = 560},
  { x = 200, y = 600},
  { x = 224, y = 600},
  { x = 280, y = 600},
  { x = 336, y = 600},
  { x = 392, y = 600},
  { x = 440, y = 600}
}

local function repeat_lava_spawner()

  if map:has_entities("room5_enemy") then  -- Boss not killed.
    nb_spawners_created = nb_spawners_created + 1
    local index = math.random(#spawner_xy)
    map:create_enemy{
      name = "spawner_" .. nb_spawners_created,
      breed = "swordcave_drakomos_lava_spawner",
      layer = 1,
      x = spawner_xy[index].x,
      y = spawner_xy[index].y,
      direction = 0
    }
    sol.timer.start(5000 + math.random(10000), repeat_lava_spawner)
  end
end

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
  map:set_doors_open("door_e", true)

  if game:get_value("swordcaveb4") then
    -- the door after the torches is open
    lock_torches()
  end

function map:on_update()

  if not game:get_value("swordcaveb4")
    and are_all_torches_on() then

    lock_torches()
    map:move_camera(176, 40, 250, function()
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

-- close/open doors for each room when enemies are defeated..
function close_door_a_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room1_enemy") then
    map:close_doors("door_a")
    map:close_doors("door_b")
  end
end
close_door_a_sensor_2.on_activated = close_door_a_sensor_1.on_activated

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
    map:close_doors("door_c")
  end
end

function close_door_d_sensor_1:on_activated()

  if door_c:is_open()
      and map:has_entities("room4_enemy") then
    map:close_doors("door_d")
    map:close_doors("door_e")
  end
end

-- start boss or miniboss sequence..
function close_door_e_sensor_1:on_activated()

  if door_e:is_open()
      and room5_enemy ~= nil then
    map:close_doors("door_e")
    sol.timer.start(2000, repeat_lava_spawner)
    sol.timer.start(1000, function()
    sol.audio.play_music("boss")
      room5_enemy:set_enabled(true)
    end)
  end
end

-- boss or miniboss of the floor's doors..
if room5_enemy ~= nil then
  function room5_enemy:on_dead()

    if not door_f:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_f")
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
      and not door_d:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_d")
    map:open_doors("door_c")
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
room4_enemy_24.on_dead = room4_enemy_1.on_dead
room4_enemy_25.on_dead = room4_enemy_1.on_dead
room4_enemy_26.on_dead = room4_enemy_1.on_dead