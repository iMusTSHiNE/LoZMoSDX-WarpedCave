local enemy = ...

-- Gelidrak: an ice dragon from Newlink

local head_2 = nil
local head_ball_sprite = nil
local head_2_vulnerable = false
local tail_2 = nil
local tail_ball_sprite = nil
local tail_2_retracted = false
local initial_xy = {}
local current_xy = {}

function enemy:on_created()

  self:set_life(1000000)
  self:set_damage(16)
  self:set_hurt_style("boss")
  self:create_sprite("enemies/gelidrak")
  self:set_size(240, 112)
  self:set_origin(120, 88)
  self:set_obstacle_behavior("flying")
  self:set_layer_independent_collisions(true)
  self:set_push_hero_on_sword(true)

  self:set_invincible()
  self:set_attack_consequence("sword", "protected")
  self:set_attack_consequence("hookshot", "protected")
  self:set_attack_consequence("boomerang", "protected")
  self:set_attack_consequence("arrow", "protected")
  self:set_pushed_back_when_hurt(false)

  tail_ball_sprite = sol.sprite.create("enemies/gelidrak")
  tail_ball_sprite:set_animation("tail_ball")

  initial_xy.x, initial_xy.y = self:get_position()
end

function enemy:on_enabled()

  if head_2 == nil then
    -- Create the head.
    local my_name = self:get_name()
    head_2 = self:create_enemy{
      name = my_name .. "_head_2",
      breed = "swordcave_gelidrak_head_hard",
      x = 0,
      y = 48,
    }
    head_ball_sprite = sol.sprite.create("enemies/gelidrak")
    head_ball_sprite:set_animation("head_ball")

    -- Create the tail.
    local my_name = self:get_name()
    tail_2 = self:create_enemy{
      name = my_name .. "_tail_2",
      breed = "swordcave_gelidrak_tail_hard",
      x = 0,
      y = -112,
    }
  end
end

function enemy:on_restarted()
  local sprite = self:get_sprite()
  if head_2_vulnerable then
    sprite:set_animation("fast")
    self:set_can_attack(false)
  else
    sprite:set_animation("walking")
    local m = sol.movement.create("random")
    m:set_speed(32)
    m:start(self)
  end
  current_xy.x, current_xy.y = self:get_position()
end

function enemy:on_pre_draw()

  if tail_2:exists() then
    local x, y = self:get_position()
    local tail_2_x, tail_2_y = tail_2:get_position()
    self:display_balls(tail_ball_sprite, 6, x, y - 48, tail_2_x, tail_2_y)
  end
end

function enemy:on_post_draw()

  if head_2:exists() then
    local x, y = self:get_position()
    local head_2_x, head_2_y = head_2:get_position()
    self:display_balls(head_ball_sprite, 7, x, y + 8, head_2_x, head_2_y - 16)
  end
end

function enemy:display_balls(ball_sprite, nb_balls, x1, y1, x2, y2)

  local x = x1
  local y = y1
  local x_inc = (x2 - x1) / (nb_balls - 1)
  local y_inc = (y2 - y1) / (nb_balls - 1)
  for i = 1, nb_balls do
    self:get_map():draw_visual(ball_sprite, x, y)
    x = x + x_inc
    y = y + y_inc
  end
end

function enemy:on_position_changed(x, y)

  if head_2 == nil then
    -- Not initialized yet.
    return
  end

  -- The body has just moved: do the same movement to the head and the tail.
  local dx = x - current_xy.x
  local dy = y - current_xy.y
  local tail_2_x, tail_2_y = tail_2:get_position()
  tail_2:set_position(tail_2_x + dx, tail_2_y + dy)
  local head_2_x, head_2_y = head_2:get_position()
  head_2:set_position(head_2_x + dx, head_2_y + dy)
  current_xy.x, current_xy.y = x, y
end

function enemy:head_2_dying()

  if self:get_life() > 0 then
    -- I'm dying: remove the tail.
    tail_2:remove()
  end
end

function enemy:head_2_dead()

  if self:get_life() > 0 then
    -- The head is dead: kill the body too.
    self:hurt(self:get_life())
  end
end

function enemy:head_2_recovered()

  if self:get_life() > 0 then
    -- My head has just stopped being vulnerable.
    head_2_vulnerable = false
    self:set_can_attack(true)
    self:on_restarted()
  end
end

function enemy:tail_2_hurt()

  if self:get_life() > 0 then
    -- The hero just hurt my tail.
    head_2_vulnerable = true
    self:set_can_attack(false)
    local sprite = self:get_sprite()
    sprite:set_animation("fast")
    self:stop_movement()
    head_2:set_vulnerable()
  end
end

function enemy:tail_2_recovered()

  if self:get_life() > 0 then
    -- The tail has recovered its normal position
    self:on_restarted()
  end
end

