TRUE_BLACK = { r: 0, g: 0, b: 0 }
WHITE = { r: 255, g: 255, b: 255 }

# Access in code with `SPATHS[:my_sprite]`
# Replace with your sprites!
SPATHS = {
  my_sprite: "sprites/my_sprite.png",
}

# Code that only gets run once on game start
def init(args)
end

def tick(args)
  init(args) if args.state.tick_count == 0

  args.outputs.background_color = TRUE_BLACK.values

  debug_tick(args)
end

def debug?
  !$gtk.production
end

def debug_tick(args)
  return unless debug?

  args.outputs.debug << [args.grid.w - 12, args.grid.h, "#{args.gtk.current_framerate.round}", 0, 1, *WHITE.values].label

  if args.inputs.keyboard.key_down.i
    SPATHS.each { |_, v| args.gtk.reset_sprite(v) }
    args.gtk.notify!("Sprites reloaded")
  end

  if args.inputs.keyboard.key_down.r
    $gtk.reset
  end
end
