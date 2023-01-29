# efficient input helpers that all take `args.inputs`

PRIMARY_KEYS = [:j, :z, :space]
def primary_down?(inputs)
  PRIMARY_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    inputs.controller_one.key_down&.a
end
def primary_down_or_held?(inputs)
  primary_down?(inputs) ||
    PRIMARY_KEYS.any? { |k| inputs.keyboard.key_held.send(k) } ||
    (inputs.controller_one.connected &&
     inputs.controller_one.key_held.a)
end

SECONDARY_KEYS = [:k, :x, :backspace]
def secondary_down?(inputs)
  SECONDARY_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    (inputs.controller_one.connected &&
      inputs.controller_one.key_down.b)
end
def secondary_down_or_held?(inputs)
  secondary_down?(inputs) ||
    SECONDARY_KEYS.any? { |k| inputs.keyboard.key_held.send(k) } ||
    (inputs.controller_one.connected &&
     inputs.controller_one.key_held.b)
end

PAUSE_KEYS= [:escape, :p]
def pause_down?(inputs)
  PAUSE_KEYS.any? { |k| inputs.keyboard.key_down.send(k) } ||
    inputs.controller_one.key_down&.start
end

# check for arrow keys, WASD, gamepad, and swipe up
def up?(args)
  args.inputs.up || args.state.swipe.up
end

# check for arrow keys, WASD, gamepad, and swipe down
def down?(args)
  args.inputs.down || args.state.swipe.down
end

# check for arrow keys, WASD, gamepad, and swipe left
def left?(args)
  args.inputs.left || args.state.swipe.left
end

# check for arrow keys, WASD, gamepad, and swipe right
def right?(args)
  args.inputs.right || args.state.swipe.right
end

# called by the main #tick method to keep track of swipes, you likely don't
# need to call this yourself
#
# to check for swipes outside of the directional methods above, use it like
# this:
#
# if args.state.swipe.up
#   # do the thing
# end
#
def track_swipe(args)
  return unless mobile?

  reset_swipe(args) if args.state.swipe.nil? || args.state.swipe.stop_tick
  swipe = args.state.swipe

  if args.inputs.mouse.down
    swipe.merge!({
      start_tick: args.state.tick_count,
      start_x: args.inputs.mouse.x,
      start_y: args.inputs.mouse.y,
    })
  end

  if swipe.start_tick && swipe.start_x && swipe.start_y
    p1 = [swipe.start_x, swipe.start_y]
    p2 = [args.inputs.mouse.x, args.inputs.mouse.y]
    dist = args.geometry.distance(p1, p2)

    if dist > 50 # min distance threshold
      swipe.merge!({
        stop_x: p2[0],
        stop_y: p2[1],
      })

      angle = args.geometry.angle_from(p1, p2)
      swipe.angle = angle
      swipe.dist = dist
      swipe.stop_tick = args.state.tick_count

      if angle > 315 || swipe.angle < 45
        swipe.left = true
      elsif angle >= 45 && angle <= 135
        swipe.down = true
      elsif angle > 135 && angle < 225
        swipe.right = true
      elsif angle >= 225 && angle <= 315
        swipe.up = true
      end
    end
  end
end

# reset the currently tracked swipe
def reset_swipe(args)
  args.state.swipe = { up: false, down: false, right: false, left: false }
end
