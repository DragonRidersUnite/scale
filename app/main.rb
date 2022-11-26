WHITE = [255, 255, 255]

# Access in code with `SPATHS[:my_sprite]`
# Replace with your sprites!
SPATHS = {
  my_sprite: "sprites/my_sprite.png",
}

def debug?
  !!$gtk.production
end

def tick(args)
  debug_tick(args)
end

def debug_tick(args)
  args.outputs.debug << [args.grid.w - 12, args.grid.h, "#{args.gtk.current_framerate.round}", 0, 1, *WHITE].label

  if debug? && args.inputs.keyboard.key_up.i
    SPATHS.each { |_, v| args.gtk.reset_sprite(v) }
    args.gtk.notify!("Sprites reloaded")
  end
end
