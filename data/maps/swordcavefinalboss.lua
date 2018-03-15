local map = ...
local game = map:get_game()
-- Dungeon 9 boss

local fighting_boss = false
local torches_error = false
local torches_next = nil
local torches_nb_on = 0
local torches_delay = 20000
local torches_timers = {}
local allow_stone_creation = true
local pickables = {
  { x =  88, y = 141 },
  { x = 136, y = 93 },
  { x = 144, y = 149 },
  { x = 344, y = 93 },
  { x = 392, y = 141 },
  { x = 336, y = 149 },
  { x = 392, y = 349 },
  { x = 344, y = 397 },
  { x = 336, y = 341 },
  { x = 136, y = 397 },
  { x =  88, y = 349 },
  { x = 144, y = 341 },
--[[  { x = 192, y = 325 },
  { x = 288, y = 325 },
  { x = 160, y = 293 },
  { x = 192, y = 165 },
  { x = 288, y = 165 },
  { x = 160, y = 197 },
  { x = 320, y = 197 },
  { x = 320, y = 293 }, --]]
}
local bats = {
  { x =  88, y = 141 },
  { x = 144, y = 149 },
  { x = 392, y = 141 },
  { x = 392, y = 349 },
  { x = 336, y = 341 },
  { x =  88, y = 349 },
  { x = 192, y = 325 },
  { x = 160, y = 293 },
  { x = 288, y = 165 },
  { x = 320, y = 197 },
}
local nb_bats_created = 0
local bonuses_done = {}

function map:on_started(destination)

  if not game:get_value("sword1") then
    -- Sword1 has not been obtained and the Swordless Challenge door is opened.
    if game:get_value("sworddoor") then
    map:move_camera(152, 432, 250, function()
      sol.audio.play_sound("secret")
      map:open_doors("swordless")
    end)
  end
end

  if not game:get_value("swordcaveboss") then
    sol.audio.play_music("ganon_appears")
    boss:set_enabled(true)
    hero:save_solid_ground()
  end

  map:set_entities_enabled("distant_switch", false)
  map:set_entities_enabled("switch_floor", false)
end

function map:on_opening_transition_finished(destination)

  if destination == from_b7 then
    if not game:get_value("swordcaveboss") then
      game:start_dialog("dungeon_9.boss", function()
        sol.audio.play_music("ganon_battle")
    end)
  end
end

if boss ~= nil then
  function boss:on_dying()
    sol.timer.stop_all(map)
    for i = 1, 4 do
      map:get_entity("distant_switch_" .. i):set_activated(false)
    end
    -- Remove small enemies.
    map:remove_entities("boss_")
  end

  function boss:on_dead()

    sol.timer.stop_all(map)
    map:move_camera(328, 432, 250, function()
      sol.audio.play_sound("secret")
      game:set_value("sworddoor", true)
      map:open_doors("sworddoor")
      sol.audio.play_music("zelda")
    end)
  end
end

local function unlight_torches()

  for i = 1, 4 do
    map:get_entity("torch_" .. i):get_sprite():set_animation("unlit")
  end
  for _, t in pairs(torches_timers) do t:stop() end
  torches_timers = {}
end

local function create_pickables()

  for i, v in ipairs(pickables) do

    local i = math.random(100)
    if i <= 60 then
      item_name = "magic_flask"
      variant = 1
    elseif i <= 90 then
      item_name = "heart"
      variant = 1
    elseif i <= 95 then
      item_name = "magic_flask"
      variant = 2
    elseif i <= 99 then
      item_name = "arrow"
      variant = 2
    else
      item_name = "fairy"
      variant = 1
    end
    map:create_pickable{
      treasure_name = item_name,
      treasure_variant = variant,
      x = v.x,
      y = v.y,
      layer = 0
    }
  end
end

local function create_bats()

  for i, v in ipairs(bats) do
    nb_bats_created = nb_bats_created + 1
    map:create_enemy{
      name = "bat_" .. nb_bats_created,
      breed = "fire_bat",
      layer = 0,
      x = v.x,
      y = v.y,
      direction = 0,
      treasure_name = "random"
    }
  end
end

-- Creates a stone that the hero can lift and throw to Ganon.
local function create_stone()

  -- we have to check the position of Ganon and the hero
  local x, y
  local boss_x, boss_y = boss:get_position()
  if boss_x < 240 then
    x = 280
  else
    x = 200
  end
  local hero_x, hero_y = hero:get_position()
  if hero_y < 240 then
    y = 285
  else
    y = 205
  end

  local stone = map:create_destructible{
    x = x,
    y = y,
    layer = 0,
    sprite = "entities/pot",
    destruction_sound = "stone",
    weight = 0,
    damage_on_enemies = 4,
  }
  stone.on_lifting = function()
    allow_stone_creation = true
  end
  allow_stone_creation = false
end

local function torches_solved()

  if floor_down_1:is_enabled() then
    -- phase 1
    if allow_stone_creation then
      sol.audio.play_sound("secret")
      create_stone()
    end
  else
    -- phase 2
    sol.audio.play_sound("secret")
    sol.audio.play_sound("door_open")
    map:set_entities_enabled("switch_floor", true)
    map:set_entities_enabled("distant_switch", true)
    for i = 1, 4 do
      map:get_entity("distant_switch_" .. i):set_activated(false)
      bonuses_done[i] = nil
    end
  end
end

local function distant_switch_activated(switch)

  -- deterministic version: local index = tonumber(switch_name:match("^distant_switch_([1-4])$"))

  local index
  repeat
    index = math.random(4)
  until bonuses_done[index] == nil
  bonuses_done[index] = true

  if index == 1 then
    -- kill small enemies
    if map:get_entities_count("boss_") > 0 then
      sol.audio.play_sound("enemy_killed")
      map:remove_entities("boss_")
    end

  elseif index == 2 then
    -- create the stone that makes Ganon vulnerable
    if allow_stone_creation then
      sol.audio.play_sound("secret")
      create_stone()
    end

  elseif index == 3 then
    -- create pickable items
    sol.audio.play_sound("secret")
    create_pickables()

  else
    sol.audio.play_sound("wrong")
    create_bats()
  end
end

for switch in map:get_entities("distant_switch") do
  switch.on_activated = distant_switch_activated
end

-- Torches on this map interact with the map script
-- because we don't want usual behavior from items/lamp.lua:
-- we want a longer delay and special Ganon interaction
local function torch_interaction(torch)
  game:start_dialog("torch.need_lamp")
end

local function check_torches()

  local states = {
    torch_1:get_sprite():get_animation() == "lit",
    torch_2:get_sprite():get_animation() == "lit",
    torch_3:get_sprite():get_animation() == "lit",
    torch_4:get_sprite():get_animation() == "lit"
  }
  local on = {}

  for i = 1, #states do
    if states[i] then
      on[#on + 1] = i
    end
  end

  if #on == torches_nb_on then
    -- no change
    return
  end

  if #on == #states then
   -- all torches are on
    if torches_error then
      sol.audio.play_sound("wrong")
      torches_error = false
      torches_next = nil
      torches_nb_on = 0
      unlight_torches()
    else
      torches_solved()
      torches_next = on[1] % #states + 1
    end

  elseif #on == 0 then
    -- no torch is on
    torches_error = false
    torches_next = nil

  elseif #on == 1 then
    torches_error = false
    torches_next = on[1] % #states + 1

  elseif not torches_error then

    if #on == torches_nb_on + 1 then
      -- a torch was just turned on
      if states[torches_next] then
        -- it's the correct one
        torches_next = torches_next % #states + 1
      else
	torches_error = true
      end
    end
  end

  torches_nb_on = #on
end

-- Called when fire touches a torch.
local function torch_collision_fire(torch)

  local torch_sprite = torch:get_sprite()
  if torch_sprite:get_animation() == "unlit" then
    -- temporarily light the torch up
    torch_sprite:set_animation("lit")
    check_torches()
    torches_timers[torch] = sol.timer.start(torches_delay, function()
      torch_sprite:set_animation("unlit")
      if distant_switch_1:is_enabled() then
        map:set_entities_enabled("switch_floor", false)
        map:set_entities_enabled("distant_switch", false)
        sol.audio.play_sound("door_closed")
      end
      check_torches()
    end)
  end
end

for torch in map:get_entities("torch") do
  torch.on_interaction = torch_interaction
  torch.on_collision_fire = torch_collision_fire
end

function swordchest:on_opened()

  local variant = 1
  if map:get_game():get_ability("sword") >= 1 then
    -- already got sword 1
    variant = 2
  end
  if map:get_game():get_ability("sword") >= 2 then
    -- already got sword 2
    variant = 3
  end
  hero:start_treasure("sword", variant)
end

function map:on_obtaining_treasure(item, variant, savegame_variable)

  if item:get_name() == "sword" then
    sol.audio.play_music("excalibur")
  end
end

function map:on_obtained_treasure(item, variant, savegame_variable)

  if item:get_name() == "sword" then
    hero:start_victory(function()
      hero:unfreeze()
      sol.audio.play_music("triforce")
    end)
  end
end

end