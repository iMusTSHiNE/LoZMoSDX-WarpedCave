local map = ...
local game = map:get_game()

local nb_torches_lit = 0
local nb_spawners_created = 0

-- possible positions of Drakomos lava spawners
local spawner_xy = {
  { x = 744, y = 848},
  { x = 944, y = 848},
  { x = 736, y = 896},
  { x = 928, y = 912},
  { x = 664, y = 928},
  { x = 744, y = 928},
  { x = 808, y = 928},
  { x = 856, y = 928},
  { x = 944, y = 928},
  { x = 712, y = 976},
  { x = 760, y = 976},
  { x = 904, y = 976},
  { x = 936, y = 976}
}

local function repeat_lava_spawner()

  if map:has_entities("room8_enemy") then  -- Boss not killed.
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

function map:on_started(destination)

  map:set_doors_open("door_a", true)

function switch_to_final_boss:on_activated()
    map:move_camera(504, 504, 250, function()
      sol.audio.play_sound("secret")
      map:open_doors("switchtofinalboss")
      game:set_value("switchtofinalboss", true)
  end)
end

  -- bridges that appear when a torch is lit
  map:set_entities_enabled("bridge", false)
end

-- Torches on this map interact with the map script
-- because we don't want usual behavior from items/lamp.lua:
-- we want a shorter delay and we want torches to enable the bridge
local function torch_interaction(torch)
  game:start_dialog("torch.need_lamp")
end

-- Called when fire touches a torch.
local function torch_collision_fire(torch)

  local torch_sprite = torch:get_sprite()
  if torch_sprite:get_animation() == "unlit" then
    -- temporarily light the torch up
    torch_sprite:set_animation("lit")
    if nb_torches_lit == 0 then
      map:set_entities_enabled("bridge", true)
    end
    nb_torches_lit = nb_torches_lit + 1
    sol.timer.start(20000, function()
      torch_sprite:set_animation("unlit")
      nb_torches_lit = nb_torches_lit - 1
      if nb_torches_lit == 0 then
	map:set_entities_enabled("bridge", false)
      end
    end)
  end
end

for torch in map:get_entities("torch_") do
  torch.on_interaction = torch_interaction
  torch.on_collision_fire = torch_collision_fire
end

-- miniboss or boss set
  if room2_enemy ~= nil then
    room2_enemy:set_enabled(false)

end

  if room3_enemy ~= nil then
    room3_enemy:set_enabled(false)

end

  if room4_enemy ~= nil then
    room4_enemy:set_enabled(false)

end

  if room5_enemy ~= nil then
    room5_enemy:set_enabled(false)

end

  if room7_enemy ~= nil then
    room7_enemy:set_enabled(false)

end

  if room8_enemy ~= nil then
    room8_enemy:set_enabled(false)

end

  if room9_enemy ~= nil then
    room9_enemy:set_enabled(false)

end

-- close/open doors for each room when enemies are defeated..
function close_door_a_sensor_1:on_activated()

  if door_a:is_open()
      and map:has_entities("room1_enemy") then
    map:close_doors("door_a")
  end
end

function close_door_f_sensor_1:on_activated()

  if door_e:is_open()
      and map:has_entities("room6_enemy") then
    map:close_doors("door_e")
  end
end

function close_door_j_sensor_1:on_activated()

  if door_i:is_open()
      and map:has_entities("room10_enemy") then
    map:close_doors("door_i")
    map:close_doors("door_j")
  end
end

-- start boss or miniboss sequence..
function close_door_b_sensor_1:on_activated()

  if door_a:is_open()
      and room2_enemy ~= nil then
    map:close_doors("door_a")
    map:close_doors("door_b")
    sol.audio.play_music("boss")
      room2_enemy:set_enabled(true)
  end
end

function close_door_c_sensor_1:on_activated()

  if door_b:is_open()
      and room3_enemy ~= nil then
    map:close_doors("door_b")
    map:close_doors("door_c")
    sol.audio.play_music("boss")
      room3_enemy:set_enabled(true)
  end
end

function close_door_d_sensor_1:on_activated()

  if door_c:is_open()
      and room4_enemy ~= nil then
    map:close_doors("door_c")
    map:close_doors("door_d")
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

function close_door_g_sensor_1:on_activated()

  if door_f:is_open()
      and room7_enemy ~= nil then
    map:close_doors("door_f")
    map:close_doors("door_g")
    sol.audio.play_music("boss")
      room7_enemy:set_enabled(true)
  end
end

function close_door_h_sensor_1:on_activated()

  if door_g:is_open()
      and room8_enemy ~= nil then
    map:close_doors("door_g")
    sol.timer.start(2000, repeat_lava_spawner)
    sol.timer.start(1000, function()
    sol.audio.play_music("boss")
      room8_enemy:set_enabled(true)
    end)
  end
end

function close_door_i_sensor_1:on_activated()

  if door_h:is_open()
      and room9_enemy ~= nil then
    map:close_doors("door_h")
    map:close_doors("door_i")
    sol.audio.play_music("boss")
      room9_enemy:set_enabled(true)
  end
end

-- boss or miniboss of the floor's doors..
if room2_enemy ~= nil then
  function room2_enemy:on_dead()

    if not door_b:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_a")
      map:open_doors("door_b")
    end
  end
end

if room3_enemy ~= nil then
  function room3_enemy:on_dead()

    if not door_c:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_b")
      map:open_doors("door_c")
    end
  end
end

if room4_enemy ~= nil then
  function room4_enemy:on_dead()

    if not door_d:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_c")
      map:open_doors("door_d")
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

if room7_enemy ~= nil then
  function room7_enemy:on_dead()

    if not door_g:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_f")
      map:open_doors("door_g")
    end
  end
end

if room8_enemy ~= nil then
  function room8_enemy:on_dead()

    if not door_h:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_g")
      map:open_doors("door_h")
    end
  end
end

if room9_enemy ~= nil then
  function room9_enemy:on_dead()

    if not door_i:is_open() then
      sol.audio.play_music("southern_shrine")
      sol.audio.play_sound("secret")
      map:open_doors("door_h")
      map:open_doors("door_i")
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

function room6_enemy_1:on_dead()

  if not map:has_entities("room6_enemy")
      and not door_f:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_e")
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

function room10_enemy_1:on_dead()

  if not map:has_entities("room10_enemy")
      and not door_j:is_open() then
    sol.audio.play_sound("secret")
    map:open_doors("door_i")
    map:open_doors("door_j")
  end
end
room10_enemy_2.on_dead = room10_enemy_1.on_dead
room10_enemy_3.on_dead = room10_enemy_1.on_dead
room10_enemy_4.on_dead = room10_enemy_1.on_dead
room10_enemy_5.on_dead = room10_enemy_1.on_dead
room10_enemy_6.on_dead = room10_enemy_1.on_dead
room10_enemy_7.on_dead = room10_enemy_1.on_dead
room10_enemy_8.on_dead = room10_enemy_1.on_dead
room10_enemy_9.on_dead = room10_enemy_1.on_dead
room10_enemy_10.on_dead = room10_enemy_1.on_dead
room10_enemy_11.on_dead = room10_enemy_1.on_dead
