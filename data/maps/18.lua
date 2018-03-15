local map = ...
-- Lyriann Shop

function map:on_started(destination)

      if not map:get_game():get_value("b938") then
        -- a bomb bag still available in this shop
        if map:get_game():get_value("b510") then
          -- already found the other one
          bomb_bag_2:remove()
        else
          bomb_bag_3:remove()
        end
      end

      if not map:get_game():get_value("b939") then
        -- a quiver still available in this shop
        if map:get_game():get_value("b941") then
          -- already found the other one
          quiver_2:remove()
        else
          quiver_3:remove()
        end
      end
    end

      if not map:get_game():get_value("b940") then
        -- a wallet still available in this shop
        if map:get_game():get_value("rupee_bag_l") then
          -- already bought the other one
          rupee_bag_l:remove()
        else
          rupee_bag:remove()
      end
    end

  if map:get_game():get_value("lamp") then
    -- lamp has been purchased, remove
    lamp:remove()
end
