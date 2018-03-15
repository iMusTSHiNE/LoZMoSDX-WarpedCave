local map = ...
local game = map:get_game()
-- Dungeon 9 3F

local fighting_miniboss = false
local nb_spawners_created = 0

-- possible positions of Drakomos lava spawners
local spawner_xy = {
  { x = 1352, y = 1392},
  { x = 1424, y = 1392},
  { x = 1576, y = 1392},
  { x = 1664, y = 1392},
  { x = 1352, y = 1424},
  { x = 1424, y = 1424},
  { x = 1504, y = 1424},
  { x = 1576, y = 1424},
  { x = 1664, y = 1424},
  { x = 1352, y = 1464},
  { x = 1424, y = 1464},
  { x = 1504, y = 1464},
  { x = 1576, y = 1464},
  { x = 1664, y = 1464}
}

local function repeat_lava_spawner()

  if not game:get_value("miniboss_17") then  -- Miniboss not killed.
    nb_spawners_created = nb_spawners_created + 1
    local index = math.random(#spawner_xy)
    map:create_enemy{
      name = "spawner_" .. nb_spawners_created,
      breed = "drakomos_lava_spawner",
      layer = 1,
      x = spawner_xy[index].x,
      y = spawner_xy[index].y,
      direction = 0
    }
    sol.timer.start(5000 + math.random(10000), repeat_lava_spawner)
  end
end

function map:on_started(destination)

  -- miniboss
  map:set_entities_enabled("miniboss_enemy", false)
  map:set_doors_open("miniboss_e_door", true)
  if game:get_value("b866") then
    map:set_doors_open("miniboss_door", true)
  end
end

-- door A
local function door_a_enemy_dead(enemy)

  if not door_a:is_open()
      and not map:has_entities("door_a_enemy") then
    map:move_camera(2248, 648, 250, function()
      sol.audio.play_sound("secret")
      map:open_doors("door_a")
    end)
  end
end

for enemy in map:get_entities("door_a_enemy") do
  enemy.on_dead = door_a_enemy_dead
end

-- miniboss
local function miniboss_enemy_dead(enemy)

  if not map:has_entities("miniboss_enemy") then

    sol.audio.play_music("southern_shrine")
    sol.audio.play_sound("secret")
    map:open_doors("miniboss_door")
    game:set_value("b866", true)
  end
end

for enemy in map:get_entities("miniboss_enemy") do
  enemy.on_dead = miniboss_enemy_dead
end

-- door B hint stones
local function door_b_hint_interaction(npc)

  if not door_b:is_open() then
    local door_b_next = (game:get_value("i1202") or 0) + 1
    local index = tonumber(npc:get_name():match("^door_b_hint_([1-8])$"))
    if index == door_b_next then
      -- correct
      if index < 8 then
        local directions = { 0, 0, 0, 3, 2, 2, 2 }
        game:start_dialog("dungeon_9.3f_door_b_hint_" .. directions[index])
        game:set_value("i1202", index)
      else
        map:move_camera(1928, 1928, 500, function()
          sol.audio.play_sound("secret")
          map:open_doors("door_b")
        end)
      end
    else
      -- wrong
      sol.audio.play_sound("wrong")
      game:set_value("i1202", 0)
    end
  end
end

for npc in map:get_entities("door_b_hint") do
  npc.on_interaction = door_b_hint_interaction
end

-- miniboss
function start_miniboss_sensor:on_activated()

  if not game:get_value("b866")
      and not fighting_miniboss then

    hero:freeze()
    map:close_doors("miniboss_e_door")
    sol.timer.start(2000, repeat_lava_spawner)
    fighting_miniboss = true
    sol.timer.start(1000, function()
      sol.audio.play_music("boss")
      map:set_entities_enabled("miniboss_enemy", true)
      hero:unfreeze()
    end)
  end
end

