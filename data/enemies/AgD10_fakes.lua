local enemy = ...

-- Fake Agahnim (with Agahnim V2 of Dungeon 10 2F).

-- Possible positions where he appears.
local positions = {
  {x = 152, y = 160},
  {x = 200, y = 160},
  {x = 248, y = 160},
  {x = 296, y = 160},
  {x = 344, y = 160},
  {x = 392, y = 160},
  {x = 440, y = 160},
  {x = 488, y = 160},
  {x = 536, y = 160},
  {x = 584, y = 160},
  {x = 632, y = 160},
  {x = 152, y = 216},
  {x = 200, y = 216},
  {x = 248, y = 216},
  {x = 296, y = 216},
  {x = 344, y = 216},
  {x = 392, y = 216},
  {x = 440, y = 216},
  {x = 488, y = 216},
  {x = 536, y = 216},
  {x = 584, y = 216},
  {x = 632, y = 216},
  {x = 432, y = 248},
  {x = 640, y = 248},
  {x = 784, y = 248},
  {x = 856, y = 248},
  {x = 432, y = 296},
  {x = 640, y = 296},
  {x = 784, y = 296},
  {x = 856, y = 296},
  {x = 432, y = 424},
  {x = 544, y = 424},
  {x = 640, y = 424},
  {x = 152, y = 464},
  {x = 200, y = 464},
  {x = 248, y = 464},
  {x = 296, y = 464},
  {x = 544, y = 464},
  {x = 792, y = 464},
  {x = 840, y = 464},
  {x = 888, y = 464},
  {x = 152, y = 520},
  {x = 200, y = 520},
  {x = 248, y = 520},
  {x = 296, y = 520},
  {x = 544, y = 520},
  {x = 792, y = 520},
  {x = 840, y = 520},
  {x = 888, y = 520},
  {x = 152, y = 600},
  {x = 200, y = 600},
  {x = 248, y = 600},
  {x = 296, y = 600},
  {x = 544, y = 600},
  {x = 792, y = 600},
  {x = 840, y = 600},
  {x = 888, y = 600},
  {x = 152, y = 656},
  {x = 200, y = 656},
  {x = 248, y = 656},
  {x = 296, y = 656},
  {x = 544, y = 656},
  {x = 792, y = 656},
  {x = 840, y = 656},
  {x = 888, y = 656},
  {x = 320, y = 712},
  {x = 544, y = 712},
  {x = 792, y = 712},
  {x = 840, y = 712},
  {x = 888, y = 712},
  {x = 544, y = 776},
  {x = 792, y = 776},
  {x = 840, y = 776},
  {x = 888, y = 776},
  {x = 544, y = 848},
  {x = 792, y = 848},
  {x = 840, y = 848},
  {x = 888, y = 848},
  {x = 544, y = 920},
  {x = 792, y = 920},
  {x = 840, y = 920},
  {x = 888, y = 920}
}

local nb_sons_created = 0
local blue_fireball_proba = 33  -- Percent.
local next_fireball_sound
local next_fireball_breed
local disappearing = false

function enemy:on_created()

  self:set_life(1)
  self:set_damage(8)
  self:create_sprite("enemies/agahnim_2_fake")
  self:set_optimization_distance(0)
  self:set_size(16, 16)
  self:set_origin(8, 13)
  self:set_position(-100, -100)
  self:set_invincible()
  self:set_attack_consequence("sword", "custom")
  self:set_attack_consequence("arrow", "custom")
  self:set_attack_consequence("hookshot", "custom")
  self:set_attack_consequence("boomerang", "custom")
  self:set_pushed_back_when_hurt(false)
  self:set_push_hero_on_sword(true)
  self:set_can_attack(false)

  local sprite = self:get_sprite()
  sprite:set_animation("stopped")
end

function enemy:on_restarted()

  if not disappearing then
    local sprite = self:get_sprite()
    sprite:fade_out()
    sol.timer.start(self, 500, function()
      self:hide()
    end)
  end
end

function enemy:on_update()

  local sprite = self:get_sprite()
  sprite:set_direction(self:get_direction4_to_hero())
end

function enemy:get_direction4_to_hero()

  local hero = self:get_map():get_entity("hero")
  local angle = self:get_angle(hero)
  local direction4 = (angle + (math.pi / 4)) * 2 / math.pi
  return (math.floor(direction4) + 4) % 4
end

function enemy:hide()

  self:set_position(-100, -100)
  sol.timer.start(self, 500, function()
    self:unhide()
  end)
end

function enemy:unhide()

  local position = (positions[math.random(#positions)])
  self:set_position(position.x, position.y)
  local sprite = self:get_sprite()
  sprite:set_direction(self:get_direction4_to_hero())
  sprite:fade_in()
  sol.timer.start(self, 1000, function()
    self:fire_step_1()
  end)
end

function enemy:fire_step_1()

  local sprite = self:get_sprite()
  sprite:set_animation("arms_up")
  sol.timer.start(self, 1000, function()
    self:fire_step_2()
  end)
  self:set_can_attack(true)
end

function enemy:fire_step_2()

  local sprite = self:get_sprite()
  local blue = math.random(100) <= blue_fireball_proba

  if math.random(5) == 1 then
    sprite:set_animation("preparing_unknown_fireball")
  elseif blue then
    sprite:set_animation("preparing_blue_fireball")
  else
    sprite:set_animation("preparing_red_fireball")
  end

  if blue then
    next_fireball_sound = "cane"
    next_fireball_breed = "blue_fireball_triple"
  else
    next_fireball_sound = "boss_fireball"
    next_fireball_breed = "red_fireball_triple"
  end
  sol.audio.play_sound("boss_charge")
  sol.timer.start(self, 1500, function()
    self:fire_step_3()
  end)
end

function enemy:fire_step_3()

  local sprite = self:get_sprite()
  sprite:set_animation("stopped")
  sol.audio.play_sound(next_fireball_sound)
  sol.timer.start(self, 700, function()
    self:restart()
  end)

  function throw_fire()

    nb_sons_created = nb_sons_created + 1
    self:create_enemy{
      name = self:get_name() .. "_fireball_" .. nb_sons_created,
      breed = next_fireball_breed,
      x = 0,
      y = -21,
    }
  end

  throw_fire()
  local life = self:get_life()
end

function enemy:on_custom_attack_received(attack, sprite)

  sol.audio.play_sound("enemy_hurt")
  self:disappear()
end

function enemy:disappear()

  local sprite = self:get_sprite()
  disappearing = true
  self:set_can_attack(false)
  sprite:fade_out()
  sol.timer.stop_all(self)
  sol.timer.start(self, 500, function()
    self:remove()
  end)
end

function enemy:on_collision_enemy(other_enemy, other_sprite, my_sprite)

  if not other_enemy:get_name():find("fireball") then

    local x = self:get_position()
    if x > 0 then
      -- Collision with another Agahnim.
      sol.timer.stop_all(self)
      self:hide()  -- Go somewhere else.
    end
  end
end

function enemy:receive_bounced_fireball(fireball)

  if fireball:get_name():find("^agahnim_fireball") then
    -- Receive a fireball shot back by the hero: disappear.
    self:disappear()
  end
end

