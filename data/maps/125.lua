local map = ...
function door:on_opened()

  sol.audio.play_sound("secret")
end

function wall:on_opened()

  sol.audio.play_sound("secret")
end

function rightbombwall:on_opened()

  sol.audio.play_sound("secret")
end