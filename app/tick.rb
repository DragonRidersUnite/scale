# Code that only gets run once on game start
def init(args)
  GameSetting.load_settings(args)
  args.gtk.hide_cursor
end

def tick(args)
  init(args) if args.state.tick_count == 0

  # this looks good on non 16:9 resolutions; game background is different
  args.outputs.background_color = TRUE_BLACK.values

  args.state.has_focus ||= true
  args.state.scene ||= :main_menu

  Scene.send("tick_#{args.state.scene}", args)

  debug_tick(args)
end

# code that only runs while developing
# put shortcuts and helpful info here
def debug_tick(args)
  return unless debug?

  debug_label(args, args.grid.right - 24, args.grid.top, "#{args.gtk.current_framerate.round}")

  if args.inputs.keyboard.key_down.zero
    play_sfx(args, :select)
    args.state.render_debug_details = !args.state.render_debug_details
  end

  if args.inputs.keyboard.key_down.i
    play_sfx(args, :select)
    Sprite.reset_all(args)
    args.gtk.notify!("Sprites reloaded")
  end

  if args.inputs.keyboard.key_down.r
    play_sfx(args, :select)
    $gtk.reset
  end
end

# render a label that is only shown when in debug mode and the debug details
# are shown; toggle with +0+ key
def debug_label(args, x, y, text)
  return unless debug?
  return unless args.state.render_debug_details

  args.outputs.debug << { x: x, y: y, text: text }.merge(WHITE).label!
end

# different than background_color... use this to change the bg color for the
# visible portion of the game
def draw_bg(args, color)
  args.outputs.solids << { x: args.grid.left, y: args.grid.bottom, w: args.grid.w, h: args.grid.h }.merge(color)
end
