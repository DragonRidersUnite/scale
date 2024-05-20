module Scene
  def self.tick_settings(args)
    SettingsScene.tick(args)
  end

module SettingsScene
  class << self
    # reachable via main menu or pause menu, allows for configuring the game
    # for the player's preferences.
    def tick(args)
      draw_bg(args, DARK_GREEN)

      options = [
        {
          key: :sfx,
          kind: :toggle,
          setting_val: args.state.setting.sfx,
          on_select: -> (args) do
            GameSetting.save_after(args) do |args|
              args.state.setting.sfx = !args.state.setting.sfx
            end
          end
        },
        {
          key: :music,
          kind: :toggle,
          setting_val: args.state.setting.music,
          on_select: -> (args) do
            GameSetting.save_after(args) do |args|
              args.state.setting.music = !args.state.setting.music
              set_music_vol(args)
            end
          end
        },
        {
          key: :back,
          on_select: -> (args) { Scene.switch(args, :back) }
        },
      ]

      if args.gtk.platform?(:desktop)
        options.insert(options.length - 1, {
          key: :fullscreen,
          kind: :toggle,
          setting_val: args.state.setting.fullscreen,
          on_select: -> (args) do
            GameSetting.save_after(args) do |args|
              args.state.setting.fullscreen = !args.state.setting.fullscreen
              args.gtk.set_window_fullscreen(args.state.setting.fullscreen)
            end
          end
        })
      end

      Menu.tick(args, :settings, options)

      if secondary_down?(args.inputs)
        play_sfx(args, :select)
        options.find { |o| o[:key] == :back }[:on_select].call(args)
      end

      args.outputs.labels << label(:settings, x: args.grid.w / 2, y: args.grid.top - 200, align: ALIGN_CENTER, size: SIZE_LG, font: FONT_BOLD)
    end
  end
end
end
