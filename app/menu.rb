module Menu
  class << self
    # Updates and renders a list of options that get passed through.
    #
    # +options+ data structure:
    # [
    #   {
    #     text: "some string",
    #     on_select: -> (args) { "do some stuff in this lambda" }
    #   }
    # ]
    def tick(args, state_key, options)
      args.state.send(state_key).current_option_i ||= 0
      args.state.send(state_key).hold_delay ||= 0
      menu_state = args.state.send(state_key)

      labels = []

      options.each.with_index do |option, i|
        text = case option.kind
               when :toggle
                 "#{text(option[:key])}: #{text_for_setting_val(option[:setting_val])}"
               else
                 text(option[:key])
               end
        label = label(
          text,
          x: args.grid.w / 2,
          y: 360 + (options.length - i * 52),
          align: ALIGN_CENTER,
          size: SIZE_MD
        )
        label_size = args.gtk.calcstringbox(label.text, label.size_enum)
        labels << label
        if menu_state.current_option_i == i
          args.outputs.solids << {
            x: label.x - (label_size[0] / 1.4) - 24 + (Math.sin(args.state.tick_count / 8) * 4),
            y: label.y - 22,
            w: 16,
            h: 16,
          }.merge(WHITE)
        end
      end

      args.outputs.labels << labels

      move = nil
      if args.inputs.down
        move = :down
      elsif args.inputs.up
        move = :up
      else
        menu_state.hold_delay = 0
      end

      if move
        menu_state.hold_delay -= 1

        if menu_state.hold_delay <= 0
          play_sfx(args, :menu)
          index = menu_state.current_option_i
          if move == :up
            index -= 1
          else
            index += 1
          end

          if index < 0
            index = options.length - 1
          elsif index > options.length - 1
            index = 0
          end
          menu_state.current_option_i = index
          menu_state.hold_delay = 10
        end
      end

      if primary_down?(args.inputs)
        play_sfx(args, :select)
        options[menu_state.current_option_i][:on_select].call(args)
      end
    end

    def text_for_setting_val(val)
      case val
      when true
        text(:on)
      when false
        text(:off)
      else
        val
      end
    end
  end
end
