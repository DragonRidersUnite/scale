module Scene
  class << self
    def tick_gameplay(args)
      if !args.state.has_focus && args.inputs.keyboard.has_focus
        args.state.has_focus = true
      elsif args.state.has_focus && !args.inputs.keyboard.has_focus
        args.state.has_focus = false
      end

      if !args.state.has_focus || pause_down?(args)
        play_sfx(args, :select)
        return Scene.switch(args, :paused, reset: true)
      end

      draw_bg(args, BLACK)

      labels = []
      labels << label("GAMEPLAY", x: 40, y: args.grid.top - 40, size: SIZE_LG, font: FONT_BOLD)
      args.outputs.labels << labels
    end
  end
end
